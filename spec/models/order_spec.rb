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
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
