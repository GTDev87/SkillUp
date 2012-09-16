class SkillAptitudesController < ApplicationController
  # GET /skill_aptitudes
  # GET /skill_aptitudes.json
  def index
    @skill_aptitudes = SkillAptitude.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skill_aptitudes }
    end
  end

  # GET /skill_aptitudes/1
  # GET /skill_aptitudes/1.json
  def show
    @skill_aptitude = SkillAptitude.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill_aptitude }
    end
  end

  # GET /skill_aptitudes/new
  # GET /skill_aptitudes/new.json
  def new
    @skill_aptitude = SkillAptitude.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skill_aptitude }
    end
  end

  # GET /skill_aptitudes/1/edit
  def edit
    @skill_aptitude = SkillAptitude.find(params[:id])
  end

  # POST /skill_aptitudes
  # POST /skill_aptitudes.json
  def create
    @skill_aptitude = SkillAptitude.new(params[:skill_aptitude])

    respond_to do |format|
      if @skill_aptitude.save
        format.html { redirect_to @skill_aptitude, notice: 'Skill aptitude was successfully created.' }
        format.json { render json: @skill_aptitude, status: :created, location: @skill_aptitude }
      else
        format.html { render action: "new" }
        format.json { render json: @skill_aptitude.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /skill_aptitudes/1
  # PUT /skill_aptitudes/1.json
  def update
    @skill_aptitude = SkillAptitude.find(params[:id])

    respond_to do |format|
      if @skill_aptitude.update_attributes(params[:skill_aptitude])
        format.html { redirect_to @skill_aptitude, notice: 'Skill aptitude was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @skill_aptitude.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skill_aptitudes/1
  # DELETE /skill_aptitudes/1.json
  def destroy
    @skill_aptitude = SkillAptitude.find(params[:id])
    @skill_aptitude.destroy

    respond_to do |format|
      format.html { redirect_to skill_aptitudes_url }
      format.json { head :no_content }
    end
  end
end
