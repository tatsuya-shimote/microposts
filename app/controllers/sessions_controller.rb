class SessionsController < ApplicationController
  def new
  end

  def create
    # downcaseは受け取った文字列を全て小文字にする。
    # Modelがなくてもparamsにフォームデータは格納される。
    #以下のようにModelがない場合は２段階で呼び出すことでemailを取り出す。
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  
  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      #ユーザのemailとpasswordがどちらも一致することで以下のハッシュにidを格納。
      #session[:user_id]に格納することでブラウザではCookie,サーバではSessionとしてログインが維持される。
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end

end
