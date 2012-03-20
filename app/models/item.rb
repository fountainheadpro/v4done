class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::EmbeddedTree
  include Mongoid::EmbeddedTree::Ordering

  field :title, :type => String
  field :description, :type => String
  embedded_in :template, inverse_of: :items

  validates :title, presence: true
end
