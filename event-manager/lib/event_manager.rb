require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

@civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
@civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zipcode)
  begin
    return(
      @civic_info.representative_info_by_address(
        address: zipcode,
        levels: 'country',
        roles: %w[legislatorUpperBody legislatorLowerBody],
      ).officials
    )
  rescue StandardError
    return(
      'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
    )
  end
end

def save_letter(id, letter)
  filename = "letters/letter_#{id}.html"
  File.open(filename, 'w') { |file| file.puts letter }
end

puts 'Event Manager initialized'

if File.exists? 'event_attendees.csv'
  rows =
    CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  template = File.read('template.html.erb')
  erb_template = ERB.new(template)

  Dir.mkdir('letters') unless Dir.exist?('letters')

  rows.each do |row|
    id = row[0]
    first_name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    legislators = legislators_by_zipcode(zipcode)
    letter = erb_template.result(binding)

    save_letter(id, letter)
  end
end
