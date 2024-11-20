class BadEventsController < ApplicationController
  def new
    @bad_event = BadEvent.new
    render layout: false
  end
end
