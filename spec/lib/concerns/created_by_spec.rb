require 'spec_helper'

describe CreatedBy do
  let(:user) { FactoryGirl.create(:user) }

  context "when user create new item" do
    let(:item) { TestItem.create creator: user }

     context "the item" do
       it "should have creator" do
         item.creator.should eq(user)
       end
     end
  end
end