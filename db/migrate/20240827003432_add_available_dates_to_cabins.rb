class AddAvailableDatesToCabins < ActiveRecord::Migration[7.1]
  def change
    add_column :cabins, :available_dates, :jsonb, default: {}
  end
end
