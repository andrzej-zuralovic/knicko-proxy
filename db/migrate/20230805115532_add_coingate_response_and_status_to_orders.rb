class AddCoingateResponseAndStatusToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column(:orders, :status, :string)
    add_column(:orders, :coingate_response, :jsonb, default: {})
  end
end
