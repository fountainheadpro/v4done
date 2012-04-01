require 'spec_helper'

describe Export::Actions do
  shared_examples_for "failed export" do
    it "should return false" do
      expect do
        Export::Actions.export(params).should be_false
      end.to_not change{Project.count}
    end
  end

  describe "Exporting" do
    context "when params is empty" do
      let(:params) { {} }
      it_should_behave_like "failed export"
    end

    context "when publication not exists" do
      let(:params) { { publication_id: 1 } }

      before(:each) do
        Publication.delete_all
      end

      it_should_behave_like "failed export"
    end

    context "when params is valid" do
      let(:publication) { mock_model(Publication) }
      let(:params) { { publication_id: publication.id } }
      let(:project) { mock_model(Project, valid?: false) }

      before(:each) do
        Publication.stub(:exists?).with(conditions: { id: publication.id }).and_return(true)
        Publication.stub(:find).with(publication.id).and_return(publication)
        Project.stub(:create_from_publication).and_return(project)
      end

      it "should create project from publication" do
        Project.should_receive(:create_from_publication).with(publication, {}).and_return(project)
        Export::Actions.export(params)
      end

      context "when project successfuly created" do
        let(:project) { mock_model(Project, valid?: true, owner: {}) }

        it "should return true" do
          Export::Actions.export(params).should be_true
        end

        it "should send email if user provide email address" do
          email = 'test@test.org'
          project.stub(:owner).and_return({ 'email' => email })
          mailer = double("mailer")
          mailer.should_receive(:deliver)
          ExportMailer.should_receive(:actions).with(project).and_return(mailer)
          Export::Actions.export(params.merge({ email_or_phone_number: email }))
        end

        it "should send sms if user provide phone number" do
          phone_number = '0123456789'
          project.stub(:owner).and_return({ 'phone_number' => phone_number })
          sms = double("sms")
          sms.should_receive(:deliver_sms)
          Moonshado::Sms.should_receive(:new).with(phone_number, Rails.application.routes.url_helpers.project_actions_url(project, host: 'test.org')).and_return(sms)
          Export::Actions.export(params.merge({ email_or_phone_number: phone_number }))
        end
      end

      context "when project is not created" do
        let(:project) { mock_model(Project, valid?: false) }
        it_should_behave_like "failed export"
      end
    end
  end
end