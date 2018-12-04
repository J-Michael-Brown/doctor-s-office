require('spec_helper')

describe(Doctor) do
  describe(".save")do
    it "will save a doctors information to the doctors database and assign an unique id" do
      doctor = Doctor.new({:name => "Dr. Bill", :specialty_id => 1})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe(".patients")do
    it "display all patients assigned to that doctor" do
      patient1 = Patient.new({:name => 'Michael', :birthday => '1999-01-08 04:05:06'})
      patient1.save()
      patient2 = Patient.new({:name => 'Paige', :birthday => '1994-01-08 04:05:06'})
      patient2.save()
      patientx = Patient.new({:name => 'X', :birthday => '2000-01-08 04:05:06'})
      patientx.save()
      doctor = Doctor.new({:name => "Dr. Bill", :specialty_id => 1})
      doctor.save()
      patient1.assign(doctor)
      patient2.assign(doctor)
      expect(doctor.patients()).to(eq([patient1, patient2]))
    end
  end

  describe('#sortby_name') do
    it "returns an array of doctors in alphabetical order (by last name)." do
      doc_bill = Doctor.new({:name => "Bill Nye", :specialty_id => 1})
      doc_bill.save()
      doc_al = Doctor.new({:name => "Alfred Hitchcock", :specialty_id => 2})
      doc_al.save()
      doc_c = Doctor.new({:name => "Charles Baggins", :specialty_id => 3})
      doc_c.save()
      expect(Doctor.sortby_name()).to(eq([doc_al, doc_bill, doc_c]))

    end
  end

  describe(".field") do
    it "returns the field that the doctor specializes in." do
      specialty = Specialty.new({:field => "cardiology"})
      specialty.save()
      doctor_cardio = Doctor.new({:name => "Dr. Cardio", :specialty_id => specialty.id})
      doctor_cardio.save()
      expect(doctor_cardio.field).to(eq("cardiology"))
    end
  end
end
