class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = authenticate_session(session_params)

    if sign_in(user)
      current_user.mark_as_online
      redirect_to :dashboard
    else
      flash[:notice] = "Please sign in before using facespace" 
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to :dashboard
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
