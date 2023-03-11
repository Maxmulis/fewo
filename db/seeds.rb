# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

fabian = Person.new(last_name: "Dinkel", first_name: "Fabian", email: "test@test.com", dob: "31-10-1991", street: "Street", zip: "12345", city:
 "Basel", country_code: "CH")

fabian.save!

theo = Person.new(last_name: "Dinkel", first_name: "Theo", email: "test@test.com", dob: "31-10-2015", street: "Street", zip: "12345", city: "Ba
sel", country_code: "CH")
theo.save!

camp = Camp.new(place: "Zinal", startdate: "31-10-2023", enddate: "11-11-2023")
camp.save!

theo_reg = Registration.new(camp: camp, arrival_date:'31-10-2023', departure_date: '3-11-2023', person: theo)
theo_reg.save!

fabian_reg = Registration.new(camp: camp, arrival_date:'31-10-2023', departure_date: '3-11-2023', person: fabian)
fabian_reg.save!

responsibility = Responsibility.new(person: fabian, registration: theo_reg)
responsibility.save!
