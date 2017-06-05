class LecturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lecture, only: [:show, :edit, :update, :destroy,:upvote, :downvote,:set_spammed, :set_unspammed ]
  before_action :verify_user, only: [:edit, :update, :destroy ]
  # GET /lectures
  # GET /lectures.json
  def index
    # respond_to do |format|
    #   format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
    #   format.xml  { head :not_found }
    #   format.any  { head :not_found }
    @lectures = Lecture.all
  end


  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @comments = Comment.where(lecture_id: @lecture)
    @comment = Comment.new
  end
  

  # GET /lectures/new
  def new
    @lecture = Lecture.new
  end

  def render_422
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/422", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def create_comment
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = 'Your comment was successfully added!'
      redirect_to lecture_url(@comment.lecture_id)
    end
  end


  def upvote
    @lecture.liked_by current_user
    redirect_to @lecture
  end

  def downvote
    @lecture.disliked_by current_user
    redirect_to @lecture
  end

  def set_spammed
    @lecture.liked_by current_user, :vote_scope => 'spam'
    redirect_to @lecture
  end

  def set_unspammed
    @lecture.unliked_by current_user, :vote_scope => 'spam'
    redirect_to @lecture
  end

  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /lectures/1/edit
  # def edit
  # end

  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.user_id=current_user.id
    respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to '/lectures' , notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

#   def upvote 
#   @lecture = Lecture.find(params[:id])
#   @lecture.upvote_by current_user
#   redirect_to @lecture
# end  

# def downvote
#   @lecture = Lecture.find(params[:id])
#   @lecture.downvote_by current_user
#   redirect_to @lecture
# end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verify_user
    if @lecture.user.id != current_user.id
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/422", :layout => false, :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
        end
      end
    end

    def comment_params
      params.require(:comment).permit(:content, :lecture_id, :user_id)
    end

    def lecture_params
      params.require(:lecture).permit(:title, :content, :attachment, :course_id, :user_id, :lecattachement)
    end
end
