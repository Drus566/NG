class SessionsController < ApplicationController

  def new
    flash.discard
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    respond_to do |format|
      if @user && @user.authenticate(params[:session][:password])
        log_in @user
        # если нажали на чекбокс, то запоминаем иначе забываем дайджест запоминания 
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        # перенаправляем на предыдущую сохраненную локацию пользователя либо на дефолтную страницу 
        flash[:success] = 'Вы успешно вошли'
        format.html { redirect_back_or posts_path }
        format.json { render json: @user }
        format.js
      else
        flash[:error] = 'Неверная почта или пароль'
        format.html { render 'new' }
        format.json { render :json => { error: 'Неверный майл или пароль', status: 400 } }
        format.js
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to '/login'
  end

end
