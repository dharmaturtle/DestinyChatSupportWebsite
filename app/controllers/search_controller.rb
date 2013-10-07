class SearchController < ApplicationController
  def index
  	@title = "User Search"
  end

  def show
    @messages = Kaminari.paginate_array(Message.all(:conditions => "message like '%#{params[:id]}%'")).page(params[:page])
    @title = "Results for: #{params[:id]}"
  end

  def new
    if params[:id].present?
      messages = Message.all :conditions => "message like '%#{params[:id]}%'"

      redirect_to :controller => :search, :action => :show, :id => params[:id] and return true if messages.blank?

      redirect_to :controller => :search, :action => :show, :id => params[:id]
    else
      flash[:notice] = "Input was blank."
      redirect_to :action => "index"
    end
  end

end
