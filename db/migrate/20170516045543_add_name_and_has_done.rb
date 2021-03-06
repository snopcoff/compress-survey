class AddNameAndHasDone < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :has_done, :boolean, default: false
  end
end
