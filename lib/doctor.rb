# require('specialty')

class Doctor

attr_reader(:id, :name)
attr_accessor(:specialty_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @specialty_id = attributes.fetch(:specialty_id)
    if attributes.keys.include?(:id)
      @id = attributes.fetch(:id)
    else
      @id = nil
    end
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()

  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end

  def patients
    assigned_patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{self.id};")
    patients = []
    assigned_patients.each do |patient|
      name = patient.fetch("name")
      birthday = patient.fetch("birthday")
      id = patient.fetch("id").to_i()
      doctor_id = patient.fetch("doctor_id").to_i()
      patients.push(Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id, :id => id}))
    end
    patients
  end

  def self.sortby_name()
    alpha_doc = DB.exec("SELECT * FROM doctors ORDER BY name;")
    doctors = []
    alpha_doc.each do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end

  def field
    specialties = DB.exec("SELECT * FROM specialties WHERE id = #{self.specialty_id};")
    specialties.each do |specialty|
      return specialty.fetch("field")
    end
  end

  def self.by_id(id)
    doctor_as_array = DB.exec("SELECT * FROM doctors WHERE id = #{id};")
    doctors = []
    doctor_as_array.each do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors[0]
  end

  def ==(another_doctor)
    self.name().==(another_doctor.name()).&(self.id().==(another_doctor.id())).&(self.specialty_id.==another_doctor.specialty_id)
  end
end
