class Action
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::EmbeddedTree
  include Mongoid::EmbeddedTree::Ordering

  field :title, type: String
  field :description, type: String
  field :status, type: Boolean, default: false
  embedded_in :project, inverse_of: :actions

  validates :title, presence: true
end