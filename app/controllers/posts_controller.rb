class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.as_json(methods: [:post_cover_url, :file_url])

    render inertia: "post/Index", props: { posts: @posts }
  end

  # GET /posts/1 or /posts/1.json
  def show
    render inertia: "post/Show", props: { post: @post.as_json(methods: [:post_cover_url, :file_url, :multiple_file_urls]) }
  end

  # GET /posts/new
  def new
    @post = Post.new
    render inertia: "post/Form", props: { post: nil }
  end

  # GET /posts/1/edit
  def edit
    render inertia: "post/Form", props: { post: @post.as_json(methods: [:post_cover_url, :file_url]) }
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { render inertia: "post/Index", props: { posts: Post.all.as_json(methods: :post_cover_url) } }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render inertia: "post/Form", status: :unprocessable_entity, props: { errors: @post.errors, recent: @post } }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :post_cover, :file_cover, multiple_files: [])
  end
end
