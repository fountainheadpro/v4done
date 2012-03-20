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
end