# frozen_string_literal: true

require 'pdf/reader'

reader = PDF::Reader.new('attempt.pdf')

lines = []

reader.pages.each do |page|
  page.text.split("\n").each { |line| lines << line unless line.empty? }
end

student = lines[1..3]
lines = lines[4..]

# recursively record courses
def traverse(lines, i, record, academic_year, semester)
  record
end

record = traverse(lines, 0, {}, nil, nil)

p record
