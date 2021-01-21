module StatisticsHelper
  def self.countries_for_item(item)
    item.item_views.group(:country).count
  end

  def self.top_five_countries_for_item(item)
    top_countries = countries_for_item(item).sort { |a, z| a[1] <=> z[1] }.reverse.to_h
    top_countries.slice(*top_countries.keys[0..4])
  end

  def self.rating_changed(item)
    return if item.reviews.count.zero?

    hash1 = item.reviews.group_by_day(:updated_at).sum(:rating)
    hash2 = item.reviews.group_by_day(:updated_at).count
    previous_sum = hash1.first[1]
    previous_count = hash2.first[1]
    answer = {}
    hash1.map do |key, value|
      unless value.nil? || key == hash1.first[0]
        previous_sum += value
        previous_count += hash2[key]
      end
      answer[key] = Float(previous_sum) / previous_count
    end
    answer
  end
end
