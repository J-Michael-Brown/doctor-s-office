class Patient

attr_reader(:id, :name, :birthday, :doctor_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @birthday = attributes.fetch(:birthday)
    if attributes.keys.include?(:doctor_id)
      @doctor_id = attributes.fetch(:doctor_id).to_i
    else
      @doctor_id = 0
    end

    if attributes.keys.include?(:id)
      @id = attributes.fetch(:id).to_i
    else
      @id = nil
    end
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.all
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each do |patient|
      name = patient.fetch("name")
      birthday = patient.fetch("birthday")
      id = patient.fetch("id").to_i()
      doctor_id = patient.fetch("doctor_id").to_i()
      patients.push(Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id, :id => id}))
    end
    patients
  end

  def ==(another_patient)
    self.name().==(another_patient.name()).&(self.id().==(another_patient.id())).&(self.birthday.==another_patient.birthday).&(self.doctor_id.==another_patient.doctor_id)
  end

  def assign(doctor)
    doctor_id = DB.exec("UPDATE patients SET doctor_id = #{doctor.id} WHERE id = #{self.id} RETURNING doctor_id;")
    @doctor_id = doctor_id.first().fetch("doctor_id").to_i()
  end

end
