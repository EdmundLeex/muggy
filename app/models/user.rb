class User < ActiveRecord::Base
  has_many :orders
  
  validates_presence_of :first_name, :last_name, :email_address
end
