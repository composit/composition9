class Alert < ActiveRecord::Base
  belongs_to :client
  belongs_to :project
  belongs_to :ticket
  belongs_to :ticket_comment
  belongs_to :user
  has_many :user_alerts

  validates_presence_of :action_statement, :user_id

  def after_create
    if client && client.users
      client.users.each do |user|
        user_alerts.create( :user_id => user.id ) unless user.id == user_id || dup_alert(user)
      end
    else
      User.admin.each do |admin_user|
        user_alerts.create( :user_id => admin_user.id ) unless admin_user.id == user_id || dup_alert(admin_user)
      end
    end
  end

  protected
    def dup_alert(user)
      dup = user.user_alerts.find(:first,
        :include => :alert,
        :conditions => {
          :hidden_time => nil,
          "alerts.action_statement" => action_statement,
          "alerts.client_id" => client_id,
          "alerts.project_id" => project_id,
          "alerts.ticket_id" => ticket_id,
          "alerts.ticket_comment_id" => ticket_comment_id,
          "alerts.user_id" => user_id
        }
      )
      dup ? true : false
    end
end
