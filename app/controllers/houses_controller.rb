class HousesController < ApplicationController

  def index
    @houses = House.all
  end

  def show
    @user = current_user
    @current_house = @user.houses.first
    @house = House.find_by(id: params[:id])
    @address = @house.address
    if HousingAssignment.find_by(user_id: @user.id, house_id: @house.id)
      @property_manager = @house.property_manager
      @assignment = HousingAssignment.where(user: current_user, house: @house.id)
    else
      if @user.houses.nil?
      redirect_to "/houses/#{@house.id}/join"
      else
        redirect_to "/houses/#{@current_house.id}"
      end
    end
  end

  def roommates
    @user = current_user
    @house = House.find(params[:id])
    @roommates = @house.users
  end

  def new
    @house = House.new
    @address = Address.new
  end

  def create
    if @user = current_user
      if @user.houses != nil
        @house = House.new(house_params)
        if @house.save
          @address = @house.address=Address.new(address_params)
          if @address.save
            @user.housing_assignments.create(user: @user, house: @house)
              @notification = Notification.create(alert: "You have successfully created #{@house.name}!", category: "", house_id: @house.id)
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
      end
    else
      redirect_to '/login'
    end
  end

  def edit
    @house = House.find(params[:id])
    @address = @house.address
  end

  def update
    if @user = current_user
      @house = House.find(params[:id])
      @house.update_attributes(house_params)
      @house.address.update_attributes(address_params)
          @notification = Notification.create(alert: "#{current_user.first_name} has updated #{@house.name}.", category: "", house_id: @house.id)
          HousingAssignment.where(house_id: @house.id).select do |assignment|
            assignment.user.user_notifications.create(notification: @notification)
          end
      redirect_to house_path(@house)
    else
      redirect_to '/login'
    end
  end

  def destroy
    if @user = current_user
      @house = House.find(params[:id])
      redirect_to user_path(@user)
    else
      redirect_to '/login'
    end
  end

  def join
    @user = current_user
    @house = House.find(params[:id])
  end

  def join_update
    if @user = current_user
      @house = House.find(params[:id])
      if params[:join][:house_key] == @house.house_key
        HousingAssignment.create(user_id: @user.id, house_id: @house.id)
        redirect_to house_path(@house)
      else
        render 'join'
      end
    else
      redirect_to '/login'
    end
  end

  def search
    houses = House.all.select{|house| house.name.downcase.include?(params[:keyword].downcase)}
    if houses != []
      render json: houses.to_json
    else
      render json: "No".to_json
    end
  end

  private

  def house_params
    params.require(:house).permit(:name, :house_key)
  end

  def address_params
    params.require(:house).require(:address).permit(:street, :city, :state, :zip_code)
  end

end
