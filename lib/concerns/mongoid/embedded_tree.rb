module Mongoid::EmbeddedTree
  extend ActiveSupport::Concern

  included do
    field :parent_id
    index :parent_id
    field :parent_ids, :type => Array, :default => []
    index :parent_ids

    scope :roots, where(parent_id: nil)

    set_callback :validation, :before, :update_path
    set_callback :destroy, :after, :destroy_children

    validate :position_in_tree
  end

  module InstanceMethods
    def root?
      parent_id.nil?
    end

    def leaf?
      children.empty?
    end

    def parent
      _parent.send(self.class.to_s.underscore.pluralize).find(parent_id) unless parent_id.nil?
    end

    def children
      _parent.send(self.class.to_s.underscore.pluralize).where(parent_id: id)
    end

    def update_path
      self.parent_id = BSON::ObjectId.convert(Item, self.parent_id)
      self.parent_ids = parent.parent_ids + [self.parent_id] unless self.parent_id.nil?
    end

    def destroy_children
      children.destroy_all
    end

  private
    def position_in_tree
      errors.add(:parent_id, :invalid) if self.parent_ids.include?(self.id)
    end
  end
end