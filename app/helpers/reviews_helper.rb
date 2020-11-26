module ReviewsHelper
  def review_form_header(review)
    method = review.new_record? ? 'Create new' : 'Edit'
    "#{method} review:"
  end
end
