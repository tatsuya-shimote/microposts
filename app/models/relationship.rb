class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User' #参照モデルはUserであると指定する。理由はマイグレーションの設定時による。
end
