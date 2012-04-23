class Template
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include CreatedBy

  field :title, type: String
  field :description, :type => String
  attr_accessible :title, :description
  validates :title, presence: true

  embeds_many :items, inverse_of: :template

  def publications
    Publication.all(conditions: { "creator_id" => creator_id, "template._id" => id })
  end
end
