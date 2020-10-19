class AddPaymentPlanToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :payment_plan, :integer, default: 0
  end
end
