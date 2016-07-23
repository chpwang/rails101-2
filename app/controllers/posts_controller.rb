class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]

	def index
		@posts = Post.all
	end

	def new
		@group = Group.find(params[:group_id])
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@group = Group.find(params[:group_id])
		@post.user = current_user
		@post.group = @group

		if @post.save
			redirect_to group_path(@group)
		else
			render :new
		end
	end

	def edit
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			redirect_to account_posts_path, notice: "Post Updated"
		else
			render :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])

		@post.destroy
		redirect_to account_posts_path, alert: "Post deleted"
	end


  private

	def post_params
		params.require(:post).permit(:content)
	end

end
