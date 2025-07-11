RubyLLM.configure do |config|
  # --- Provider API Keys ---
  # Provide keys ONLY for the providers you intend to use.
  # Using environment variables (ENV.fetch) is highly recommended.
  config.openai_api_key = ENV.fetch("OPENAI_API_KEY", nil)
  config.openai_organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID", nil)
  config.openai_project_id = ENV.fetch("OPENAI_PROJECT_ID", nil)
  config.anthropic_api_key = ENV.fetch("ANTHROPIC_API_KEY", nil)
  config.gemini_api_key = ENV.fetch("GEMINI_API_KEY", nil)
  config.deepseek_api_key = ENV.fetch("DEEPSEEK_API_KEY", nil)
  config.openrouter_api_key = ENV.fetch("OPENROUTER_API_KEY", nil)
  config.ollama_api_base = ENV.fetch("OLLAMA_API_BASE", nil)
  config.dify_api_base = ENV.fetch("DIFY_API_BASE", Rails.application.credentials.dify_base_url)
  config.dify_api_key = ENV.fetch("DIFY_API_KEY", Rails.application.credentials.dify_api_key)

  # --- AWS Bedrock Credentials ---
  # Uses standard AWS credential chain (environment, shared config, IAM role)
  # if these specific keys aren't set. Region is required if using Bedrock.
  config.bedrock_api_key = ENV.fetch("AWS_ACCESS_KEY_ID", nil)
  config.bedrock_secret_key = ENV.fetch("AWS_SECRET_ACCESS_KEY", nil)
  config.bedrock_region = ENV.fetch("AWS_REGION", nil) # e.g., 'us-west-2'
  config.bedrock_session_token = ENV.fetch("AWS_SESSION_TOKEN", nil) # For temporary credentials

  # --- Custom OpenAI Endpoint ---
  # Use this for Azure OpenAI, proxies, or self-hosted models via OpenAI-compatible APIs.
  config.openai_api_base = ENV.fetch("OPENAI_API_BASE", nil) # e.g., "https://your-azure.openai.azure.com"

  # --- Default Models ---
  # Used by RubyLLM.chat, RubyLLM.embed, RubyLLM.paint if no model is specified.
  config.default_model = "gpt-4.1-nano"               # Default: 'gpt-4.1-nano'
  config.default_embedding_model = "text-embedding-3-small"  # Default: 'text-embedding-3-small'
  config.default_image_model = "dall-e-3"            # Default: 'dall-e-3'

  # --- Connection Settings ---
  config.request_timeout = 180  # Request timeout in seconds (default: 120)
  config.max_retries = 2        # Max retries on transient network errors (default: 3)
  config.retry_interval = 0.1 # Initial delay in seconds (default: 0.1)
  config.retry_backoff_factor = 2 # Multiplier for subsequent retries (default: 2)
  config.retry_interval_randomness = 0.5 # Jitter factor (default: 0.5)
  config.http_proxy = ENV.fetch("HTTP_PROXY", nil) # Optional HTTP proxy

  # --- Logging Settings ---
  config.log_file = Rails.root.join("log", "ruby_llm.log")
  config.log_level = :debug # debug level can also be set to debug by setting RUBYLLM_DEBUG envar to true
end
