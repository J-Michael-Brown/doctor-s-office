class Specialty

attr_reader(:id, :field)

  def initialize(attributes)
    @field = attributes.fetch(:field)
    if attributes.keys.include?(:id)
      @id = attributes.fetch(:id)
    else
      @id = nil
    end
  end

  def save
    result = DB.exec("INSERT INTO specialties (field) VALUES ('#{@field}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.all
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    specialties = []
    returned_specialties.each do |specialty|
      field = specialty.fetch("field")
      id = specialty.fetch("id").to_i()
      specialties.push(Specialty.new({:field => field, :id => id}))
    end
    specialties
  end

  def ==(another_specialty)
    self.field().==(another_specialty.field()).&(self.id().==(another_specialty.id()))
  end

  def doctors
    assigned_doctors = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{self.id};")
    doctors = []
    assigned_doctors.each do |doctor|
      name = doctor.fetch("name")
      id = doctor.fetch("id").to_i()
      specialty_id = doctor.fetch("specialty_id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end
end
