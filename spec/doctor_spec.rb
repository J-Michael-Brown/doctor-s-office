require('spec_helper')

describe(Doctor) do
  describe(".save")do
    it "will save a doctors information to the doctors database and assign an unique id" do
      doctor = Doctor.new({:name => "Dr. Bill", :specialty => "urologist"})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end
end
