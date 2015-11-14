require 'kindergarten_analysis'
require 'graduation_analysis'
class HeadcountAnalyst

  attr_reader :kindergarten_analysis, :graduation_analysis

  def initialize(district_repo)
    @district_repo = district_repo
    @kindergarten_analysis = KindergartenAnalysis.new(district_repo)
    @graduation_analysis = GraduationAnalysis.new(district_repo)
  end

  def district_kindergarten_average(district)
    kindergarten_analysis.kindergarten_average(district)
  end 

  def kindergarten_participation_rate_variation(district1, district2)
    kindergarten_analysis.kindergarten_state_comparison(district1, district2)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    kindergarten_analysis.kindergarten_rate_variation_trend(district1, district2)
  end

  def graduation_participation_rate_variation(district1, district2)
    graduation_analysis.graduation_state_comparison(district1, district2)
  end

  def kindergarten_participation_against_high_school_graduation(district)
    comparison = (kindergarten_participation_rate_variation(district, "Colorado") / 
      graduation_participation_rate_variation(district, "Colorado")).round(3)
    comparison
  end 

  def kindergarten_participation_correlates_with_high_school_graduation(district)
    if district.has_key?(:for)
      correlation = kindergarten_participation_against_high_school_graduation(district[:for])
      (correlation  > 0.6 && correlation < 1.5)
    end
  end 





end 


  # def kindergarten_participation_correlates_with_high_school_graduation(district)
  #   # comparison = kindergarten_participation_against_high_school_graduation(district)
  #   # true if comparison > 0.6 && < 1.5
  # end 

  # def kindergarten_participation_correlates_with_high_school_graduation(statewide)
  #   # #iterate through each district
  # #   # #count number of districts where:
  #   districts_above_seventy = statewide.count do |district|
  #     #kindergarten_participation_against_high_school_graduation(district) 
  #   kindergarten_participation_correlates_with_high_school_graduation(district)
  # #   # end 
  # #   # #true if count / districts.count > 0.70
  #   true if (districts_above_seventy / districts.count) > 0.70 
  # # end 



   ####ideas: take in district for method and store as variable - pass on to actual methods to manipulate data in other classes ####
