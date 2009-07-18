class ClientUser < ActiveRecord::Base

  belongs_to :client
  belongs_to :user

  validates_presence_of :client_id, :user_id

end
