class SessionsController < ApplicationController

    def new
        @user = User.new
        render layout: false
    end

    def create
        @user = User.find_by(email: params[:user][:email].downcase)
        if @user && @user.authenticate(params[:user][:password])
            log_in @user
            # если нажали на чекбокс, то запоминаем иначе забываем дайджест запоминания 
            params[:user][:remember_me] == '1' ? remember(@user) : forget(@user)
            # перенаправляем на предыдущую сохраненную локацию пользователя либо на дефолтную страницу 
            redirect_to posts_path
        else
            render html: helpers.content_tag(:div, 'Неверная почта или пароль', class: 'errors')
        end
    end 

    def destroy
        log_out if logged_in?
        redirect_to posts_path
    end
end
