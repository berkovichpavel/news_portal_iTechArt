class Subscription < ApplicationRecord
  belongs_to :user
  after_save :change_dispatch_hour

  enum sending_frequency: { 'once_a_day' => 'once_a_day', 'every_two_days' => 'every_two_days',
                            'once_a_week' => 'once_a_week', 'instantly' => 'instantly' }

  def change_dispatch_hour
    update(dispatch_hour: nil) if sending_frequency == 'instantly' && !dispatch_hour.nil?
  end
end
