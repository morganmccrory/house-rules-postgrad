class NotificationsController < ApplicationController

  def destroy
    @house = current_user.houses.first
    if params[:id] == "all"
            @house = current_user.houses.first
      @user_notifications = UserNotification.where(user_id: current_user.id)
        @user_notifications.each do |un|
          un.destroy
        end
      redirect_to "/houses/#{@house.id}"
    else
      @notification = Notification.find(params[:id])
      unless @notification.id == 1
        @user_notifications = UserNotification.where(notification_id: @notification.id)
          @user_notifications.each do |un|
            un.destroy
          end
        @notification.destroy
      end
      redirect_to "/houses/#{@house.id}/#{@notification.category}"
    end
  end
end
