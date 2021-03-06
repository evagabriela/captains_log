class Vote < ActiveRecord::Base
  attr_accessible :up, :down, :votable_id, :votable_type, :user
  
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :user_id, :votable_id, :votable_type, presence: true
  validates_uniqueness_of :user_id, scope: [:votable_type, :votable_id]

  def change_vote(click_value)
    key = click_value.key("true")
    if !self.up && !self.down
      self[key] = true
    elsif self.up && !self.down
      self.up = false if key == "down"
    else
      self.down = false if key == "up"
    end
  end

end
