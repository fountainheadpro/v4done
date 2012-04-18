class Publication
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  embeds_one :template

  def self.newest()
    where(:created_at => {'$gte' => DateTime.now-300.days,'$lt' => DateTime.now}).asc(:updated_at).entries
  end

end
