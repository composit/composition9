class ClientUser < ActiveRecord::Base
  named_scope :prioritized, :order => "priority"

  belongs_to :client
  belongs_to :user

  validates_presence_of :client_id, :user_id
end
