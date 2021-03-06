class SurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :get_admin, only: [:show, :index, :edit, :destroy]
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :answers]

  # GET /surveys
  # GET /surveys.json
  # def index
  #  @users = User.all
  # end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @users = User.all
  end

  # GET /surveys/new
  def new
   @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        User.find(current_user.id).update_attribute(:has_done, true)
        format.html { redirect_to root_path, notice: 'Thank you for doing this survey.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def answers
    @questions = @survey.questions.paginate(:page => params[:page], :per_page => 1)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:name, :questions_attributes => [:id, :encfile, :decfile, 
        :answers_attributes => [:id, :mark, :user_id]])
    end
    
    def get_admin
      if !current_user.is_admin
        redirect_to root_path
      end
    end
    
end
