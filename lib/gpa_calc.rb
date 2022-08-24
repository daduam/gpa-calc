# frozen_string_literal: true

require 'pdf/reader'

reader = PDF::Reader.new('attempt.pdf')

lines = []

reader.pages.each do |page|
  page.text.split("\n").each { |line| lines << line unless line.empty? }
end

# title = lines[0]
# student = lines[1..2]
# date_printed = lines[3]
lines = lines[4..]

def get_course(line)
  {
    code: line[0].eql?('N/A') ? nil : line[0],
    course_title: line[1].eql?('N/A') ? nil : line[1],
    credit: line[2].eql?('N/A') ? nil : line[2].to_i,
    grade: line[3].eql?('N/A') ? nil : line[3],
    gpt: line[4].eql?('N/A') ? nil : line[4]
  }
end

# recursively record courses
def traverse(lines, idx, record, academic_year, semester)
  return record if idx.eql?(lines.size)

  line = lines[idx].split(/\s{2,}/)

  if line.first.start_with?('ACADEMIC YEAR')
    academic_year = line[1]
    semester = line[2].eql?('FIRST SEMESTER') ? :first : :second

    record[academic_year] = {} if record[academic_year].nil?
    record[academic_year][semester] = []

    idx += 1 # skip line after ACADEMIC RECORD: line
  else
    record[academic_year][semester] << get_course(line)
  end

  traverse(lines, idx + 1, record, academic_year, semester)
end

record = traverse(lines, 0, {}, nil, nil)

pp record
