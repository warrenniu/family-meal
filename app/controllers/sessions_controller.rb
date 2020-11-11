class SessionsController < ApplicationController
    skip_before_action :authorization, only: [:new, :create]

    def logout
        session.delete(:user_id)
        redirect_to homecooks_path
    end

    def new 
    end

    def create 
        user = Diner.find_by(email: params[:session][:email])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id 
            redirect_to homecooks_path 
        else  
            flash[:error] = "Email or Password is incorrect"
            redirect_to new_login_path
        end 
    end

end