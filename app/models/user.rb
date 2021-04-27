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
  
  #自分がフォローしているUserとの接続
  #relationshipsモデル(user_id)への参照
  has_many :relationships
  #:followingsという関係を新しく命名し，through: relationshipsで参照先のテーブルを指定。source: :followでテーブルの参照先(follow_id)を指定。
  has_many :followings, through: :relationships, source: :follow
  
  
  #自分をフォローしているUserとの接続
  #:reverses_of_relationshipで新しい関係を命名。class_name: 'Relationship', foreign_key: 'follow_id'でrelationshipsモデル(follow_id)への参照
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  #:followersという関係を新しく命名。through: :reverses_of_relationship,で参照先のテーブルを指定し，source: :userでテーブルの参照先(user_id)を指定。
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many:favorites
  has_many:likes, through: :favorites, source: :micropost
  
  
  
  def follow(other_user)
    #selfには実行したUserが代入される
    unless self == other_user
      #find_or_create_byはまずfind_byが実行され，なければcreateが実行される
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    #if文の省略形。より言語っぽくなって読みやすい。
    relationship.destroy if relationship
  end

  def following?(other_user)
    #self.followingsで実行したUserのフォロー者を全件取得し，include?(other_user)で代入されたother_userがフォロー者に含まれているかを確認。
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    #.following_idsはhas_many:followingsで自動生成されたメソッド。フォローしたユーザのidを配列で取得。
    #self.idのデータ型を合わせるために，[self.id]と配列に変換して追加している。
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  #お気に入りに追加
  def favorite(other_micropost)
    unless self.favorites.find_by(micropost_id: other_micropost.id)
      self.favorites.find_or_create_by(micropost_id: other_micropost.id)
    end
  end

  #お気に入りから削除
  def unfavorite(other_micropost)
    favo = self.favorites.find_by(micropost_id: other_micropost.id)
    favo.destroy if favo
  end
  
  #お気に入りに追加されているかどうかの確認
  def favorite?(micropost)
    self.likes.include?(micropost)
  end
end

