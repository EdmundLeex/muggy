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
#  first_name       :string           not null
#  last_name        :string           not null
#

class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  before_validation :generate_order_number, on: :create
  after_commit :charge_payment
  after_commit :send_confirmation, on: :create

  validates_presence_of :order_number, :street_address, :city, :state, :zipcode, :country, :phone_number, :user_id
  validates_uniqueness_of :order_number

  private

  def generate_order_number
    self.order_number = SecureRandom.hex(3) + '-' + SecureRandom.hex(4) + '-' + SecureRandom.hex(3)
    generate_order_number if find_by_order_number(order_number)
  end

  def charge_payment(card_nounce)
    ProcessPaymentJob.perform_later(card_nounce, amount, currency)
  end

  def send_confirmation
    data = {
      amount: amount,
      user: {
        name: "#{first_name} #{last_name}",
        street_address_1: street_address_1,
        street_address_2: street_address_2,
        city: city,
        state: state,
        zip: zip
      },
      card: resp.transaction.tenders[0].card_details.card
    }
    OrderMailer.delay.order_confirmation_email(user.email, data)
  end
end
