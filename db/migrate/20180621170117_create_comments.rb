class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :prototype, null: false, foreign_key: true
      # model生成時に『prototype:references』で書くと、index: trueが入る。
      # 検索する予定がないので、indexを消す。

      t.timestamps
    end
  end
end
