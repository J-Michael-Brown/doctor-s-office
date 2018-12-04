require('spec_helper')

describe(Doctor) do
  describe(".save")do
    it "will save a doctors information to the doctors database and assign an unique id" do
      doctor = Doctor.new({:name => "Dr. Bill", :specialty => "urologist"})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end
  describe(".view_patients")do
    it "display all patients assigned to that doctor" do
      patient1 = Patient.new({:name => 'Michael', :birthday => '1999-01-08 04:05:06'})
      patient1.save()
      patient2 = Patient.new({:name => 'Paige', :birthday => '1994-01-08 04:05:06'})
      patient2.save()
      patientx = Patient.new({:name => 'X', :birthday => '2000-01-08 04:05:06'})
      patientx.save()
      doctor = Doctor.new({:name => "Dr. Bill", :specialty => "urologist"})
      doctor.save()
      patient1.assign(doctor)
      patient2.assign(doctor)
      expect(doctor.patients).to(eq([patient1, patient2]))
    end
  end
end
