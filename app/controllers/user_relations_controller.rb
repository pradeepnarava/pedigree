class UserRelationsController < ApplicationController
  before_action :set_user_relation, only: [:show, :edit, :update, :destroy]

  # GET /user_relations
  # GET /user_relations.json
  def index
    @user_relations = UserRelation.all
  end

  # GET /user_relations/1
  # GET /user_relations/1.json
  def show
  end

  # GET /user_relations/new
  def new
    @family_members = current_user.user_relations
    @user_relation = UserRelation.new
  end

  # GET /user_relations/1/edit
  def edit
  end

  # POST /user_relations
  # POST /user_relations.json
  def create
    @user_relation = UserRelation.new(user_relation_params)

    unless params[:to_family_member] == "Self"

      @self_user = current_user.user_relations.first

      case params[:what_relative]

        when "Father"
          @self_user.add_father(@user_relation) # Adding Father
        when "Mother"
          @self_user.add_mother(@user_relation) # Adding Mother
        when "Child"
          @self_user.add_child(@user_relation) # Adding Childrens

      end

      # @self_user.add_siblings(@user_relation, half: :father) # Adding Paternal Siblings
      # @self_user.add_siblings(@user_relation, half: :mother) # Adding Maternal Siblings
      # @self_user.add_paternal_grandfather(@user_relation) # Adding Paternal Grandfather
      # @self_user.add_paternal_grandmother(@user_relation) # Adding Paternal Grandmother
      # @self_user.add_maternal_grandfather(@user_relation) # Adding Maternal Grandfather
      # @self_user.add_maternal_grandmother(@user_relation) # Adding Maternal Grandmother
      # @self_user.add_spouse(@user_relation) # Adding Spouse
    
    end

    respond_to do |format|
      if @user_relation.save
        format.html { redirect_to @user_relation, notice: 'User relation was successfully created.' }
        format.json { render :show, status: :created, location: @user_relation }
      else
        format.html { render :new }
        format.json { render json: @user_relation.errors, status: :unprocessable_entity }
      end
    end
  rescue => e
    @family_members = current_user.user_relations
    flash[:notice] = "The internet broke. Error : #{e}"
    respond_to do |format|
      format.html { redirect_to new_user_relation_path }
    end
  end

  # PATCH/PUT /user_relations/1
  # PATCH/PUT /user_relations/1.json
  def update
    respond_to do |format|
      if @user_relation.update(user_relation_params)
        format.html { redirect_to @user_relation, notice: 'User relation was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_relation }
      else
        format.html { render :edit }
        format.json { render json: @user_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_relations/1
  # DELETE /user_relations/1.json
  def destroy
    @user_relation.destroy
    respond_to do |format|
      format.html { redirect_to user_relations_url, notice: 'User relation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_relation
      @user_relation = UserRelation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_relation_params
      params.require(:user_relation).permit(:name, :sex, :user_id)
    end
end
