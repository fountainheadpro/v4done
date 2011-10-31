class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  field :body, :type => String

  embedded_in :action, :inverse_of => :comments

end
