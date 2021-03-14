class AddPayedToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payed, :boolean, default: false
  end
end
