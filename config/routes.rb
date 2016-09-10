Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :mlb do
        get "all_games", to: "games#all_games"
        get "all_teams", to: "teams#all_teams"

        get "stats_rivals_by_year", to: "games#getStatsRivalsByYear"
        post "stats_rivals_all_time", to: "games#getStatsRivalsAllTime"
        #put "trip_style/:trip_style_id", to: "clients#add_trip_style"
        #delete "trip_style/:trip_style_id", to: "clients#delete_trip_style"
        #put "trip_group/:trip_group_id", to: "clients#add_trip_group"
        #delete "trip_group/:trip_group_id", to: "clients#delete_trip_group"
        #get "sheets", to: "clients#sheets"
        #get "general_information_basic_data", to: "clients#general_information_basic_data"
        #get "general_information_professional_details", to: "clients#general_information_professional_details"
        #get "general_information_phones", to: "clients#general_information_phones"
        #get "general_information_addresses", to: "clients#general_information_addresses"
        #get "general_information_customer_dates", to: "clients#general_information_customer_dates"
        #get "general_information_social_medias", to: "clients#general_information_social_medias"
        #get "general_information_special_comments", to: "clients#general_information_special_comments"
        #get "passports", to: "clients#passports"
        #get "visas", to: "clients#visas"
        #get "preferences_trip_groups", to: "clients#preferences_trip_groups"
        #get "preferences_trip_styles", to: "clients#preferences_trip_styles"
        #get "preferences_hotel", to: "clients#preferences_hotel"
        #get "preferences_fly", to: "clients#preferences_fly"
        #get "loyalty_programs", to: "clients#loyalty_programs"
        #get "networks", to: "clients#networks"
        #get "download_client_itinerary_pdf", to: "clients#download_itinerary_pdf"
        #get "agency_info", to: "clients#agency_info"
        #get "client_comments", to: "clients#client_comments"
        post "admin/start_load", to: "loaders#startLoadData"
      end
  end
end
