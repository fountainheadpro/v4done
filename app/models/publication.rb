class Publication
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  embeds_one :template
end
