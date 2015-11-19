require_relative 'standard_errors'
class EconomicProfile


  attr_reader :name, :economic_profiles

  def initialize(economic_profiles)
    @name = economic_profiles[:name]
    @economic_profiles = economic_profiles
  end 

  def estimated_median_household_income_in_year(year)
    values = economic_profiles[:median_household_income].map do |years, value|
      if (years[0] >= year <= years[1]) 
      end
    end
    ((values.inject(:+))/values.size)
  end

  def median_household_income_average
  end

  def children_in_poverty_in_year(year)
    economic_profiles[:children_in_poverty][year]
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    verify_year(year)
  end

  def free_or_reduced_price_lunch_number_in_year(year)
  end

  def title_i_in_year(year)
    verify_year(year)
  end

  def economic_profile
    verify_year(year)
  end 

  # def verify_year(year)
  #   if economic_profiles.has_key?(year) == false
  #     raise UnknownDataError
  #   end
  # end

end