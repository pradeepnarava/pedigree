class PatientController < ApplicationController
  # load_and_authorize_resource
  
  def family_tree
    if params[:id]
      @user = User.find(params[:id])
      @self_member = @user.user_relations.first
    else
      @self_member = current_user.user_relations.first
    end

    unless @self_member.nil?
      @family_members = @self_member.ancestors.reverse

      # @family_members.reverse_merge!(@self_member.current_spouse)
      @self_family = Array(@self_member)

      if @self_member.current_spouse
        @self_family.push(@self_member.current_spouse)
      end    

      @descendants = @self_member.descendants

      @family_members = @family_members + @self_family

      @family_members = @family_members + @descendants
    end
  end

  # Listing all patients under clinic
  def index
  	@patients = current_user.patients
  end

  # Initiating New Patient
  def new
    @patient = User.new
  end

  # Creating Patient
  def create
    @patient = User.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to patient_index_path, notice: 'Patient was successfully created.' }
        format.json { render :index, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # Editing Patient
  def edit
    @patient = User.find(params[:id])
  end

  # Updating Patient
  def update
    @patient = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patient_index_path, notice: 'Patient was successfully updated.' }
        format.json { render :index, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # Deleting Patient

  def destroy
    @patient = User.find(params[:id])
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patient_index_path, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def survey_answers
    @rapidfire_answer_group = Rapidfire::AnswerGroup.find(params[:id])
  end

  private

    def patient_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :user_id)
    end
end
