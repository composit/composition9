class Pause < ActiveRecord::Base
  has_many :user_pauses
  belongs_to :user

  validates_presence_of :title, :interval, :allowed_length, :user_id
  validates_numericality_of :interval, :allowed_length

  def new_user_pause
    UserPause.new( :user_id => user_id, :pause_id => id )
  end

  def is_ready?
    if user_pause = user_pauses.find( :first, :order => "end_time DESC" )
      ready = (user_pause.end_time + interval.minutes < Time.zone.now)
    else
      ready = true
    end
    ready
  end
end
