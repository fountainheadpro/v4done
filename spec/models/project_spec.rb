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

      it "should have the same hierarchy" do
        publication.template.items.each do |item|
          action = project.actions.where(title: item.title, description: item.description).first
          if item.root?
            action.should be_root
          else
            action.should_not be_root
            parent_action = project.actions.where(title: item.parent.title, description: item.parent.description).first
            action.parent.should eq(parent_action)
          end
        end
      end

      it "should have the same order" do
        publication.template.items.each do |item|
          action = project.actions.where(title: item.title, description: item.description).first
          if item.first?
            action.should be_first
          else
            action.should_not be_first
            previous_action = project.actions.where(title: item.previous.title, description: item.previous.description).first
            action.previous.should eq(previous_action)
          end
          if item.last?
            action.should be_last
          else
            action.should_not be_last
            next_action = project.actions.where(title: item.next.title, description: item.next.description).first
            action.next.should eq(next_action)
          end
        end
      end
    end

    context "when template is nil" do
      before(:each) do
        publication.template = nil
        publication.save
      end

      it { should be_a(Project) }
      it { should be_invalid }
      it { should be_new_record }
    end

    context "when publication is nil" do
      before(:each) do
        publication = nil
      end

      it { should be_a(Project) }
      it { should be_invalid }
      it { should be_new_record }
    end
  end
end