module Mongoid::EmbeddedTree::Ordering
  extend ActiveSupport::Concern

  included do
    field :previous_id
    index :previous_id
    field :next_id
    index :next_id

    set_callback :save, :after, :update_links

    validate :position_in_list
  end

  module InstanceMethods
    def first?
      previous_id.nil?
    end

    def last?
      next_id.nil?
    end

    def previous
      _parent.send(self.class.to_s.underscore.pluralize).find(previous_id) unless previous_id.nil?
    end

    def next
      _parent.send(self.class.to_s.underscore.pluralize).find(next_id) unless next_id.nil?
    end

  private
    def update_links
      if previous_id_changed? && self.previous.next_id != self.id
        self.previous.update_attribute :next_id, self.id
      end
      if next_id_changed? && self.next.previous_id != self.id
        self.next.update_attribute :previous_id, self.id
      end
    end

    def position_in_list
      errors.add(:next_id, :invalid) if self.next_id == self.id
      errors.add(:previous_id, :invalid) if self.previous_id == self.id
    end
  end
end