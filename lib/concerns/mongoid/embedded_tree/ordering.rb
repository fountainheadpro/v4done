module Mongoid::EmbeddedTree::Ordering
  extend ActiveSupport::Concern

  included do
    field :previous_id
    index :previous_id

    set_callback :save, :after, :update_links

    validate :position_in_list
  end

  module InstanceMethods
    def first?
      previous_id.nil?
    end

    def last?
      self.next.nil?
    end

    def previous
      _parent.send(self.class.to_s.underscore.pluralize).find(previous_id) unless previous_id.nil?
    end

    def next
      _parent.send(self.class.to_s.underscore.pluralize).where(previous_id: self.id).first
    end

  private
    def update_links
      if first? || previous_id_changed?
        previous_node = _parent.send(self.class.to_s.underscore.pluralize).where(previous_id: self.previous_id).excludes(id: self.id).first
        previous_node.try(:update_attributes, { previous_id: self.id })
      end
    end

    def position_in_list
      errors.add(:previous_id, :invalid) if self.previous_id == self.id
    end
  end
end