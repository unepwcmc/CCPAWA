namespace :data do

  desc "generate JSON from Data.csv in project root"
  task :import do
    require 'csv'

    CSV.foreach('Data.csv') do |rec|
      puts "        {
          \"attr\":{\"id\":\"#{rec[2].downcase.gsub(' ', '_').strip}\", \"class\" : \"#{rec[10].to_s.strip}\"},
          \"data\":{
            \"title\" : \"#{rec[2].to_s.strip}\","
      if rec[8].present?      
        puts  "            \"attr\" : { \"href\" : \"#{"/docs/" + URI.escape(rec[0].to_s.strip + '/' + rec[8].to_s + '.' + rec[9].to_s.downcase.strip) }\" }"
      else
        puts "            \"attr\" : { \"href\" : \"#{rec[11].to_s.downcase.strip}\" }"
      end
      puts "            },
          \"state\":  \"closed\"
          \"geography: \"#{rec[0]}\"
          location: \"#{rec[7]}\"
          filename: \"#{rec[8]}\"
          url: \"#{rec[11]}\"
        },"
    end
  end

  desc "generate a hash of of title => topics"
  task :title_to_topic do
    require 'csv'

    title_topic = {}
    CSV.foreach('Data.csv') do |rec|
      title_topic[rec[2].strip] = rec[1].strip
    end
    puts title_topic
  end

  desc "create JSON from data and title_to_topic"
  task :create_topic_json do
    require 'csv'
    require 'json'

    title_topic = {}
    CSV.foreach('Data.csv') do |rec|
      title_topic[rec[2].strip] = rec[1].strip
    end

    #This array was created from the parsed JSON, contains only the data nodes, no folders
    data = [{"attr"=>{"id"=>"biodiversity_hotspots", "class"=>"Map"}, "data"=>{"title"=>"Biodiversity Hotspots", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"http://www.conservation.org/Documents/cihotspotmap.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"global_200_ecoregions", "class"=>"Map"}, "data"=>{"title"=>"Global 200 Ecoregions", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"http://www.worldwildlife.org/science/ecoregions/WWFBinaryitem4811.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"human_footprint", "class"=>"ArcInfo Grids"}, "data"=>{"title"=>"Human Footprint", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"http://sedac.ciesin.columbia.edu/wildareas/downloads.jsp"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"human_influence_index", "class"=>"ArcInfo Grids"}, "data"=>{"title"=>"Human Influence Index", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"http://sedac.ciesin.columbia.edu/wildareas/downloads.jsp"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"population_of_the_world", "class"=>"Map"}, "data"=>{"title"=>"Population of the World", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"http://sedac.ciesin.columbia.edu/gpw/"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"population_density_for_africa_", "class"=>"Map"}, "data"=>{"title"=>"Population Density for Africa", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"http://na.unep.net/siouxfalls/globalpop/africa/afpopd00.gif"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"climate_zones_in_africa", "class"=>"Map"}, "data"=>{"title"=>"Climate Zones in Africa", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"http://sedac.ciesin.columbia.edu/place/downloads/maps/climate_zone/Continent_Africa_ClimateZone.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"baseline_study_a", "class"=>"Doc"}, "data"=>{"title"=>"Baseline Study A", "icon"=>"/images/jstree/doc.png", "attr"=>{"href"=>"/docs/Regional/A%20Data_Report_Final.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"baseline_study_b", "class"=>"Doc"}, "data"=>{"title"=>"Baseline Study B", "icon"=>"/images/jstree/doc.png", "attr"=>{"href"=>"/docs/Regional/Baseline%20Study%20B%20-%20links%20between%20PAs%20and%20CC.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"baseline_study_c", "class"=>"Doc"}, "data"=>{"title"=>"Baseline Study C", "icon"=>"/images/jstree/doc.png", "isFolder"=>false, "attr"=>{"href"=>"/docs/Regional/Baseline%20Study%20C%20-%20policy,%20awarness%20and%20capacity.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"human_influence_index_for_west_africa", "class"=>"Map"}, "data"=>{"title"=>"Human Influence Index for West Africa", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"/docs/Regional/WAfrica_Regional_HII.tif"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"protected_areas_for_west_africa_", "class"=>"Map"}, "data"=>{"title"=>"Protected Areas for West Africa", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"/docs/Regional/WAfrica_Regional_PA_Landcov.jpg"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"population_density_for_west_africa_", "class"=>"Map"}, "data"=>{"title"=>"Population Density for West Africa", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"/docs/Regional/WAfrica_Regional_POP.jpg"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"priority_conservation_areas_in_west_africa_", "class"=>"Map"}, "data"=>{"title"=>"Priority Conservation Areas in West Africa", "icon"=>"/images/jstree/map.png", "attr"=>{"href"=>"/docs/Regional/WAfrica_Regional_BIO_CONS.jpg"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"undp_climate_change_profile_for_chad", "class"=>"Doc"}, "data"=>{"title"=>"UNDP Climate Change Profile for Chad", "icon"=>"/images/jstree/doc.png", "attr"=>{"href"=>"http://country-profiles.geog.ox.ac.uk/UNDP_reports/Chad/Chad.lowres.report.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"undp_climate_change_profile_for_the_gambia", "class"=>"Doc"}, "data"=>{"title"=>"UNDP Climate Change Profile for the Gambia", "icon"=>"/images/jstree/doc.png", "attr"=>{"href"=>"http://country-profiles.geog.ox.ac.uk/UNDP_reports/Gambia/Gambia.lowres.report.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"undp_climate_change_profile_for_mali", "class"=>"Doc"}, "data"=>{"title"=>"UNDP Climate Change Profile for Mali", "icon"=>"/images/jstree/doc.png", "attr"=>{"href"=>"http://country-profiles.geog.ox.ac.uk/UNDP_reports/Mali/Mali.lowres.report.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"undp_climate_change_profile_for_sierra_leone", "class"=>"Doc"}, "data"=>{"title"=>"UNDP Climate Change Profile for Sierra Leone", "icon"=>"/images/jstree/doc.png", "attr"=>{"href"=>"http://country-profiles.geog.ox.ac.uk/UNDP_reports/Sierra_Leone/Sierra_Leone.lowres.report.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"undp_climate_change_profile_for_togo", "class"=>"Doc"}, "data"=>{"title"=>"UNDP Climate Change Profile for Togo", "icon"=>"/images/jstree/doc.png", "attr"=>{"href"=>"http://country-profiles.geog.ox.ac.uk/UNDP_reports/Togo/Togo.lowres.report.pdf"}}, "state"=>"leaf"}, {"attr"=>{"id"=>"undp_climate_change_profiles", "class"=>"Docs"}, "data"=>{"title"=>"UNDP Climate Change Profiles", "icon"=>"/images/jstree/docs.png", "attr"=>{"href"=>"http://country-profiles.geog.ox.ac.uk/"}}, "state"=>"leaf"}] 

    sorted_data = {}
    data.each do |d|
      topic = title_topic[d["data"]["title"]]
      sorted_data[topic] ||= {
        "attr"=> {"id"=> topic.strip.downcase.gsub(' ', '_'), "class" => "folder"},
          "data"=>{
            "title" => topic
          },
        "state"=>  "closed",
        "children"=> []
      }
      sorted_data[topic]['children'] << d
    end

    puts sorted_data.values.to_json
  end
    
end

