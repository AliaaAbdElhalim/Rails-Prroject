class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :verify_role, only: [:new]
  before_action :verify_user, only: [:edit, :update, :destroy]
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /lectures/new
  def new
    @course = Course.new
  end
 
  def create
    @course = Course.new(course_params)
    @course.user_id=current_user.id

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :user_id)
    end

    def verify_user
        if @course.user.id != current_user.id
          respond_to do |format|
            format.html { render :file => "#{Rails.root}/public/422", :layout => false, :status => :not_found }
            format.xml  { head :not_found }
            format.any  { head :not_found }
          end
        end
    end

      def verify_role
        if current_user.status != "teacher"
          respond_to do |format|
            format.html { render :file => "#{Rails.root}/public/422", :layout => false, :status => :not_found }
            format.xml  { head :not_found }
            format.any  { head :not_found }
          end
        end
      end
end
