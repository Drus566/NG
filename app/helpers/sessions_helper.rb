module SessionsHelper
    def log_in(user)
        # Записывает в переменную сессии айди пользователя
        session[:user_id] = user.id
    end

    def current_user
        # Если существует в переменной сессии айди пользователя, то текущий пользователь
        # равен текущему пользователю, если он существовал до этого, либо равен пользователю 
        # из записи в БД, который ищется по айди из сессии
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        # Если существует куки с айди пользователя, то ищется запись в БД этого пользователся по 
        # соответсвтующему айди и если он найден, то идет проверка аутентификации по запоминающему
        # токену из куков, если успешно, то вход пользователя
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end 
        else
            @current_user = nil
        end
    end

    def current_user?(user)
        user == current_user
    end

    # Перенаправляет на предыдущую сохраненную локацию либо на дефолтную
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    # Сохраняет URl, который пытается получить доступ
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end

    # Стирание из БД запоминающего хэша токена и удаление кука айди и запоминающего токена
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # Проверка вошел ли пользователь, т.е. является ли текущем пользователем
    def logged_in?
        !current_user.nil?
    end

    def user_admin?
        current_user.email == "ahdpeu566@mail.ru"
    end

    # Выходит из сессии, удаляет запоминающий токен из бд, очищает текущего пользователя, удаляет сессию
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    # Делает запись в БД хэша токена, заполняет куки юзер айди и запоминающим токеном пользователя
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
end
