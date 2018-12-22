class WelcomeController < ApplicationController
  before_action :setMostRecentCare, :checkTimeAndReset

  def home
      @mostRecentCareFeedTime = @mostRecentCare.fedAt.in_time_zone('Eastern Time (US & Canada)')
      @fedStatus = @mostRecentCare.fed
      @mostRecentCareMedicateTime = @mostRecentCare.medicatedAt.in_time_zone('Eastern Time (US & Canada)')
      @medicatedStatus = @mostRecentCare.medicated
      @currentTimeObject
      if @currentTimeObject.strftime("%p") == 'PM'
        secondLastCare = Care.all[-2]
        if secondLastCare.created_at.strftime("%p") == 'AM' && secondLastCare.created_at.strftime("%m%d") == @currentTimeObject.strftime("%m%d")
          @morningCare = secondLastCare
        end
      end
  end

  def care
    if params[:fed]
      @mostRecentCare.update(fed: true, fedAt: @currentTimeObject)
      redirect_to root_path
    end
    if params[:medicated]
      @mostRecentCare.update(medicated: true, medicatedAt: @currentTimeObject)
      redirect_to root_path
    end
  end

  private

  def setMostRecentCare
    @mostRecentCare = Care.last
    if @mostRecentCare
      if @mostRecentCare.created_at.strftime("%p") == 'AM'
        @mostRecentCareTimeOfDay = "morning"
      else
        @mostRecentCareTimeOfDay = "evening"
      end
    end
  end

  def checkTimeAndReset
    @currentTimeObject = Time.now.in_time_zone('Eastern Time (US & Canada)')
    if @currentTimeObject.strftime("%p") == 'AM'
      @timeOfDay = "morning"
    else
      @timeOfDay = "evening"
    end
    checkCurrentCare
  end

  def checkCurrentCare
    # check if there are any cares
    if @mostRecentCare
      # check if most recent care created was today
      if @mostRecentCare.created_at.strftime("%m%d") == @currentTimeObject.strftime("%m%d")
        # checks if the current AM/PM matches the last care's AM/PM
        if @timeOfDay == @mostRecentCareTimeOfDay
          return
        else
          @mostRecentCare = Care.create(fed: false, medicated: false, fedAt: @currentTimeObject, medicatedAt: @currentTimeObject)
        end
      else
        @mostRecentCare = Care.create(fed: false, medicated: false, fedAt: @currentTimeObject, medicatedAt: @currentTimeObject)
      end
    else
      @mostRecentCare = Care.create(fed: false, medicated: false, fedAt: @currentTimeObject, medicatedAt: @currentTimeObject)
    end
  end
end
