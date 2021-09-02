class AddisFulfilledToBill < ActiveRecord::Migration[6.1]
  def change
    add_column :bills, :isFulfilled, :boolean, default: false
  end
end
