class Spark

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include CreatedBy

  field :title, :type => String
  field :body, :type => String
  field :repeating_pattern, :type=> String #cron style repeating pattern
  field :is_draft, :type => Boolean, :default => true

  validates :title, presence: true

  def destroy
    #self.template.items[self.previous_id]
    super()
  end

end