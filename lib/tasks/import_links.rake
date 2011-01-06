namespace :data do

  desc "generate JSON from Data.csv in project root"
  task :import do
    require 'csv'

    CSV.foreach('Data.csv') do |rec|
      puts "        {
          \"attr\":{\"id\":\"#{rec[2].downcase.gsub(' ', '_').strip}\", \"class\" : \"#{rec[10].to_s.strip}\"},
          \"data\":{
            \"title\" : \"#{rec[2].to_s.strip}\",
            \"attr\" : { \"href\" : \"#{"/docs/" + URI.escape(rec[0].to_s.strip + '/' + rec[8].to_s + '.' + rec[9].to_s.downcase.strip) }\" }
          },
          \"state\":  \"closed\"
          \"geography: \"#{rec[0]}\"
          location: \"#{rec[7]}\"
          filename: \"#{rec[8]}\"
        },"
    end
  end
    
end

