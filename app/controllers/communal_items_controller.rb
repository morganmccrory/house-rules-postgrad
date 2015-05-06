class CommunalItemsController < ApplicationController

  def index
    @house = House.find(params[:house_id])
    if @user = current_user
      if @user.houses.first == @house
          @items = @house.communal_items
          @stock_levels = ["high","low","out"]
           @items_out = @items.select {|i| i.stock_level == "out"}
          @items_low = @items.select {|i| i.stock_level == "low"}
          @items_high = @items.select {|i| i.stock_level == "high"}
      else
        render :nothing => true, :status => 400
      end
    else
      redirect_to "/login"
    end
  end

  def create
      @house = House.find(params[:house_id])
      @item = @house.communal_items.create(item_params)
      if @item.save
        @notification = Notification.create(alert: "#{current_user.first_name} has added #{@item.name} to the inventory.", category: "communal_items", house_id: @house.id)
        HousingAssignment.where(house_id: @house.id).select do |assignment|
          assignment.user.user_notifications.create(notification: @notification)
        end
        redirect_to house_communal_items_path(@house)
      else
          render 'new'
      end
  end

  def edit
    @house = House.find(params[:house_id])
    @item = CommunalItem.find(params[:id])
  end

  def update
      @house = House.find(params[:house_id])
      @item = CommunalItem.find(params[:id])
      @item.update(item_params)
      @notification = Notification.create(alert: "#{current_user.first_name} has changed #{@item.name} in the inventory.", category: "communal_items", house_id: @house.id)
        HousingAssignment.where(house_id: @house.id).select do |assignment|
          assignment.user.user_notifications.create(notification: @notification)
        end
      redirect_to house_communal_items_path(@house)
  end

  def destroy
    if @user = current_user
      @house = House.find(params[:house_id])
      @item = CommunalItem.find(params[:id])
      @item.destroy
      @notification = Notification.create(alert: "#{current_user.first_name} has deleted #{@item.name} from the inventory.", category: "communal_items", house_id: @house.id)
        HousingAssignment.where(house_id: @house.id).select do |assignment|
          assignment.user.user_notifications.create(notification: @notification)
        end
      redirect_to house_communal_items_path(@house)
    else
      redirect_to '/login'
    end
  end

  def high
    if @user = current_user
      @house = House.find(params[:house_id])
      @item = CommunalItem.find(params[:id])
      @item.stock_level = "high"
      @item.save
      @user_promise = @item.user_promise
      if @user_promise
        @user_promise.destroy
      end
      redirect_to house_communal_items_path(@house)
    else
      redirect_to '/login'
    end
  end

  def low
    if @user = current_user
      @house = House.find(params[:house_id])
      @item = CommunalItem.find(params[:id])
      @item.stock_level = "low"
      @item.save
      redirect_to house_communal_items_path(@house)
    else
      redirect_to '/login'
    end
  end

  def out
    if @user = current_user
      @house = House.find(params[:house_id])
      @item = CommunalItem.find(params[:id])
      @item.stock_level = "out"
      @item.save
      redirect_to house_communal_items_path(@house)
    else
      redirect_to '/login'
    end
  end

  private

  def item_params
    params.require(:communal_item).permit(:name, :brand, :quantity, :stock_level)
  end

end
