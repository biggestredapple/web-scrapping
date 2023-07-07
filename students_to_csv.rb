require 'open-uri'
require 'nokogiri'
require 'csv'


PAGE_TO_VISIT = 'https://techcareerbooster-fake-data.herokuapp.com/exercises_and_code/students'

content = URI.open(PAGE_TO_VISIT).read

html_doc = Nokogiri::HTML(content)

csv_headers = %w[id name email street zip_code country]

CSV.open('students.csv', 'wb') do |csv|
    csv << csv_headers

    page = 1

    begin
        student_rows = html_doc.css('table tbody tr')

        student_rows.each do |student_row|
            id = student_row.at_css('td:nth-child(1)').content
            name = student_row.at_css('td:nth-child(2)').content
            email = student_row.at_css('td:nth-child(3)').content
            street = student_row.at_css('td:nth-child(4)').content
            zip_code = student_row.at_css('td:nth-child(5)').content
            country = student_row.at_css('td:nth-child(6)').content

            csv << [id, name, email, street, zip_code, country]
        end
    
        page += 1

        content = URI.open("#{PAGE_TO_VISIT}?page=#{page}")
        html_doc = Nokogiri::HTML(content)
    end while student_rows.count > 0
end

# puts content