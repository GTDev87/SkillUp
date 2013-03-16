class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    
    user = User.find_by_email(params[:session][:email])
    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        format.html { redirect_to main_app.user_path(user.id), notice: "Logged in!" }
        format.json { render json: user, status: :created, location: user }
      else
        flash.now.alert = "Email or password is invalid"
        format.html { render "new" }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end
end
