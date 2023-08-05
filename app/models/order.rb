# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  cancel_url        :string
#  coingate_response :jsonb
#  description       :string(500)
#  price_amount      :decimal(8, 2)    not null
#  price_currency    :string           not null
#  purchaser_email   :string
#  receive_currency  :string           not null
#  status            :string
#  success_url       :string
#  title             :string(150)
#  token             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  order_id          :string
#
# Indexes
#
#  index_orders_on_order_id  (order_id) UNIQUE
#
class Order < ApplicationRecord
  validates :order_id, uniqueness: true
  validates :price_amount, presence: true
  validates :price_currency, presence: true
  validates :receive_currency, presence: true
  validates :title, length: { maximum: 150 }
  validates :description, length: { maximum: 500 }

  has_secure_token :token

  def coingate_response=(value)
    merged_value = coingate_response.merge(value)

    super(merged_value)
  end
end
