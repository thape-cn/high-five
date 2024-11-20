class GoodEventsController < ApplicationController
  def new
    @good_event = GoodEvent.new
    render layout: false
  end
end
