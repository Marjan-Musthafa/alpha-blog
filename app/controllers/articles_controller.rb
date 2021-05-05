class ArticlesController < ApplicationController
    before_action :set_parents, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    
    def show
    end

    def index
        @articles=Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article=Article.new
        
    end

    def create
        @article=Article.new(article_params)
        @article.user_id = current_user
        if @article.save
            flash[:notice] = "Article is created successfully"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        @article.update(article_params)
        if @article.save
            flash[:notice] = "Article is successfully updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def destroy  
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_parents
        @article=Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title,:description)
    end

    def require_same_user
        if current_user != @article.user
            flash[:alert] = "You can only edit your articles"
            redirect_to article_path
        end
    end
end
