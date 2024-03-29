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

  describe "A list of three nodes" do
    let(:container) { Container.create name: "Container" }

    before(:each) do
      @node1 = container.nodes.create name: "Node 1"
      @node2 = container.nodes.create name: "Node 2", previous_id: @node1.id
      @node3 = container.nodes.create name: "Node 3", previous_id: @node2.id
    end

    context "when adding new node between first and second," do
      before(:each) do
        @new_node = container.nodes.create name: "Nodes 4", previous_id: @node1.id
      end

      it "first node should be able to access new node as next" do
        @node1.next.should eq(@new_node)
      end

      it "second node should be able to access new node as previous" do
        @node2.previous.should eq(@new_node)
      end

      context "new node" do
        it "should be able to access first node as previous" do
          @new_node.previous.should eq(@node1)
        end

        it "should be able to access second node as next" do
          @new_node.next.should eq(@node2)
        end
      end
    end

    context "when destroying second node" do
      before(:each) do
        @node2.destroy
        container.reload
        @node1 = container.nodes.first
        @node3 = container.nodes.last
      end

      context "the first node" do
        subject { @node1 }

        it_should_behave_like "a first node"

        it "should be able to access the last node as next" do
          @node1.next.should eq(@node3)
        end
      end

      context "the last node" do
        subject { @node3 }

        it_should_behave_like "a last node"

        it "should be able to access the first node as previous" do
          @node3.previous.should eq(@node1)
        end
      end
    end

    context "when destroying first node," do
      before(:each) do
        @node1.destroy
        container.reload
        @node2 = container.nodes.first
        @node3 = container.nodes.last
      end

      context "the second node" do
        subject { @node2 }

        it_should_behave_like "a first node"

        it "should be able to access the last node as next" do
          @node2.next.should eq(@node3)
        end
      end

      context "the last node" do
        subject { @node3 }

        it_should_behave_like "a last node"

        it "should be able to access the second node as previous" do
          @node3.previous.should eq(@node2)
        end
      end
    end

    context "when destroying last node," do
      before(:each) do
        @node3.destroy
        container.reload
        @node1 = container.nodes.first
        @node2 = container.nodes.last
      end

      context "the first node" do
        subject { @node1 }

        it_should_behave_like "a first node"

        it "should be able to access the second node as next" do
          @node1.next.should eq(@node2)
        end
      end

      context "the second node" do
        subject { @node2 }

        it_should_behave_like "a last node"

        it "should be able to access the first node as previous" do
          @node2.previous.should eq(@node1)
        end
      end
    end
  end

  describe "Iteration" do
    let(:container) { Container.create name: "Container" }

    before(:each) do
      @bad_node1 = container.nodes.create name: "Bad Node 1"
      @bad_node2 = container.nodes.create name: "Bad Node 2"
      @bad_node3 = container.nodes.create name: "Bad Node 3"
      @node5 = container.nodes.create name: "Node 5"
      @node3 = container.nodes.create name: "Node 3"
      @node4 = container.nodes.create name: "Node 4", previous_id: @node3.id
      @node1 = container.nodes.create name: "Node 1"
      @node2 = container.nodes.create name: "Node 2", previous_id: @node1.id
      @bad_node1.update_attribute :previous_id, @node1.id # update_attribute don't call callbacks
      @bad_node2.update_attribute :previous_id, @node1.id
      @bad_node3.update_attribute :previous_id, @node3.id
    end

    describe ".each_with_position" do
      it "should return nodes in correct position" do
        result = []
        container.nodes.each_with_position do |node|
          result << node
        end
        result.count.should == 8
        result[0].should eq(@node1)
        result[1].should eq(@bad_node2)
        result[2].should eq(@bad_node1)
        result[3].should eq(@node2)
        result[4].should eq(@node3)
        result[5].should eq(@bad_node3)
        result[6].should eq(@node4)
        result[7].should eq(@node5)
      end
    end
  end
end