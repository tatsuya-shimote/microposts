class User < ApplicationRecord
  #userインスタンス(レコード)が保存される前にself.email.downcase!を実行
  # !メソッドは自分自身にメソッドを施させる。これを破壊的という。
  before_save { self.email.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  
  validates :email, presence: true, length: { maximum: 255 },
                  #メールアドレスの形式をに当てはまるかを判断するバリデーション
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  #uniquness=重複を許さない。
                  #case_sensitive: false=大文字と小文字を区別しない
                  uniqueness: { case_sensitive: false }
  #パスワードの暗号化等，セキュリティー面の用意を効率的に準備してくれる。
  #マイグレーション時に，password_digestカラムを用意することを忘れない。
  has_secure_password
  
  #userモデルは複数のmicropostモデルを所有するという意味。
  has_many :microposts
end
