class CreateCapturedImages < ActiveRecord::Migration
  def change
    create_table :captured_images do |t|
      t.string     :content, null: false
      t.integer    :status, null: false
      t.references :prototype, null: false, foreign_key: true

      t.timestamps
    end
  end
end
