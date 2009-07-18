class UserAlert < ActiveRecord::Base
  belongs_to :user
  belongs_to :alert

  validates_presence_of :alert_id, :user_id

  def hide_me=(hide)
    self.hidden_time = Time.zone.now if hide
  end
end
