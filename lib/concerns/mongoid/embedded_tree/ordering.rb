module Mongoid::EmbeddedTree::Ordering
  extend ActiveSupport::Concern

  included do
    field :previous_id
    index :previous_id
    field :next_id
    index :next_id
  end

  module InstanceMethods
    def first?
      true
    end

    def last?
      true
    end

    def previous
    end

    def next
    end
  end
end