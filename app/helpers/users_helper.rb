#Gravatarの導入。Gravatorに登録したメールアドレスと画像を引っ張ってきた表示する。
module UsersHelper
  def gravatar_url(user, options = { size: 80 })#sizeのデフォルトは80。値を変更すれば画像サイズを調整できる。
    #user.emailを全て小文字(downcase)にし，かつ暗号化(ダイジェスト)して代入
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end

