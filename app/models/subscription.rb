class Subscription < ApplicationRecord
  belongs_to :user

  enum sending_frequency: { 'once_a_day' => 'once_a_day', 'every_two_days' => 'every_two_days',
                            'once_a_week' => 'once_a_week', 'instantly' => 'instantly' }
end
