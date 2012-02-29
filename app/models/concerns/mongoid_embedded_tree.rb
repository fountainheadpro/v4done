module Mongoid::EmbeddedTree
  extend ActiveSupport::Concern

  included do
    field :parent_id
    field :parent_ids, :type => Array, :default => []
    index :parent_ids
  end

  module InstanceMethods
    def parent
      nil
    end

    def root?
      true
    end

    def root
      nil
    end

    def leaf?
      true
    end

    def children
      []
    end
  end
end