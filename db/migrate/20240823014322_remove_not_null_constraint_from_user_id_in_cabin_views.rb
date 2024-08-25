class RemoveNotNullConstraintFromUserIdInCabinViews < ActiveRecord::Migration[7.1]
  def change
    change_column_null :cabin_views, :user_id, true
  end
end
