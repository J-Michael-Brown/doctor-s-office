require('spec_helper')

describe(Patient) do
  describe(".save")do
    it "will save a patients information to the patient database and assign an unique id" do
      patient = Patient.new({:name => 'Michael', :birthday => '1999-01-08 04:05:06', :doctor_id => 0})
      patient.save()
      expect(Patient.all()).to(eq([patient]))
    end
  end
end
