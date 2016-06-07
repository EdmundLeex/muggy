# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  processor        :string           not null
#  processor_id     :string
#  status           :string           not null
#  transaction_type :string           not null
#  amount           :integer
#  reason           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#  order_id         :integer          not null
#

FactoryGirl.define do
  factory :transaction do
    
  end
end
