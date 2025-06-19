class LLMChannel < ApplicationCable::Channel
  def subscribed
    stream_from "llm_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
