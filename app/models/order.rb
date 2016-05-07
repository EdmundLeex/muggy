class Order < ActiveRecord::Base
  belongs_to :user

  before_validate :create_user
  after_commit :charge_payment

  def create_user
    
  end

  def charge_payment
    
  end
end
