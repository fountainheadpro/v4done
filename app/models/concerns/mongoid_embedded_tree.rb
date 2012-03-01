module Mongoid::EmbeddedTree
  extend ActiveSupport::Concern

  included do
    field :parent_id
    field :parent_ids, :type => Array, :default => []
    index :parent_ids

    scope :roots, where(parent_id: nil)

    set_callback :save, :before, :update_path
  end

  module InstanceMethods
    def parent
      _parent.nodes.find(parent_id) unless parent_id.nil?
    end

    def root?
      parent_id.nil?
    end

    def leaf?
      children.empty?
    end

    def children
      _parent.nodes.where(parent_id: id)
      # [self.class.to_s.underscore.pluralize.to_sym]
    end

    def update_path
      self.parent_ids = parent.parent_ids + [self.parent_id] unless self.parent_id.nil?
    end
  end
end