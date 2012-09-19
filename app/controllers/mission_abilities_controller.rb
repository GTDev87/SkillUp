class MissionAbilityController < ApplicationController
  # GET /mission_abilities
  # GET /mission_abilities.json
  def index
    @mission_abilities = MissionAbility.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mission_abilities }
    end
  end

  # GET /mission_abilities/1
  # GET /mission_abilities/1.json
  def show
    @mission_ability = MissionAbility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mission_ability }
    end
  end

  # GET /mission_abilities/new
  # GET /mission_abilities/new.json
  def new
    @mission_ability = MissionAbility.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mission_ability }
    end
  end

  # GET /mission_abilities/1/edit
  def edit
    @mission_ability = MissionAbility.find(params[:id])
  end

  # POST /mission_abilities
  # POST /mission_abilities.json
  def create
    @mission_ability = MissionAbility.new(params[:mission_ability])

    respond_to do |format|
      if @mission_ability.save
        format.html { redirect_to @mission_ability, notice: 'Mission Ability was successfully created.' }
        format.json { render json: @mission_ability, status: :created, location: @mission_ability }
      else
        format.html { render action: "new" }
        format.json { render json: @mission_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mission_abilities/1
  # PUT /mission_abilities/1.json
  def update
    @mission_ability = MissionAbility.find(params[:id])

    respond_to do |format|
      if @mission_ability.update_attributes(params[:mission_ability])
        format.html { redirect_to @mission_ability, notice: 'Mission Ability was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mission_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mission_abilities/1
  # DELETE /mission_abilities/1.json
  def destroy
    @mission_ability = MissionAbility.find(params[:id])
    @mission_ability.destroy

    respond_to do |format|
      format.html { redirect_to mission_abilities_url }
      format.json { head :no_content }
    end
  end
end
