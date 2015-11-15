require 'kindergarten_analysis'
require 'graduation_analysis'
require 'kindergarten_graduation_analysis'

class HeadcountAnalyst

  attr_reader :kindergarten_analysis, :graduation_analysis, :kindergarten_graduation_analysis

  def initialize(district_repo)
    @district_repo = district_repo
    @kindergarten_analysis = KindergartenAnalysis.new(district_repo)
    @graduation_analysis = GraduationAnalysis.new(district_repo)
    @kindergarten_graduation_analysis = KindergartenGraduationAnalysis.new(district_repo)
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
    comparison = kindergarten_participation_against_high_school_graduation(district)
    true if (comparison > 0.6 && comparison < 1.5)
  end 
end 
#   def kindergarten_participation_correlates_with_high_school_graduation(district)
#     binding.pry
#     if district.has_key?(:for)
#       kindergarten_graduation_analysis.correlation(district)
#       # correlation = kindergarten_participation_against_high_school_graduation(district[:for])
#       # (correlation  > 0.6 && correlation < 1.5)
#     elsif district[:for] == "STATEWIDE"
#       kindergarten_graduation_analysis.statewide_correlation
#      # district.has_key(:for) && district.has_value?("STATEWIDE")
#          # counter = @district_repo.count do |object|
#          #  kindergarten_participation_against_high_school_graduation(district[:for])
#          # (correlation  > 0.6 && correlation < 1.5)
#     elsif district[:across]
#       kindergarten_graduation_analysis.correlation_for_multiple_districts(district)
#     end 
#   end 
# end 

   # enrollment_repo.find_by_name("Colorado").name
     #  unless  "Colorado" == @district_repo.enrollment_repo.find_by_name("Colorado").name
   
     #   end 
        
     # end 
    #   binding.pry
    #   colorado_data = @district_repo.enrollment_repo.find_by_name("Colorado") #returns colorado enrollment object
    #   subtract_colorado = district_repo - colorado_data
  #   end 





   ####ideas: take in district for method and store as variable - pass on to actual methods to manipulate data in other classes ####
