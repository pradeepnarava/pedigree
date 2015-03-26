class UserRelationsController < ApplicationController
  before_action :set_user_relation, only: [:show, :edit, :update, :destroy]

  # GET /user_relations
  # GET /user_relations.json
  def index
    @user_relations = current_user.user_relations
    @family_members = current_user.user_relations
    @user_relation = UserRelation.new
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

      @self_user = UserRelation.find(params[:to_family_member])

      case params[:what_relative]

        when "Father"
          @self_user.add_father(@user_relation) # Adding Father
          unless @self_user.mother.nil?
            @user_relation.add_current_spouse(@self_user.mother) # Adding Spouse
          end
        when "Mother"
          @self_user.add_mother(@user_relation) # Adding Mother
          unless @self_user.father.nil?
            @user_relation.add_current_spouse(@self_user.father) # Adding Spouse
          end
        when "Paternal Grand Father"
          @self_user.add_paternal_grandfather(@user_relation)

          unless @self_user.paternal_grandmother.nil?
            @user_relation.add_current_spouse(@self_user.paternal_grandmother) # Adding Spouse
          end
        when "Paternal Grand Mother"
          @self_user.add_paternal_grandmother(@user_relation)

          unless @self_user.paternal_grandfather.nil?
            @user_relation.add_current_spouse(@self_user.paternal_grandfather) # Adding Spouse
          end
        when "Maternal Grand Father"
          @self_user.add_maternal_grandfather(@user_relation)
          unless @self_user.maternal_grandmother.nil?
            @user_relation.add_current_spouse(@self_user.maternal_grandmother) # Adding Spouse
          end
        when "Maternal Grand Mother"
          @self_user.add_maternal_grandmother(@user_relation)
          unless @self_user.maternal_grandfather.nil?
            @user_relation.add_current_spouse(@self_user.maternal_grandfather) # Adding Spouse
          end
        when "Spouse"
          @self_user.add_current_spouse(@user_relation)
          unless @self_user.children.blank?
            @self_user.children.each do |children|
              children.add_mother(@user_relation)
            end
          end
        when "Sibling"
          unless @self_user.father.nil?
            @self_user.add_siblings(@user_relation, half: :father)
            unless @self_user.mother.nil?
              @user_relation.add_mother(@self_user.mother)
            end            
          else
            @self_user.add_siblings(@user_relation, half: :mother)
            unless @self_user.father.nil?
              @user_relation.add_father(@self_user.father)
            end
          end
        when "Child"
          @self_user.add_child(@user_relation) # Adding Childrens
          if @self_user.current_spouse
            @user_relation.add_mother(@self_user.current_spouse)
          end
      end

      # @self_user.add_siblings(@user_relation, half: :father) # Adding Paternal Siblings
      # @self_user.add_siblings(@user_relation, half: :mother) # Adding Maternal Siblings
      # @self_user.add_paternal_grandfather(@user_relation) # Adding Paternal Grandfather
      # @self_user.add_paternal_grandmother(@user_relation) # Adding Paternal Grandmother
      # @self_user.add_maternal_grandfather(@user_relation) # Adding Maternal Grandfather
      # @self_user.add_maternal_grandmother(@user_relation) # Adding Maternal Grandmother
      # @self_user.add_current_spouse(@user_relation) # Adding Spouse
    
    end

    respond_to do |format|
      if @user_relation.save
        format.html { redirect_to user_relations_path, notice: 'User relation was successfully created.' }
        format.json { render :show, status: :created, location: @user_relation }
      else
        format.html { render :new }
        format.json { render json: @user_relation.errors, status: :unprocessable_entity }
      end
    end
  rescue => e
    @family_members = current_user.user_relations
    flash[:notice] = "The internal broke. Error : #{e}"
    respond_to do |format|
      format.html { redirect_to user_relations_path }
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
