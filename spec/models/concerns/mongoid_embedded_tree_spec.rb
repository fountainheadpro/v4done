require 'spec_helper'

describe Mongoid::EmbeddedTree do
  shared_examples_for "a root node" do
    its (:parent_ids) { should be_empty }
    its (:parent) { should be_nil }
    it { should be_root }
    it "presents in roots" do
      container.nodes.roots.should include(subject)
    end
  end

  shared_examples_for "a leaf node" do
    its (:children) {should eq([])}
    it { should be_a_leaf }
  end

  shared_examples_for "a parent node" do
    its (:children) { should_not eq([]) }
    it { should_not be_a_leaf }
  end

  shared_examples_for "a child node" do
    its (:parent_ids) { should_not be_empty }
    its (:parent_ids) { should include(parent.id) }
    its (:parent) { should eq(parent) }
    it { should_not be_root }
    it "not presents in roots" do
      container.nodes.roots.should_not include(subject)
    end
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
    it_should_behave_like "a leaf node"
    it_should_behave_like "a root node"

    it "should exist 1 nodes" do
      container.nodes.count.should be(1)
    end

    context "when adding a child" do
      let(:parent) { node }
      let(:child) { Node.new(name: "A Child", parent_id: parent.id)}

      before(:each) do
        container.nodes << child
        child.reload
      end

      it_should_behave_like "a parent node"
      it_should_behave_like "a root node"

      it "should change the children count" do
        expect{
          container.nodes << Node.new(name: "another child", parent_id: parent.id)
        }.to change{node.children.count}.by(1)
      end

      it "should exist 2 nodes" do
        container.nodes.count.should be(2)
      end

      it "should have 1 child" do
        node.children.count.should be(1)
      end

      it "should be able to access the child" do
        node.children.first.should eq(child)
      end

      it "a child should know it's parent" do
        child.parent.should eq(parent)
      end

      it "a child should have correct path" do
        child.parent_ids.should eq([parent.id])
      end

      context "the child" do
        subject { child }
        it_should_behave_like "a leaf node"
        it_should_behave_like "a child node"
      end
    end
  end
end