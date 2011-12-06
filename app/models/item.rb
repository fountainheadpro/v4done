class Item
  include Mongoid::Document
  include Mongoid::Timestamps 
  field :title, :type => String

  embedded_in :template, inverse_of: :items
  embeds_many :items, class_name: 'Item', inverse_of: :parent
  embedded_in :parent, class_name: 'Item', inverse_of: :items
  accepts_nested_attributes_for :items, allow_destroy: true
end
