class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cabin, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.decimal :total_price

      t.timestamps
    end
  end
end
