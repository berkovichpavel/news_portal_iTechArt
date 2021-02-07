class Statistic < ApplicationRecord
  validates :begin_statistic, presence: true
  validates :end_statistic, presence: true
end
