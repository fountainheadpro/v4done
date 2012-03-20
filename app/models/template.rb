class Template
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  field :title, type: String
  field :description, :type => String
  embeds_many :items, inverse_of: :template

  validates :title, presence: true

  def publications
    Publication.all(conditions: { "creator_id" => creator_id, "template._id" => id })
  end
end
