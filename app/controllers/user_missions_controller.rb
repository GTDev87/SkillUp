class UserMissionsController < ApplicationController
  # GET /user_missions
  # GET /user_missions.json
  def index
    @user_missions = UserMission.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_missions }
    end
  end

  # GET /user_missions/1
  # GET /user_missions/1.json
  def show
    @user_mission = UserMission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_mission }
    end
  end

  # GET /user_missions/new
  # GET /user_missions/new.json
  def new
    @user_mission = UserMission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_mission }
    end
  end

  # GET /user_missions/1/edit
  def edit
    @user_mission = UserMission.find(params[:id])
  end

  # POST /user_missions
  # POST /user_missions.json
  def create
    @user_mission = UserMission.new(params[:user_mission])

    respond_to do |format|
      if @user_mission.save
        format.html { redirect_to @user_mission, notice: 'User mission was successfully created.' }
        format.json { render json: @user_mission, status: :created, location: @user_mission }
      else
        format.html { render action: "new" }
        format.json { render json: @user_mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_missions/1
  # PUT /user_missions/1.json
  def update
    @user_mission = UserMission.find(params[:id])

    respond_to do |format|
      if @user_mission.update_attributes(params[:user_mission])
        format.html { redirect_to @user_mission, notice: 'User mission was successfully updated.' }
        format.json { head :no_content }
      else
        debugger
        format.html { render action: "edit" }
        format.json { render json: @user_mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_missions/1
  # DELETE /user_missions/1.json
  def destroy
    @user_mission = UserMission.find(params[:id])
    @user_mission.destroy

    respond_to do |format|
      format.html { redirect_to user_missions_url }
      format.json { head :no_content }
    end
  end
end
