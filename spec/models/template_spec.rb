require 'spec_helper'

describe Template do
  describe ".active_items" do
    let(:template) { FactoryGirl.create(:template_with_subitems, items_count: 2, subitems_count: 2) }

    it "should return all active items" do
      template.active_items.count.should == 6

      template.items.roots.last.destroy

      template.active_items.count.should == 3
    end
  end
end