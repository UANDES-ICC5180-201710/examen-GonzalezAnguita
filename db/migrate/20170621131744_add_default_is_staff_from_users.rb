class AddDefaultIsStaffFromUsers < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :is_staff, :boolean, default: false
  end
  
  def down
    change_column :users, :is_staff, :boolean
  end
end
