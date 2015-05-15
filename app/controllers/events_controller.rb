class EventsController < ApplicationController
skip_before_action :authenticate_user_from_token!, only: [:index, :edit, :create]

  def index
    @house = House.find(params[:house_id])
    @event = Event.new
    if @user = current_user
      if @user.houses.first == @house
        @events = @house.events
        @today = Date.today
      else
        render :nothing => true, :status => 400
      end
    else
      redirect_to "/login"
    end
  end

  def new
    @house = House.find(params[:house_id])
    @event = Event.new
  end

  def create
    @user = current_user
    @house = House.find(params[:house_id])
    @event = @house.events.new(event_params)
    @event.save
    @notification = Notification.create(alert: "#{current_user.first_name} has added #{@event.title} to Events.", category: "events", house_id: @house.id)
        HousingAssignment.where(house_id: @house.id).select do |assignment|
          assignment.user.user_notifications.create(notification: @notification)
        end
    @event.update_attributes(user_id: @user.id)
    if request.xhr?
      render :json => {
        :event => @event
      }
    end
  end

  def source
    @house = House.find(params[:id])
    @events = @house.events
    render :json => @events
  end

  def edit
    @user = current_user
    @house = House.find(params[:house_id])
    @event = Event.find(params[:id])
    respond_to do |wants|
      wants.html { render :layout => false }
    end
  end

  def update
    @event = Event.find(params[:id])
    @house = House.find(params[:house_id])
    if request.xhr?
      @event.update_attributes(event_params)
      @notification = Notification.create(alert: "#{current_user.first_name} has updated #{@event.title}", category: "events", house_id: @house.id)
      HousingAssignment.where(house_id: @house.id).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
    render :json => {
      :event => @event
    }
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @house = House.find(params[:house_id])
    if request.xhr?
      @event.destroy
      @notification = Notification.create(alert: "#{current_user.first_name} has deleted #{@event.title}.", category: "events", house_id: @house.id)
      HousingAssignment.where(house_id: @house.id).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
      render :nothing => true, :status => 200
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end, :all_day, :overlap, :description)
  end

end
