class CreateCapturedImages < ActiveRecord::Migration
  def change
    create_table :captured_images do |t|
      t.string     :content
      t.integer    :status
      t.references :prototype, null: false, foreign_key: true

      t.timestamps
    end
  end
end
