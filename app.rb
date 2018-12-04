require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/doctor")
require("./lib/patient")
require("./lib/specialty")
require("pg")
require("pry")

DB = PG.connect({:dbname => "doctors_office"})

get('/') do
  @doctors = Doctor.sortby_name
  erb(:index)
end

get('/patient') do
  erb(:patient)
end

get('/admin') do
  @patients = Patient.all
  erb(:admin)
end

get('/doctor/:id') do
  erb(:doctor)
end

get('/add_patient')do
  @patient = false
  erb(:add_patient)
end

get('/add_doctor')do
  erb(:add_doctor)
end

post('/add_patient')do
  birthday = params.fetch("birthday")
  name = params.fetch("patient-name")
  if (name != "")
    patient = Patient.new(:name => name, :birthday => birthday)
    # binding.pry
    patient.save
  end
  @patient = patient
  erb(:add_patient)
end

post('/add_doctor')do
  erb(:add_doctor)
end
