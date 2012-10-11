class MissionAbilityController < ApplicationController
  # GET /mission_skills
  # GET /mission_skills.json
  def index
    @mission_skills = MissionSkills.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mission_skills }
    end
  end

  # GET /mission_skills/1
  # GET /mission_skills/1.json
  def show
    @mission_skill = MissionSkills.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mission_skill }
    end
  end

  # GET /mission_skills/new
  # GET /mission_skills/new.json
  def new
    @mission_skill = MissionSkill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mission_skill }
    end
  end

  # GET /mission_skills/1/edit
  def edit
    @mission_skill = MissionSkill.find(params[:id])
  end

  # POST /mission_skills
  # POST /mission_skills.json
  def create
    @mission_skill = MissionSkill.new(params[:mission_skill])

    respond_to do |format|
      if @mission_skill.save
        format.html { redirect_to @mission_skill, notice: 'Mission Skill was successfully created.' }
        format.json { render json: @mission_skill, status: :created, location: @mission_skill }
      else
        format.html { render action: "new" }
        format.json { render json: @mission_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mission_skills/1
  # PUT /mission_skills/1.json
  def update
    @mission_skill = MissionSkill.find(params[:id])

    respond_to do |format|
      if @mission_skill.update_attributes(params[:mission_skill])
        format.html { redirect_to @mission_skill, notice: 'Mission Skill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mission_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mission_skills/1
  # DELETE /mission_skills/1.json
  def destroy
    @mission_skill = MissionSkill.find(params[:id])
    @mission_skill.destroy

    respond_to do |format|
      format.html { redirect_to mission_skills_url }
      format.json { head :no_content }
    end
  end
end
