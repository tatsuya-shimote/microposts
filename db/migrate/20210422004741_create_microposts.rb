class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      #以下は実際にはuser_idとしてカラムに存在し，Userのidを保存する。
      #foreign_keyとは外部キー制約を意味する。外部キー制約はデータベース側の
      #機能で，modelとそれに接続された複数のmodelとの接続関係を強化する。
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
