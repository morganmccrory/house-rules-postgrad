class PropertyManagersController < ApplicationController

  def new
    @house = House.find(params[:house_id])
    @manager = PropertyManager.new
  end

  def create
    if @user = current_user
      @house = House.find(params[:house_id])
      @address = Address.new(address_params)
      if @address.save
        @manager = PropertyManager.new(property_manager_params)
        if @manager.save
          @house.update_attributes(property_manager_id: @manager.id)
          @address.update_attributes(addressable_type: "PropertyManager", addressable_id: @manager.id)
            @notification = Notification.create(alert: "#{current_user.first_name} has added #{@manager.name} as the property manager of #{@house.name}.", category: "", house_id: @house.id)
            HousingAssignment.where(house_id: @house.id).select do |assignment|
              assignment.user.user_notifications.create(notification: @notification)
            end
          redirect_to house_path(@house)
        else
          render "new"
        end
      else
        render "new"
      end
    else
      redirect_to '/login'
    end
  end

  def edit
    @house = House.find(params[:house_id])
    @manager = PropertyManager.find(params[:id])
    @address = @manager.address
  end

  def update
    if @user = current_user
      @house = House.find(params[:house_id])
      @manager = PropertyManager.find(params[:id])
      @manager.update(property_manager_params)
      @address = @manager.address
      @address.update_attributes(address_params)
        @notification = Notification.create(alert: "#{current_user.first_name} has updated #{@manager.name} as the property manager of #{@house.name}.", category: "", house_id: @house.id)
        HousingAssignment.where(house_id: @house.id).select do |assignment|
          assignment.user.user_notifications.create(notification: @notification)
        end
      redirect_to house_path(@house)
    else
      redirect_to '/login'
    end
  end

  private

  def property_manager_params
    params.require(:property_manager).permit(:name, :phone, :email)
  end

  def address_params
    params.require(:property_manager).require(:address).permit(:street, :city, :state, :zip_code)
  end

end
