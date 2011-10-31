class Action
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Tree

  alias :context :parent

  field :title, :type => String
  field :notes, :type => String

  embeds_many :comments

  validates_presence_of :title

  belongs_to :creator, :class_name=>"User"
  belongs_to :assigned, :class_name=>"User"

end
