class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :show, :update, :destroy]
    before_action :require_user, only: [:edit, :show]
    before_action :require_same_user, only: [:edit, :update]


    def index 
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def edit 
    end

    def show 
        @articles = @user.articles
    end

    def update 
        if @user.update(user_params)
            flash[:notice] = "User is successfully updated"
            redirect_to users_path(@user)
        else
            render 'edit' 
        end
    end
    
    def create  
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to Alpha Blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def destroy 
        @user.destroy
        session[:user_id] = nil   
        flash[:notice] = "Your account is successfully deleted"
         redirect_to root_path        
    end

    private

    def user_params
        params.require(:user).permit(:username,:password,:email)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You can edit only your details"
            redirect_to @user
        end
    end





end
