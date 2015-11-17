require_relative 'district_repository'

class KindergartenAnalysis

  def initialize(district_repo)
    @district_repo = district_repo
  end

  def pull_district_objects(district)
    @district_repo.enrollment_repo.find_by_name(district)
  end

  def kindergarten_average(district)
    district = pull_district_objects(district)
    district_avg = (district.kindergarten_data.values.inject(:+) / district.kindergarten_data.count)
    truncate(district_avg)
  end

  def kindergarten_state_comparison(district1, district2)
    unless district1 == "COLORADO"
      comparison = (kindergarten_average(district1) / kindergarten_average(district2))
      truncate(comparison)
    end
  end

  def kindergarten_rate_variation_trend(district1, district2)
    district1 = pull_district_objects(district1)
    district2 = pull_district_objects(district2)
    yearly_comparison = {}
    district1.kindergarten_data.each do |year, value|
      if district2.kindergarten_data.include?(year)
        division = district1.kindergarten_data[year] / district2.kindergarten_data[year]
        yearly_comparison[year] = truncate(division)
       else
        yearly_comparison[year] = nil
      end
    end
    yearly_comparison
  end

  def truncate(float)
    (float * 1000).floor / 1000.to_f
  end

end
