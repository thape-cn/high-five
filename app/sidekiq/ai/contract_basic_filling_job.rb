class AI::ContractBasicFillingJob
  include Sidekiq::Job

  def perform(contract_basic_id, field_name)
  end
end
