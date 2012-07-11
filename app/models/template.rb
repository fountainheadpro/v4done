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
  #has_one :publication, foreign_key: 'template._id'

  def publications
    Publication.all(conditions: { "creator_id" => creator_id, "template._id" => id })
  end

  # TODO: remove all duplicates of publications and then replace this method with has_one
  def publication
    Publication.first(conditions: { "creator_id" => creator_id, "template._id" => id }, sort: [:created_at, :desc])
  end

  def active_items
    items.not_in(parent_ids: items.deleted.map(&:id))
  end

  def publication_id
    publication.try(:_id)
  end

  def serializable_hash(options = {})
    super({ methods: [:publication_id] }.merge(options || {}))
  end

  def destroy
    super()
    p=publication
    p.destroy if p
  end

end
