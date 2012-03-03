class Node
  include Mongoid::Document
  include Mongoid::EmbeddedTree

  embedded_in :container, inverse_of: :nodes

  field :name
end