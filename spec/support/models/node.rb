class Node
  include Mongoid::Document
  include Mongoid::EmbeddedTree
  include Mongoid::EmbeddedTree::Ordering

  embedded_in :container, inverse_of: :nodes

  field :name
end