require 'csv'
require 'time'

if File.exists? 'event_attendees.csv'
  puts 'Starting process...'
  puts

  rows =
    CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  hours = rows.map { |row| Time.strptime(row[:regdate], '%m/%d/%y %k:%M').hour }

  hash =
    hours.reduce(Hash.new(0)) do |hash, hour|
      hash[hour] += 1
      hash
    end

  sorted = hash.sort_by { |key, value| value }.reverse

  peak =
    sorted
      .select { |value| value.last == sorted.first.last }
      .map { |value| "#{value.first}:00-#{value.first + 1}:00" }

  p peak

  puts
  puts 'Process finished'
end
