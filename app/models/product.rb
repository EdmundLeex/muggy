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

class Product < ActiveRecord::Base
  has_many :order_items
  has_many :orders, through: :order_items
end
