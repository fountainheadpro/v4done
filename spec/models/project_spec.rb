require 'spec_helper'

describe Project do
  it "should have title" do
    project = Project.create
    project.should_not be_valid
    project.errors[:title].should_not be_nil
  end

  it "can have ordered tree of actions" do
    project = Factory.create(:project_with_actions, actions_count: 2, subactions_count: 3)
    project.actions.count.should eq(2 + 2*3)
    project.actions.roots.count.should eq(2)
    project.actions.roots.first.children.count.should eq(3)
    project.actions.roots.last.children.count.should eq(3)
  end

  describe "when creating from a publication" do
    let(:publication) { Factory.create(:publication) }
    let(:project) { Project.create_from_publication(publication) }

    it "should return project" do
      project.should be_a(Project)
    end

    it "should be able to access the publication" do
      project.publication.should eq(publication)
    end

    it "should have the same title and description as the publication" do
      project.title.should eq(publication.template.title)
      project.description.should eq(publication.template.description)
    end

    it "should have the same number of actions as the publication" do
      project.actions.count.should eq(publication.template.items.count)
    end

    context "the actions" do
      it "should have the same titles and descriptions" do
        publication.template.items.each do |item|
          project.actions.where(title: item.title, description: item.description).should exist
        end
      end
    end
  end
end