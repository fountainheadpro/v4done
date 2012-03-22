class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  field :title, type: String
  field :description, type: String
  embeds_many :actions, inverse_of: :project

  validates :title, presence: true

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