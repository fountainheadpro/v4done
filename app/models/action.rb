class Action
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Tree
  include CreatedBy

  after_save :create_list


  alias :context :parent

  field :completed, :type => Boolean
  field :title, :type => String
  field :notes, :type => String

  embeds_many :comments

  validates_presence_of :title

  belongs_to :assigned, :class_name=>"User"

  def create_list
   return if notes.nil?
   actions=self.notes.split("\n")
   if actions.size>1
     actions.each{|l|
       if l.present?
         if l.length<100
          Action.create(:title=>l, :creator=>self.creator, :parent=>self)
         else
           Action.create(:title=>l.slice(0..99), :notes=>l, :creator=>self.creator, :parent=>self)
         end
       end
     }
     update_attribute(:notes,"")
   end
  end

  def user
    creator.name
  end

  def to_json
   super(:methods=>:user)
  end


end
