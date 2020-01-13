module AuthorityHelper

    # --------- Ограничения ---------- # 

    # проверка на админа
    def user_admin?
        current_user.email == "ahdpeu566@mail.ru"
    end

    # если пользователь не админ и не является владельцем ресурса
    # то перенаправляет на главную страницу
    def valid_resource(owner_resource)
        unless user_admin?
            unless current_user?(owner_resource)
                flash[:warning] = "Нельзя совершить операцию"
                redirect_to root_url
            end
        end
    end

    # если пользователь пытается редактировать аккаунт чужого пользователя
    # то его выкидывает на главную страницу
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end

     # Если пользователь не вошел, перебрасывает его на страницу входа 
     def logged_in_user
        unless logged_in?
            store_location
            flash[:warning] = "Пожалуйста залогиньтесь"
            redirect_to login_url
        end
    end
end