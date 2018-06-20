class CreatePrototypeTags < ActiveRecord::Migration
  def change
    create_table :prototype_tags do |t|
      # 重複を避ける為、それぞれにユニークを付加する。
      t.references :prototype, null: false, unique: true, foreign_key: true
      t.references :tag,       null: false, unique: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
