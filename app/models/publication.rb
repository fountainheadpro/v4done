class Publication
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedBy

  embeds_one :template

  def self.newest()
    template_pub_map = {}
    all_publications = where(:created_at => {'$gte' => DateTime.now-300.days,'$lt' => DateTime.now}).desc(:created_at).entries
    all_publications.each do |p|
      if template_pub_map[p.template.id].present?
        template_pub_map[p.template.id] = p if template_pub_map[p.template.id].created_at < p.created_at
      else
        template_pub_map[p.template.id] = p
      end
    end
    template_pub_map.values.sort { |x,y| y.created_at <=> x.created_at}
  end

end
