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

  def init(publication)
    self.title=publication.template.title
    items_depth_first(self,publication.template.items.roots)
    self.save!
    self
  end

  private
  def items_depth_first(project,items, action=nil)
    items.each{|i|
      a=project.actions.new.init(i)
      if a.valid?(:create)
        if action.present?
          a.parent_id=action.id
          a.update_path
        end
        items_depth_first(project,i.children, a)
      end
    }
  end
  
  
end

