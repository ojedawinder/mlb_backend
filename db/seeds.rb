# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
League.delete_all
  @leagues=   [
       {
           :name => "AMERICAN",
           :id => 103
       },
       {
           :name => "NATIONAL",
           :id => 104
       }
     ]

  @leagues.each_with_index do |data, i|
  League.create!(:name => data[:name], :id => data[:id]);
end


Division.delete_all
  @divisions=   [
       {
           :id => 1,
           :name => "E",
           :league_id => 103
       },
       {
           :id => 2,
           :name => "C",
           :league_id => 103
       },
       {
           :id => 3,
           :name => "W",
           :league_id => 103
       },
       {
           :id => 4,
           :name => "E",
           :league_id => 104
       },
       {
           :id => 5,
           :name => "C",
           :league_id => 104
       },
       {
           :id => 6,
           :name => "W",
           :league_id=> 104
       },
     ]

  @divisions.each_with_index do |data, i|
  Division.create!(:name => data[:name], :league_id => data[:league_id], :id => data[:id]);
end
