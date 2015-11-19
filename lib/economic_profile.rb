class EconomicProfile

  def estimated_median_household_income_in_year(year)
    if statewide_test_data.has_key?(year)
    else
      raise UnknownDataError.new
    end
  end

  def median_household_income_average
  end

  def children_in_poverty_in_year(year)
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
  end

  def free_or_reduced_price_lunch_number_in_year(year)
  end

  def title_i_in_year(year)
  end




end
