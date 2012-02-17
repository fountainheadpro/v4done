class Template
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  field :title, type: String
  embeds_many :items, inverse_of: :template
  accepts_nested_attributes_for :items, allow_destroy: true

  validates :title, presence: true

  def publications
    Publication.all(conditions: { "creator_id" => creator_id, "template._id" => id })
  end
end
