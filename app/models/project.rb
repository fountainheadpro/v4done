class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  field :title, type: String
  field :description, type: String
  embeds_many :actions, inverse_of: :project

  validates :title, presence: true
end