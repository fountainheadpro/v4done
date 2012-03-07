require 'spec_helper'

describe Mongoid::EmbeddedTree::Ordering do
  shared_examples_for "a first node" do
    its (:previous_id) { should be_nil }
    its (:previous) { should be_nil }
    it { should be_a_first }
  end

  shared_examples_for "a last node" do
    its (:next_id) { should be_nil }
    its (:next) { should be_nil }
    it { should be_a_last }
  end

  shared_examples_for "a previous node" do
    its (:next_id) { should_not be_nil }
    its (:next) { should_not be_nil }
    it { should_not be_a_last }
  end

  shared_examples_for "a next node" do
    its (:previous_id) { should_not be_nil }
    its (:previous) { should_not be_nil }
    it { should_not be_a_first }
  end

  describe "A node" do
    let(:container) { Container.create name: "A Container"}
    let(:node) { Node.new name: "A Node"}
    subject { node }

    before(:each) do
      container.nodes << node
      node.reload
    end

    it { should be_valid }
    it_should_behave_like "a first node"
    it_should_behave_like "a last node"

    context "when adding new node after this one" do
      let(:new_node) { Node.new(name: "New Node", previous_id: node.id)}

      before(:each) do
        container.nodes << new_node
        new_node.reload
      end

      it_should_behave_like "a first node"
      it_should_behave_like "a previous node"

      it "should be able to access new node as next item" do
        node.reload
        node.next.should eq(new_node)
      end

      it "should prevent cycles" do
        node.next_id = node.id
        node.should_not be_valid
        node.errors[:next_id].should_not be_nil
      end

      context "new node" do
        subject { new_node }

        it_should_behave_like "a last node"
        it_should_behave_like "a next node"

        it "should be able to access the existing node as previous item" do
          new_node.reload
          new_node.previous.should eq(node)
        end

        it "should prevent cycles" do
          new_node.next_id = new_node.id
          new_node.should_not be_valid
          new_node.errors[:next_id].should_not be_nil
        end
      end
    end
  end
end