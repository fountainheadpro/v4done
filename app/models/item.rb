class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::EmbeddedTree
  include Mongoid::EmbeddedTree::Ordering

  field :title, :type => String
  field :description, :type => String
  validates :title, presence: true

  embedded_in :template, inverse_of: :items

  def destroy
    #self.template.items[self.previous_id]
    super()
  end

end
