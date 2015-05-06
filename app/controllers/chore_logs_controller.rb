class ChoreLogsController < ApplicationController

  # def index
  #   @user = current_user
  #   @house = House.find_by(id: params[:house_id])
  #   @users = @house.users
  #   @chores = @house.chores
  #   @chore = Chore.find_by(id: params[:chore_id])
  #   @chore_logs = @house.users.map {|user| user.chore_logs}

  # end

  def create
    @user = current_user
    @chore = Chore.find_by(id: params[:chore_id])
    @house = @chore.house
    @chores = @house.chores 
    @chore_log = @user.chore_logs.new(chore: @chore)
    params[:house_id] = @house.id
    if @chore_log.save
      redirect_to "/houses/#{@house.id}/chores"
    end
  end

  def destroy
    @user = current_user
    @chore_log = ChoreLog.find_by(id: params[:id])
    @chore = @chore_log.chore
    @house = @chore.house
    @chores = @house.chores
    
    if @chore_log.destroy
      redirect_to "/houses/#{@house.id}/chores"
    end
  end
end
