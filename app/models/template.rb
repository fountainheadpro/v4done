class Template
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  field :title, :type => String

  validates :title, presence: true
end
