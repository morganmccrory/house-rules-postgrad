class ChoresController < ApplicationController

  def index
    @house = House.find(params[:house_id])
    if @user = current_user
      @user_house = @user.houses.first
      if @user_house == @house
        @chores = @house.chores
        @users = @house.users
        @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
        @chore_logs = @house.users.map {|user| user.chore_logs}
      else
        redirect_to "/houses/#{@user_house.id}/chores"
      end
    else
      redirect_to "/login"
    end
  end

  def edit
    @user = current_user
    @chore = Chore.find(params[:id])
    @house = @chore.house
    render :edit
  end


  def update
    if @user = current_user
      chore = Chore.find(params[:id])
      chore.update_attributes(chore_params)
      @house = chore.house
      if chore.save!
        @notification = Notification.create(alert: "#{current_user.first_name} has updated #{@chore.task} in Chores.", category: "chores", house_id: @house.id)
        HousingAssignment.where(house_id: @house.id).select do |assignment|
          assignment.user.user_notifications.create(notification: @notification)
        end
        redirect_to "/houses/#{@house.id}/chores"
      else
        flash.now[:error] = "chore did not save"
        redirect_to house_path(@house)
      end
    else
      redirect_to '/login'
    end
  end

  def show
    @user = current_user
    @chore = Chore.find_by(id: params[:id])
    @house = @chore.house
    @chores = @house.chores
    @logged_users = @chore.chore_logs.map{|log| log.user_id }
    @logged_users.uniq!
    if @logged_users.size > 1
      @logged_users.map!{|id| User.find(id)}
    else
      @logged_users = User.find(@logged_users)
    end
    render :show
  end

  def create
    if @user = current_user
      @house = House.find_by(id: params[:house_id])
      @chore = @house.chores.new(chore_params)
      @users = @house.users
      if @chore.save
        @notification = Notification.create(alert: "#{current_user.first_name} has added #{@chore.task} to Chores.", category: "chores", house_id: @house.id)
        HousingAssignment.where(house_id: @house.id).select do |assignment|
          assignment.user.user_notifications.create(notification: @notification)
        end
        redirect_to "/houses/#{@house.id}/chores"
      else
        flash.now[:error] = "chore did not save"
        redirect_to house_path(@house)
      end
    else
      redirect_to '/login'
    end
  end

  def destroy
    if @user = current_user
      chore = Chore.find(params[:id])
      @house = chore.house
      @chore_logs = ChoreLog.where(chore_id: chore.id)
      @chore_logs.each{|log| log.destroy}
      params[:house_id] = @house.id
      chore.destroy
      @notification = Notification.create(alert: "#{current_user.first_name} has deleted #{chore.task} in Chores.", category: "chores", house_id: @house.id)
      HousingAssignment.where(house_id: @house.id).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
      redirect_to "/houses/#{@house.id}/chores"
    else
      redirect_to '/login'
    end
  end

  private

  def chore_params
    params.require(:chore).permit(:task)
  end

end
