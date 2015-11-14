require_relative 'district_repo'
require_relative 'enrollment_repo'

class EnrollmentAnalysis

  def initialize(district_repo)
  @district_repo = district_repo
  end

  def pull_district_objects(district)
    @district_repo.enrollment_repo.find_by_name(district)
  end

  def district_average(district)
    district = pull_district_objects(district)
    district_avg = (district.kindergarten_data.values.inject(:+) / district.kindergarten_data.count).round(3)
  end 

  def participation_rate_variation(district1, district2)
    comparison = (district_average(district1) / district_average(district2)).round(3)
  end

  def participation_rate_variation_trend(district1, district2)
    district1 = pull_district_objects(district1)
    district2 = pull_district_objects(district2)
    yearly_comparison = {}    
    district1.kindergarten_data.each do |year, value|
      if district2.kindergarten_data.include?(year)
        division = district1.kindergarten_data[year] / district2.kindergarten_data[year]
        yearly_comparison[year] = division.round(3)
      end 
    end 
    yearly_comparison
  end 

end 