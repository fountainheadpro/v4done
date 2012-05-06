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

        it "should return project" do
          Export::Actions.export(params).should eq(project)
        end
      end

      context "when project is not created" do
        let(:project) { mock_model(Project, valid?: false) }
        it_should_behave_like "failed export"
      end
    end
  end
end