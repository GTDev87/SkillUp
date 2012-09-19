class UserAbilitiesController < ApplicationController
  # GET /user_abilities
  # GET /user_abilities.json
  def index
    @user_abilities = UserAbility.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_abilities }
    end
  end

  # GET /user_abilities/1
  # GET /user_abilities/1.json
  def show
    @user_ability = UserAbility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_ability }
    end
  end

  # GET /user_abilities/new
  # GET /user_abilities/new.json
  def new
    @user_ability = UserAbility.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_ability }
    end
  end

  # GET /user_abilities/1/edit
  def edit
    @user_ability = UserAbility.find(params[:id])
  end

  # POST /user_abilities
  # POST /user_abilities.json
  def create
    @user_ability = UserAbility.new(params[:user_ability])

    respond_to do |format|
      if @user_ability.save
        format.html { redirect_to @user_ability, notice: 'User ability was successfully created.' }
        format.json { render json: @user_ability, status: :created, location: @user_ability }
      else
        format.html { render action: "new" }
        format.json { render json: @user_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_abilities/1
  # PUT /user_abilities/1.json
  def update
    @user_ability = UserAbility.find(params[:id])

    respond_to do |format|
      if @user_ability.update_attributes(params[:user_ability])
        format.html { redirect_to @user_ability, notice: 'User ability was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_abilities/1
  # DELETE /user_abilities/1.json
  def destroy
    @user_ability = UserAbility.find(params[:id])
    @user_ability.destroy

    respond_to do |format|
      format.html { redirect_to user_abilities_url }
      format.json { head :no_content }
    end
  end
end
