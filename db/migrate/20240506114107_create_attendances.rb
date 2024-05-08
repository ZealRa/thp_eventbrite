class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.string :stripe_customer_id
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.references :event, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
