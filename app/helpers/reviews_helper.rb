module ReviewsHelper
  def review_form_header(review)
    method = review.new_record? ? 'Create new' : 'Edit'
    "#{method} review:"
  end

  def find_reviews_for_item(item)
    item.reviews.order(:updated_at).includes([:user]).limit(5)
  end
end
