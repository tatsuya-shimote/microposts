class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      #モデル名_idとするとrailsの機能により，自動でusersテーブルを参照してくれる。
      t.references :user, foreign_key: true
      #{ to_table: :users }で外部キーとしてusersテーブルを参照するという指定ができる
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
      
      #user_idとfollow_idのペアで重複するものが保存されないようにするための
      #データベースの設定
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
