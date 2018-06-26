class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, null: true, foreign_key: true
      t.references :prototype, null: true, foreign_key: true

      t.timestamps
    end
  end
end
