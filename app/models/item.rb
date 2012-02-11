class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :type => String
  field :parent_id, :type => String

  embedded_in :template, inverse_of: :items

  def parent_item
    template.items.find(parent_id) unless parent_id.nil?
  end

  def child_items
    template.items.where(parent_id: id.to_s)
  end
end
