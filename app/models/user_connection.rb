class UserConnection
  include Mongoid::Document

  belongs_to :user, inverse_of: :user_connections
  validates_presence_of :user

  belongs_to :connection, class_name: "User", inverse_of: :inverse_user_connections, :class_name => "User"
  validates_presence_of :connection
end