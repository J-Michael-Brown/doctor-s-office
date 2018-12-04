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
end
