class PollsController < ApplicationController

  before_filter :auth, :only => [:create, :new, :destroy]

  def index
    @poll = Poll.all :order => "created_at DESC"
    @title = "Polls"
  end

  def update_results

  end

  def show
    @poll = Poll.find(params[:id])
    @title = "Poll ##{:id}"
    
    @total_votes = 0
    @poll.answers.each do |a|
      @total_votes += a.votes
    end

    respond_to do |format|
      format.js
      format.html  # show.html.erb
      format.json  { render :json => @poll }
    end
  end

  def new
    @poll = Poll.new
    8.times do |x|
      answer = @poll.answers.build
      answer.choice = x + 1
    end
  end

  def create
    @poll = Poll.new(params[:poll])

    respond_to do |format|
      if @poll.save
        Messagequeue.new(:command => "makeactive", :message => @poll.id).save
        format.html  { redirect_to(@poll,
                      :notice => 'Poll was successfully created.') }
        format.json  { render :json => @poll,
                      :status => :created, :location => @poll }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @poll.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy
    redirect_to :action => 'index'
  end

  private

  def auth
    unless session[:password] == "secret"
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end

end
