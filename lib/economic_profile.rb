require_relative 'standard_errors'
class EconomicProfile


  attr_reader :name, :economic_profiles

  def initialize(economic_profiles)
    @name = economic_profiles[:name]
    @economic_profiles = economic_profiles
  end

  def estimated_median_household_income_in_year(year)
    values = economic_profiles[:median_household_income].map do |years, value|
            value if (year >= years[0]) && (year <= years[1])
    end
    fail UnknownDataError unless values != nil
        ((values.compact.inject(:+))/values.compact.size).round.to_i
  end

  def median_household_income_average
     values = economic_profiles[:median_household_income].map do |years, value|
            value
            end
    ((values.compact.inject(:+))/values.size).round.to_i
  end

  def children_in_poverty_in_year(year)
    fail UnknownDataError unless economic_profiles[:children_in_poverty][year]
    economic_profiles[:children_in_poverty][year]
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    fail UnknownDataError unless economic_profiles[:free_or_reduced_price_lunch][year]
    economic_profiles[:free_or_reduced_price_lunch][year][:percentage]
  end

  def free_or_reduced_price_lunch_number_in_year(year)
    fail UnknownDataError unless economic_profiles[:free_or_reduced_price_lunch][year]
    economic_profiles[:free_or_reduced_price_lunch][year][:total].round.to_i
  end

  def title_i_in_year(year)
    fail UnknownDataError unless economic_profiles[:title_i][year]
    economic_profiles[:title_i][year]
  end

end
