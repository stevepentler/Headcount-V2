require 'kindergarten_analysis'
require 'graduation_analysis'
require 'kindergarten_graduation_analysis'
require 'enrollment_repo'

class HeadcountAnalyst

  attr_reader :kindergarten_analysis, 
              :graduation_analysis, 
              :kindergarten_graduation_analysis,
              :enrollment_repo

  def initialize(district_repo)
    @district_repo = district_repo
    @kindergarten_analysis = KindergartenAnalysis.new(district_repo)
    @graduation_analysis = GraduationAnalysis.new(district_repo)
    @kindergarten_graduation_analysis = KindergartenGraduationAnalysis.new(district_repo)
    @enrollment_repo = EnrollmentRepository.new
  end

  def eliminate_key(district)
    if district.class == String
      district
    elsif district.has_key?(:for)
      district = district.delete(:for)
    elsif district.has_key?(:against)
      district = district.delete(:against)
    end 
  end 

  def district_kindergarten_average(district)
    kindergarten_analysis.kindergarten_average(district)
  end 

  def kindergarten_participation_rate_variation(district1, district2)
    district2 = eliminate_key(district2)
    kindergarten_analysis.kindergarten_state_comparison(district1, district2)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    district2 = eliminate_key(district2)
    kindergarten_analysis.kindergarten_rate_variation_trend(district1, district2)
  end

  def graduation_participation_rate_variation(district1, district2)
    district2 = eliminate_key(district2)
    graduation_analysis.graduation_state_comparison(district1, district2)
  end

  def kindergarten_participation_against_high_school_graduation(district)
    district = eliminate_key(district)
    comparison = (kindergarten_participation_rate_variation(district, :against => "COLORADO") / 
      graduation_participation_rate_variation(district, :against => "COLORADO")).round(3)
    comparison
  end 

  def kindergarten_participation_correlates_with_high_school_graduation(district)
    if district.has_key?(:for) && district[:for] == "STATEWIDE"
      district = eliminate_key(district)
      districts_minus_colorado = @district_repo.enrollment_repo.enrollments.reject do |enrollment| 
          enrollment.name == "COLORADO"
      end 
      districts_in_range = districts_minus_colorado.count do |enrollment|
        comparison = kindergarten_participation_against_high_school_graduation(enrollment.name)
        (comparison > 0.6 && comparison < 1.5) ? true : false
      end
      ((districts_in_range / districts_minus_colorado.count) > 0.70) ? true : false
    elsif district.has_key?(:for)
      district = eliminate_key(district)
      comparison = kindergarten_participation_against_high_school_graduation(district)
      (comparison > 0.6 && comparison < 1.5) ? true : false
    # elsif district.has_key?(:against)
    end 
  end
end





      #bring in district as {:for => "STATEWIDE"}
      #set holder = ALL DISTRICTS - "COLORADO"
      #iterate through set_holder
        #total = set_holder.count districts that evaluate to true with 
          # comparison = kindergarten_participation_against_high_school_graduation(district)
          # (comparison > 0.6 && comparison < 1.5) ? true : false
        #end 
      #(total / set_holder.count)

      #enrollments.each do |enrollment|
        #if  enrollment.name != "Colorado"

      #ene
    #end 





#     end 
#   end 
# end 
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





   ####ideas: take in district for method and store as variable - pass on to actual methods to manipulate data in other classes ####
