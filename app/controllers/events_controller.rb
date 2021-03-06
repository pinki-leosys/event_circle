class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  before_filter :authenticate_user!
  before_filter :remove_pictures, only: :new
  def index
    @events = Event.where(published:true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: ::EventsDatatable.new(view_context) }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @image= Event.new
    @event = Event.find(params[:id])
    session[:event_id]= params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    session[:event_id]=nil
    @event.build_address
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id], :include => :address)
    session[:event_id]= params[:id]
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
   # @event.user_id=current_user.id
    if (params[:commit] == "Publish")
       @event.published=true
       @event.published_at =Time.now
    end

   # @event.event_start_date=Time.strptime(params[:event][:event_starts], '%m/%d/%Y %I:%M %p')
#start_time = start_time.in_time_zone(current_user.time_zone).to_time # I let users pick their time zone.
 #@event.event_start_date = (start_time-offset.hours).utc
    #@event.event_end_date=Time.strptime(params[:event][:event_ends],'%m/%d/%Y %I:%M %p')

    @event.user=current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    if (params[:commit] == "Publish")
       params[:event][:published]=true
       params[:event][:published_at] =Time.now
    end
  #  params[:event][:event_start_date]=Time.strptime(params[:event][:event_starts],'%m/%d/%Y %I:%M %p')
  #  params[:event][:event_end_date]=Time.strptime(params[:event][:event_ends],'%m/%d/%Y %I:%M %p')

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  def register
    @event = Event.find(params[:id])
    @event.registered_users << current_user

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You Registered for a event successfully.' }
      format.json { head :no_content }
    end
  end

  def publish
    @event = Event.find(params[:id])
    @event.published = true
    @event.published_at = Time.now

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: 'Event was successfully published.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  def images
        @event = Event.find(params[:id])
        @images= @event.pictures
  end
 def remove_pictures
  Ckeditor::Asset.where(event_id:nil).delete_all
 end
 def save_image
   #render text:params.inspect
   @event= Event.find(session[:event_id])
  respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
 end
 def save_video
   #render text:params.inspect
   @event= Event.find(session[:event_id])
  respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Video was uploaded successfully.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @event, alert: "File format not allowed."}
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
 end
end
