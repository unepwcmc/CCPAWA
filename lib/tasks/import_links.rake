namespace :data do

  desc "generate JSON from Data.csv in project root"
  task :import do
    require 'csv'

    CSV.foreach('Data.csv') do |rec|
      puts "        {
          \"attr\":{\"id\":\"#{rec[2].downcase.gsub(' ', '_')}\", \"class\" : \"#{rec[10]}\"},
          \"data\":{
            \"title\" : \"#{rec[2]}\",
            \"attr\" : { \"href\" : \"#{"/docs/" + URI.escape(rec[0].to_s + '/' + rec[8].to_s + '.' + rec[9].to_s.downcase) }\" }
          },
          \"state\":  \"closed\"
          \"geography: \"#{rec[0]}\"
          location: \"#{rec[7]}\"
          filename: \"#{rec[8]}\"
        },"
    end
  end
    
end

