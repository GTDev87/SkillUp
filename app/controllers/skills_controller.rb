class SkillsController < ApplicationController
  # GET /skills
  # GET /skills.json
  def index
    if params[:term].present?
      @skills = Skill.search_titles(params[:term])
    else
      @skills = Skill.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skills.map(&:title) }
    end
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
    @skill = Skill.find(params[:id])

    @level_dependent_missions = @skill.all_missions_at_level(1).to_a
    if params[:level_mission]
      @level_dependent_missions = @skill.all_missions_at_level(params[:level_mission].to_i).to_a
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill }
      format.js
    end
  end

  # GET /skills/new
  # GET /skills/new.json
  def new
    @skill = Skill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skill }
    end
  end

  # GET /skills/1/edit
  def edit
    @skill = Skill.find(params[:id])
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(params[:skill])

    respond_to do |format|
      if @skill.save
        format.html { redirect_to @skill, notice: 'Skill was successfully created.' }
        format.json { render json: @skill, status: :created, location: @skill }
      else
        format.html { render action: "new" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /skills/1
  # PUT /skills/1.json
  def update
    @skill = Skill.find(params[:id])
    
    respond_to do |format|
      if @skill.update_attributes(params[:skill])
        format.html { redirect_to @skill, notice: 'Skill was successfully updated.' }
        format.json { head :no_content }
      else
        #debugger
        #errors = @skill.errors
        @skill = Skill.find(params[:id])
        #@skill.errors = errors
        format.html { render action: "edit" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy

    respond_to do |format|
      format.html { redirect_to skills_url }
      format.json { head :no_content }
    end
  end
end
