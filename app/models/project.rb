class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  field :title, type: String
  field :description, type: String
  field :owner, type: Hash
  embeds_many :actions, inverse_of: :project
  belongs_to :publication

  validates :title, presence: true

  def self.create_from_publication(publication, additional_atts = {})
    project = self.create({ publication: publication, title: publication.template.try(:title), description: publication.template.try(:description) }.merge(additional_atts))
    publication.template.try(:items).try(:each)do |item|
      project.actions << Action.new(
        id: item.id,
        title: item.title,
        description: item.description,
        parent_id: item.parent_id,
        previous_id: item.previous_id
      )
    end
    project
  end

  def as_json(options = {})
    options ||= {}
    super({ include: [:actions] })
  end
end

