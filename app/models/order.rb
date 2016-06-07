# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  order_number     :string           not null
#  street_address   :string           not null
#  street_address_2 :string
#  city             :string           not null
#  state            :string           not null
#  zipcode          :string           not null
#  country          :string           not null
#  phone_number     :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#  amount           :integer          not null
#

class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  before_validation :generate_order_number, on: :create
  after_commit :charge_payment

  validates_presence_of :order_number, :street_address, :city, :state, :zipcode, :country, :phone_number, :user_id
  validates_uniqueness_of :order_number

  def charge_payment(card_nounce)
    PaymentWorker.perform_later(card_nounce, amount, currency)
  end

  private

  def generate_order_number
    self.order_number = SecureRandom.hex(3) + '-' + SecureRandom.hex(4) + '-' + SecureRandom.hex(3)
  end
end
