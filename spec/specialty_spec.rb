require('spec_helper')

describe(Specialty) do
  describe(".save")do
    it "will save a specialty to the specialties database and assign it an unique id" do
      specialty = Specialty.new({:field => "urology"})
      specialty.save()
      expect(Specialty.all()).to(eq([specialty]))
    end
  end

  # describe("#field") do
  #   it "will return specialty field when given an id"
  #   specialty = Specialty.new({:field => "cardiology"})
  #   specialty.save()
  #   expect(Specialty.field(specialty.id)).to(eq("cardiology"))
  # end

  describe(".doctors") do
    it "returns an array of all doctors with that specialty." do
      specialty = Specialty.new({:field => "cardiology"})
      specialty.save()
      doctor_cardio = Doctor.new({:name => "Dr. Cardio", :specialty_id => specialty.id})
      doctor_cardio.save()
      expect(specialty.doctors).to(eq([doctor_cardio]))

    end
  end
end
