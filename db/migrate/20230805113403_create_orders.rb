class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table(:orders) do |t|
      t.string(:order_id, index: { unique: true })
      t.decimal(:price_amount, null: false, precision: 8, scale: 2)
      t.string(:price_currency, null: false)
      t.string(:receive_currency, null: false)
      t.string(:title, limit: 150)
      t.string(:description, limit: 500)
      t.string(:cancel_url)
      t.string(:success_url)
      t.string(:token)
      t.string(:purchaser_email)

      t.timestamps
    end
  end
end
