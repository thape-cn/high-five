module DifyChatInitializable
  extend ActiveSupport::Concern

  private

  def initialize_dify_chat(api_key = Rails.application.credentials.dify_api_key)
    dify_chat = RubyLLM.chat(model: "dify-api", provider: :dify, assume_model_exists: true)
    dify_chat.with_context(RubyLLM.context do |config|
      config.dify_api_base = Rails.application.credentials.dify_base_url
      config.dify_api_key = api_key
    end)
    dify_chat
  end
end
