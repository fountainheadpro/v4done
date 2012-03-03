class Container
  include Mongoid::Document

  embeds_many :nodes, inverse_of: :container

  field :name
end