require_relative 'enrollment_formatter'
require 'pry'

class EnrollmentRepository

  attr_reader :enrollments

  def initialize
    @enrollments = []
    @enrollment_formatter = EnrollmentFormatter.new
  end

  def load_data(parsed_csv)
    if parsed_csv.has_key?(:enrollment)
      csv_parser = CSVParser.new(parsed_csv)
      parsed_csv = csv_parser.parsed_csv
      @enrollment_formatter.district_governor(parsed_csv)
      create_enroll_objects
    end
  end

  def create_enroll_objects
    @enrollment_formatter.enrollments_hash.each do |enrollment|
      @enrollments << Enrollment.new(enrollment)
    end
  end

  def find_by_name(name)
    @enrollments.find do |enrollment|
      name.upcase == enrollment.name.upcase
    end
  end

  def find_by_matching
    find_all = @enrollments.select do |enrollment|
      enrollment if enrollment.name.include?(word_fragment.upcase)
    end
    find_all
  end
end
