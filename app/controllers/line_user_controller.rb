class LineUserController < ApplicationController
  def index
    @line_users = LineUser.all
  end

  def show
    @line_user = LineUser.find(params[:id])
  end
end
