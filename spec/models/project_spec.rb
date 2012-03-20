require 'spec_helper'

describe Project do
  it "should have title" do
    project = Project.create
    project.should_not be_valid
    project.errors[:title].should_not be_nil
  end
end