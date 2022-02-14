require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'
require 'time'

def open_with_csv
	CSV.open("event_attendees.csv",
		headers: true,
		header_converters: :symbol)
end



def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
	civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
	civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

	begin
		legislators = civic_info.representative_info_by_address(
			address: zipcode,
			levels: 'country',
			roles: ['legislatorUpperBody', 'legislatorLowerBody']
			).officials

	rescue
		'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
	end
end

def save_thank_you_letter(id,form_letter)
	Dir.mkdir('output') unless Dir.exist?('output')

	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end

def clean_phone_number(phone_number)
	phone_number = phone_number.split("")

	phone_number.each do |val|
		if val.match /\D/
			phone_number.delete(val)
		end
	end

	phone_number = phone_number.join

	if phone_number[0] == '1' && phone_number.length == 11
		phone_number = phone_number[1..10]
	end
	
	if phone_number.length == 10
		phone_number.insert(3, '-')
		phone_number.insert(7, '-')
	elsif phone_number.length < 10 || phone_number.length >= 11 && phone_number[0] != '1'
		"#{phone_number} is an Invalid phone number"
	end
end

def most_common_hour
	contents = open_with_csv
	reg_hours = []

	contents.each do |row|
		reg_date = row[:regdate]
		reg_date = Time.strptime(reg_date, "%m/%d/%y %H:%M").strftime("%k")
		reg_hours.push(reg_date)
	end

	reg_hour = reg_hours.reduce(Hash.new(0)) do |time, hour|
		time[hour] += 1
		time
	end
	return reg_hour.max_by { |a, b| b}[0]
end

def days_of_week
	days = []

	open_with_csv.each do |row|
		reg_date = row[:regdate]
		reg_date = DateTime.strptime(reg_date, "%m/%d/%y %H:%M").strftime("%A")
		
		days.push(reg_date)
	end
	reg_day_of_week = days.reduce(Hash.new(0)) do |week, day|
		week[day] += 1
		week
	end
	return reg_day_of_week.sort_by {|day, num| num}.last[0]
end

puts "Event Manager Initialized"

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents = open_with_csv

contents.each do |row|
	reg_date = row[:regdate]
	id = row[0]
	name = row[:first_name]
	zipcode = clean_zipcode(row[:zipcode])
	legislators = legislators_by_zipcode(zipcode)
	phone_number = row[:homephone]

	form_letter = erb_template.result(binding)

	save_thank_you_letter(id, form_letter)
	phone_number = clean_phone_number(phone_number)		
end

puts "The peak registration hour is: #{most_common_hour}"
puts "The peak registration day of the week is: #{days_of_week}"
