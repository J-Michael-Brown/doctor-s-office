require('spec_helper')

describe(Patient) do
  describe(".save")do
    it "will save a patients information to the patient database and assign an unique id" do
      patient = Patient.new({:name => 'Michael', :birthday => '1999-01-08 04:05:06', :doctor_id => 0})
      patient.save()
      expect(Patient.all()).to(eq([patient]))
    end
  end

  describe(".assign") do
    it "will change the doctor_id of a patient to an assigned doctor's id." do
      patient = Patient.new({:name => 'Michael', :birthday => '1999-01-08 04:05:06', :doctor_id => 0})
      patient.save()
      doctor = Doctor.new({:name => "Dr. Bill", :specialty_id => 1})
      doctor.save()
      expect(patient.assign(doctor)).to(eq(doctor.id))
    end
  end
end
