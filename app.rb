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
  @doctors = Doctor.all
  erb(:admin)
end

get('/doctor/:id') do
  @doctor = Doctor.by_id(params[:id].to_i)
  @patients = @doctor.patients
  erb(:doctor)
end

get('/add_doctor')do
  @specialties = Specialty.all()
  @doctor = false
  erb(:add_doctor)
end

post('/add_doctor')do
  name = params.fetch("doctor-name")
  specialty = params.fetch("specialty-id").to_i

  if (name != "")
    doctor = Doctor.new(:name => name, :specialty_id => specialty)
    doctor.save
  end
  @doctor = doctor
  @specialties = Specialty.all()
  erb(:add_doctor)
end

get('/add_patient')do
  @patient = false
  erb(:add_patient)
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

get('/add_specialty') do
  @specialty = false
  erb(:add_specialty)
end

post('/add_specialty') do
  field = params.fetch("specialty-field")
  specialty = Specialty.new({:field => field})
  specialty.save
  @specialty = specialty
  erb(:add_specialty)
end
