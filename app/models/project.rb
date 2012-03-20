class Project
  include Mongoid::Document

  field :title, type: String

  validates_presence_of :title
end