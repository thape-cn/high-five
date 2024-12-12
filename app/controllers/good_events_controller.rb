class GoodEventsController < ApplicationController
  def new
    @good_event = GoodEvent.new
    render layout: false
  end

  def create
    @good_event = GoodEvent.new(good_event_params)

    if @good_event.valid?
      User.find(params[:user_id]).user_good_events.create(good_event: @good_event)
      flash[:success] = t(".success")
    end
  end

  private

  def good_event_params
    params.require(:good_event).permit(:good_title)
  end
end
