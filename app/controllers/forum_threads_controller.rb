class ForumThreadsController < ApplicationController
    before_action :authenticate_user!, only:[:new, :create, :edit, :update]
    
    
    def index
        if params[:search]
        @threads = ForumThread.where('title like ?', "%#{params[:search]}%").paginate(per_page: 5, page: params[:page])
        else
    @threads = ForumThread.order(sticky_order: :asc).order(id: :desc).paginate(per_page: 5, page: params[:page])
        end
    end
    def show
    @thread = ForumThread.friendly.find(params[:id])
    @post = ForumPost.new
    @posts = @thread.forum_posts.paginate(per_page:4, page: params[:page])
    end

    def new 
    @thread = ForumThread.new
    end

    def create
    @thread = ForumThread.new(resource_params)
    @thread.user = current_user
        if @thread.save
    redirect_to root_path
        else 
            render "new"
        end
    end
   
    def edit
        @thread = ForumThread.friendly.find(params[:id])
        authorize @thread
    end

    def update 
            @thread = ForumThread.friendly.find(params[:id])
            authorize @thread
            @thread.user =current_user
                if @thread.update(resource_params)
            redirect_to root_path
                else 
                    render "new"
                end
     end

        
    def destroy
        @thread = ForumThread.friendly.find(params[:id])
        authorize @thread
    end
   
    
    def pinit
     @thread = ForumThread.friendly.find(params[:id])
     @thread.pinit!
    redirect_to root_path
    end
    
    private 
    def resource_params
    params.require(:forum_thread).permit(:title,:content)   
    end

end