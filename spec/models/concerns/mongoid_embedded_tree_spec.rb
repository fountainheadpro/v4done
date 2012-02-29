require 'spec_helper'

describe Mongoid::EmbeddedTree do
  shared_examples_for "a root node" do
    its (:parent_ids) { should be_empty }
    its (:parent) { should be_nil }
    its (:root) { should be_nil }
    it { should be_root }
  end

  shared_examples_for "a leaf node" do
    its (:children) {should eq([])}
    it { should be_a_leaf }
  end

  describe "A node" do
    let(:container) { Container.create :name => "A Container"}
    let(:node) { container.nodes.create :name => "A Node"}
    subject {node}

    it { should be_valid }
    it_should_behave_like "a leaf node"
    it_should_behave_like "a root node"
  end
end