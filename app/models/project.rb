class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  field :title, type: String
  field :description, type: String
  embeds_many :actions, inverse_of: :project
  belongs_to :publication

  validates :title, presence: true

  def self.create_from_publication(publication)
    project = self.create publication: publication, title: publication.template.title, description: publication.template.description
  end
end