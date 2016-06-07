# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  price       :integer          not null
#  description :text
#  remark      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :product do
    name "MyString"
    price 1
    description "MyText"
    remark "MyText"
  end
end
