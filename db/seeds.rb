place = Place.new(name: "Zinal")
camp = Camp.new(start_date: Date.new(2024, 10, 6), end_date: Date.new(2024, 10, 12))
camp.place = place
camp.save!

puts "Created camp from #{camp.start_date} to #{camp.end_date} in #{camp.place.name}"

household = Household.new(street: "Teststr.", zip_code: "12345", number: "42", country_code: "CH", town: "Basel")
household.save!

puts "Created household based in #{household.street}, #{household.town}"

underage = Person.new(name: "Dinkel", first_name: "Theo", dob: Date.new(2017, 05, 22))
underage.household = household
underage.save!

adult = Person.new(name: "Dinkel", first_name: "Fabian", dob: Date.new(1992, 07, 25))
adult.household = household
adult.save!

puts "Created #{underage.first_name}, aged #{underage.age_at_camp(camp)} in #{camp.place.name}"