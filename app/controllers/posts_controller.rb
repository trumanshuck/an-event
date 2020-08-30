class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @prev = previous_post
    @next = next_post
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def previous_post
      return if @post.blank?

      at_same_stop = Post.previous(@post)
      return at_same_stop if at_same_stop.present?

      prev_stop = Stop.previous(@post.stop)
      return if prev_stop.blank?

      Post.last_at(prev_stop)
    end

    def next_post
      return if @post.blank?

      at_same_stop = Post.next(@post)
      return at_same_stop if at_same_stop.present?

      next_stop = Stop.next(@post.stop)
      return if next_stop.blank?

      Post.first_at(next_stop)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(slug: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :stop_id, :slug)
    end
end
