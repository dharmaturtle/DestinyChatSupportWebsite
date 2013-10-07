class UsersController < ApplicationController
  def index
    @messages = Message.page(params[:page])
    @title = "Chat Log"
  end

  def show
    @messages = Kaminari.paginate_array(Message.find_all_by_nick(params[:id])).page(params[:page])
    if @messages.blank?
      redirect_to users_path, :notice => "User not found!"
    else
    	@title = params[:id]
    end
  end

  def new
    if params[:id].present?
      nick = Message.find_all_by_nick(params[:id], :order => "id DESC")
      flash[:notice] = "User not found." and redirect_to :action => :index and return true if not nick
      redirect_to :controller => :users, :action => :show, :id => params[:id]
    else
      flash[:notice] = "User not found."
      redirect_to users_path
    end
  end

end
