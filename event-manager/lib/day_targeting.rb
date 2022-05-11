require 'csv'
require 'time'

@days = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]

if File.exists? 'event_attendees.csv'
  puts 'Starting process...'
  puts

  rows =
    CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  days =
    rows.map do |row|
      @days[Time.strptime(row[:regdate], '%m/%d/%y %k:%M').wday]
    end

  hash =
    days.reduce(Hash.new(0)) do |hash, hour|
      hash[hour] += 1
      hash
    end

  sorted = hash.sort_by { |key, value| value }.reverse

  peak =
    sorted
      .select { |value| value.last == sorted.first.last }
      .map { |value| value.first }

  p peak

  puts
  puts 'Process finished'
end
