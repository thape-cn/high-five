class AddReviewSummaryToContractReview < ActiveRecord::Migration[8.0]
  def change
    add_column :contract_reviews, :review_summary, :string
  end
end
