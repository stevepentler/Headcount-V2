require 'kindergarten_analysis'
require 'graduation_analysis'
require 'kindergarten_graduation_analysis'
require 'enrollment_repo'
require 'keyword_parser_module'

class KindergartenGraduationAnalysis

  include KeywordParser

  attr_reader :kindergarten_analysis,
              :graduation_analysis,
              :enrollment_repo

  def initialize(district_repo)
    @district_repo = district_repo
    @kindergarten_analysis = KindergartenAnalysis.new(district_repo)
    @graduation_analysis = GraduationAnalysis.new(district_repo)
    @enrollment_repo = EnrollmentRepository.new
  end

  def eliminate_key(district)
    KeywordParser.key_parser(district)
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
      statewide_districts(district)
    elsif district.has_key?(:across)
      across_districts(district)
    elsif district.has_key?(:for)
      single_district(district)
    end
  end

  def statewide_districts(district)
    district = eliminate_key(district)
    districts_minus_colorado = @district_repo.enrollment_repo.enrollments.reject do |enrollment|
      enrollment.name == "COLORADO"
    end
    correlation_boolean(districts_minus_colorado)
  end 

  def across_districts(districts)
    district = eliminate_key(districts)
    districts_indicated =  @district_repo.enrollment_repo.enrollments.map do |enrollment|
      enrollment if district.any? {|district| enrollment.name == district}
    end
    correlation_boolean(districts_indicated.compact!)
  end 

  def single_district(district)
    district = eliminate_key(district)
    comparison = kindergarten_participation_against_high_school_graduation(district)
    (comparison > 0.6 && comparison < 1.5) ? true : false
  end 

  def correlation_boolean(select_districts)
      districts_in_range = select_districts.count do |enrollment|
        comparison = kindergarten_participation_against_high_school_graduation(enrollment.name)
        (comparison > 0.6 && comparison < 1.5) ? true : false
    end
    ((districts_in_range / select_districts.count) > 0.70) ? true : false
  end 
end
