require 'spec_helper'

describe Action do
  it "should have title" do
    action = Action.create
    action.should be_invalid
    action.errors[:title].should_not be_nil
  end
end