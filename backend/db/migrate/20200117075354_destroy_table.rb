class DestroyTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :users
    drop_table :todos
  end
end
