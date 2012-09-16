class SkillInherentsController < ApplicationController
  # GET /skill_inherents
  # GET /skill_inherents.json
  def index
    @skill_inherents = SkillInherent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skill_inherents }
    end
  end

  # GET /skill_inherents/1
  # GET /skill_inherents/1.json
  def show
    @skill_inherent = SkillInherent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill_inherent }
    end
  end

  # GET /skill_inherents/new
  # GET /skill_inherents/new.json
  def new
    @skill_inherent = SkillInherent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skill_inherent }
    end
  end

  # GET /skill_inherents/1/edit
  def edit
    @skill_inherent = SkillInherent.find(params[:id])
  end

  # POST /skill_inherents
  # POST /skill_inherents.json
  def create
    @skill_inherent = SkillInherent.new(params[:skill_inherent])

    respond_to do |format|
      if @skill_inherent.save
        format.html { redirect_to @skill_inherent, notice: 'Skill inherent was successfully created.' }
        format.json { render json: @skill_inherent, status: :created, location: @skill_inherent }
      else
        format.html { render action: "new" }
        format.json { render json: @skill_inherent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /skill_inherents/1
  # PUT /skill_inherents/1.json
  def update
    @skill_inherent = SkillInherent.find(params[:id])

    respond_to do |format|
      if @skill_inherent.update_attributes(params[:skill_inherent])
        format.html { redirect_to @skill_inherent, notice: 'Skill inherent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @skill_inherent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skill_inherents/1
  # DELETE /skill_inherents/1.json
  def destroy
    @skill_inherent = SkillInherent.find(params[:id])
    @skill_inherent.destroy

    respond_to do |format|
      format.html { redirect_to skill_inherents_url }
      format.json { head :no_content }
    end
  end
end
