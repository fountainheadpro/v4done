module Mongoid::EmbeddedTree::Ordering
  extend ActiveSupport::Concern

  included do
    field :previous_id, type: BSON::ObjectId
    index :previous_id

    set_callback :save, :after, :update_links
    set_callback :destroy, :after, :update_links

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
      if destroyed? && !last?
        _parent.reload
        self.next.update_attributes previous_id: self.previous_id
      elsif changed? && (first? || previous_id_changed?)
        self.siblings.where(previous_id: self.previous_id).first.try(:update_attributes, { previous_id: self.id })
      end
    end

    def position_in_list
      errors.add(:previous_id, :invalid) if self.previous_id == self.id
    end
  end

  module ClassMethods
    def each_with_position(id = nil, &block)
      where(previous_id: id).each do |node|
        block.call(node)
        each_with_position(node.id, &block)
      end
    end
  end
end
