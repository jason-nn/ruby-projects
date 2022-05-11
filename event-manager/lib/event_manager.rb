require 'csv'
require 'google/apis/civicinfo_v2'

@civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
@civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zipcode)
  begin
    return(
      @civic_info
        .representative_info_by_address(
          address: zipcode,
          levels: 'country',
          roles: %w[legislatorUpperBody legislatorLowerBody],
        )
        .officials
        .map(&:name)
        .join(', ')
    )
  rescue StandardError
    return(
      'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
    )
  end
end

puts 'Event Manager initialized'

if File.exists? 'event_attendees.csv'
  rows =
    CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  rows.each do |row|
    first_name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    legislators = legislators_by_zipcode(zipcode)

    puts "#{first_name} #{zipcode} #{legislators}"
  end
end
