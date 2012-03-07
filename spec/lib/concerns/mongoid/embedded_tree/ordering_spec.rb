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

      context "new node" do
        subject { new_node }

        it_should_behave_like "a last node"
        it_should_behave_like "a next node"

        it "should be able to access the existing node as previous item" do
          new_node.reload
          new_node.previous.should eq(node)
        end

        it "should prevent cycles" do
          new_node.update_attributes previous_id: new_node.id
          new_node.should_not be_valid
          new_node.errors[:previous_id].should_not be_nil
          new_node.reload
          new_node.previous_id.should_not == new_node.id
        end
      end
    end

    context "when adding new node before this one" do
      let(:new_node) { Node.new(name: "New Node", next_id: node.id)}

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

        it "should prevent cycles" do
          new_node.update_attributes next_id: new_node.id
          new_node.should_not be_valid
          new_node.errors[:next_id].should_not be_nil
          new_node.reload
          new_node.next_id.should_not == new_node.id
        end
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

    context "when destroying some node from the midle of the list," do
      before(:each) do
        @node2.destroy
      end

      it "the previous of destroyed should be able to access the next of destroyed as next item" do
        @node1.next.should eq(@node3)
      end

      it "the ndext of destroyed should be able to access the previous of destroyed as previous item" do
        @node3.previous.should eq(@node1)
      end
    end

    context "when destroying first node," do
      before(:each) do
        @node1.destroy
      end
      it { @node2.previous_id.should be_nil }
    end

    context "when destroying last node," do
      before(:each) do
        @node3.destroy
      end
      it { @node2.next_id.should be_nil }
    end
  end
end