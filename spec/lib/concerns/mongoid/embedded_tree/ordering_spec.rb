require 'spec_helper'

describe Mongoid::EmbeddedTree::Ordering do
  shared_examples_for "a first node" do
    its (:previous_id) { should be_nil }
    its (:previous) { should be_nil }
    it { should be_a_first }
  end

  shared_examples_for "a last node" do
    its (:next) { should be_nil }
    it { should be_a_last }
  end

  shared_examples_for "a previous node" do
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

    context "when adding new node" do
      it "should prevent cycles" do
        node.update_attributes previous_id: node.id
        node.should_not be_valid
        node.errors[:previous_id].should_not be_nil
        node.reload
        node.previous_id.should_not == node.id
      end
    end

    context "when adding new node after this one," do
      let(:new_node) { Node.new(name: "New Node", previous_id: node.id.to_s)}

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

      context "new node" do
        subject { new_node }

        it_should_behave_like "a last node"
        it_should_behave_like "a next node"

        it "should be able to access the existing node as previous item" do
          new_node.reload
          new_node.previous.should eq(node)
        end
      end
    end

    context "when adding new node before this one," do
      let(:new_node) { Node.new(name: "New Node", previous_id: nil)}

      before(:each) do
        container.nodes << new_node
        new_node.reload
      end

      it_should_behave_like "a last node"
      it_should_behave_like "a next node"

      it "should be able to access new node as previous item" do
        node.reload
        node.previous.should eq(new_node)
      end

      context "new node" do
        subject { new_node }

        it_should_behave_like "a first node"
        it_should_behave_like "a previous node"

        it "should be able to access the existing node as next item" do
          new_node.reload
          new_node.next.should eq(node)
        end
      end
    end

    context "when adding a child node," do
      let(:child) { Node.new(name: "A Child", parent_id: node.id)}

      before(:each) do
        container.nodes << child
        child.reload
      end

      it_should_behave_like "a first node"
      it_should_behave_like "a last node"

      context "the child" do
        subject { child }

        it_should_behave_like "a first node"
        it_should_behave_like "a last node"
      end
    end
  end

  describe "A list of nodes" do
    let(:container) { Container.create name: "Container" }

    before(:each) do
      @node1 = container.nodes.create name: "Node 1"
      @node2 = container.nodes.create name: "Node 2", previous_id: @node1.id
      @node3 = container.nodes.create name: "Node 3", previous_id: @node2.id
    end

    context "when adding new node between existing," do
      before(:each) do
        @new_node = container.nodes.create name: "Nodes 4", previous_id: @node1.id, next_id: @node2.id
      end

      it "first existing node should be able to access new node as next item" do
        @node1.next.should eq(@new_node)
      end

      it "second existing node should be able to access new node as previous item" do
        @node2.previous.should eq(@new_node)
      end

      context "new node" do
        it "should be able to access first existing node as previous item" do
          @new_node.previous.should eq(@node1)
        end

        it "should be able to access second existing node as next item" do
          @new_node.next.should eq(@node2)
        end
      end
    end

    context "when destroy some node" do
    end
  end
end