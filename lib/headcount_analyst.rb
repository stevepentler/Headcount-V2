require 'enrollment_analysis'
class HeadcountAnalyst

  def initialize(district_repo)
    @district_repo = district_repo
    @enrollment_analysis = EnrollmentAnalysis.new(district_repo)
  end

  def district_kindergarten_average(district)
    @enrollment_analysis.district_average(district)
  end 

  def kindergarten_participation_rate_variation(district1, district2)
    @enrollment_analysis.participation_rate_variation(district1, district2)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    @enrollment_analysis.participation_rate_variation_trend(district1, district2)
  end
end 

  # def district_graduation_average(district)
  #   district = pull_district_objects(district)
  #   district_avg = (district.graduation_data.values.inject(:+) / district.graduation_data.count).round(3)
  # end 

  # def graduation_participation_rate_variation(district1, district2)
  #   comparison = (district_graduation_average(district1) / district_graduation_average(district2)).round(3)
  # end

  # def graduation_participation_rate_variation_trend(district1, district2)
  #   district1 = pull_district_objects(district1)
  #   district2 = pull_district_objects(district2)
  #   yearly_comparison = {}    
  #   district1.graduation_data.each do |year, value|
  #     if district2.graduation_data.include?(year)
  #       division = district1.graduation_data[year] / district2.graduation_data[year]
  #       yearly_comparison[year] = division.round(3)
  #     end 
  #   end 
  #   yearly_comparison
  # end 

  # def kindergarten_participation_against_high_school_graduation(district)
  #   kindergarten_variation = kindergarten_participation_rate_variation_trend(district1, "Colorado")
  #   graduation_variation = graduation_participation_rate_variation_trend(district1, "Colorado")
  #   comparison = (kindergarten_variation / graduation_variation)
  # end 


  # def kindergarten_participation_correlates_with_high_school_graduation(district)
  #   # comparison = kindergarten_participation_against_high_school_graduation(district)
  #   # true if comparison > 0.6 && < 1.5
  # end 

  # def kindergarten_participation_correlates_with_high_school_graduation(statewide)
  #   # #iterate through each district
  #   # #count number of districts where:
  #   # districts_above_seventy = statewide.count do |district|
  #   #   #kindergarten_participation_against_high_school_graduation(district) 
  #   # kindergarten_participation_correlates_with_high_school_graduation(district)
  #   # end 
  #   # #true if count / districts.count > 0.70
  #   # true if (districts_above_seventy / districts.count) > 0.70 
  # end 
   

   ####ideas: take in district for method and store as variable - pass on to actual methods to manipulate data in other classes ####
