class WelcomeController < ApplicationController
  before_action :setMostRecentCare, :checkTimeAndReset

  def home
      @mostRecentCareFeedTime = @mostRecentCare.fedAt.in_time_zone('Eastern Time (US & Canada)')
      @fedStatus = @mostRecentCare.fed
      @mostRecentCareMedicateTime = @mostRecentCare.medicatedAt.in_time_zone('Eastern Time (US & Canada)')
      @medicatedStatus = @mostRecentCare.medicated
  end

  def care
    if params[:fed]
      @mostRecentCare.update(fed: true)
      redirect_to root_path
    end
    if params[:medicated]
      @mostRecentCare.update(medicated: true)
      redirect_to root_path
    end
  end

  private

  def setMostRecentCare
    @mostRecentCare = Care.last
    if @mostRecentCare
      mostRecentCareHour = @mostRecentCare.created_at.strftime("%I").to_i
      if mostRecentCareHour >= 0 and mostRecentCareHour <= 12
        @mostRecentCareTimeOfDay = "morning"
      else
        @mostRecentCareTimeOfDay = "evening"
      end
    end
  end

  def checkTimeAndReset
    @currentTimeObject = Time.now
    currentHour = @currentTimeObject.strftime("%I").to_i
    if currentHour >= 0 and currentHour <= 12
      @timeOfDay = "morning"
    else
      @timeOfDay = "evening"
    end
    checkCurrentCare
  end

  def checkCurrentCare
    if @mostRecentCare
      if @mostRecentCare.created_at.strftime("%m%d") == @currentTimeObject.strftime("%m%d")
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
