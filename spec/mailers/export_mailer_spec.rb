require "spec_helper"

describe ExportMailer do
  describe "actions" do
    let(:project) { mock_model(Project, title: 'Actions', owner: { 'email' => 'to@example.org' } ) }
    let(:mail) { ExportMailer.actions(project) }

    it "renders the headers" do
      mail.subject.should eq("Actions")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["subscription@actions.im"])
    end

    it "renders the body" do
      mail.body.encoded.should match(project_url(project))
    end
  end

end
