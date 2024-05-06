class AddAdminToEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :admin, foreign_key: { to_table: :users }
  end
end
