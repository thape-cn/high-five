class BadEventsController < ApplicationController
  def new
    @bad_event = BadEvent.new
    render layout: false
  end

  def create
    @bad_event = BadEvent.new(bad_event_params)

    if @bad_event.valid?
      current_user.user_bad_events.create(bad_event: @bad_event)
      flash[:success] = t(".success")
    end
  end

  private

  def bad_event_params
    params.require(:bad_event).permit(:bad_title)
  end
end
