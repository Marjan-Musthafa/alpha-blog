class SessionsController < ApplicationController
    def new 

    end

    def create 
        user = User.find_by(email: params[:session][:email])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.try(:id)
            flash[:notice] = "You have successfully logged in"
            redirect_to user_path(user)
        else
            flash.now[:alert] = "There is something wrong in login details"
            render 'new'
        end
    end

    def destroy 
        session[:user_id] = nil
        flash[:notice] = "successfully logged out"
        redirect_to root_path
    end
end