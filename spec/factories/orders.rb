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

FactoryGirl.define do
  factory :order do
    order_number "MyString"
    street_address "MyString"
    street_address_2 "MyString"
    city "MyString"
    state "MyString"
    zipcode "MyString"
    country "MyString"
    phone_number "MyString"
  end
end
