
require_relative "notes"

RSpec.describe "NotesApplication" do 
	it "raises error if no name is supplied" do 
		expect {Sheyi::NotesApplication.new ""}.to raise_error "No name supplied!"
	end

end