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

  end
end