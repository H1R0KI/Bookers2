class HomesController < ApplicationController
  def top
    @user = User.find(params[:id])
  end

  def about
    @user = User.find(params[:id])
  end
end
