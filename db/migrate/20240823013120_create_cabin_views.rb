class CreateCabinViews < ActiveRecord::Migration[7.1]
  def change
    create_table :cabin_views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cabin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
