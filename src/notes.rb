module Sheyi

	class NotesApplication

		attr_reader :author

		def initialize(author)
			if validate(author)
				@author = author
				@notes = []
			else
				raise Exception.new "No name supplied!"
			end
		end

		def create(content)

			if validate(content)
				note = Hash.new
				note[:author] = @author
				note[:content] = content

				@notes.push(note)
			else
				puts_error("Your content cant be empty!")
			end
		end

		def list()

			for i in @notes do 
				puts "Note ID: #{@notes.index(i)}"
				puts i[:content]
				puts "By Author #{i[:author]} \n\n"
			end

			if @notes.length == 0
				puts "No notes yet! Create one by using the create keyword"
			end
		end

		def get(note_id)
			if @notes[note_id] != nil
				return @notes[note_id][:content]
			else
				puts "I could not find that note try another ID"
			end
		end

		def search(text)
			founds = []

			for i in @notes do
				if (i[:content] =~ /(.*)text(.*)/)
					founds.push(j)
				end

				if founds.size == 0
					puts "No matches found" 
				else
					#puts "Showing results for \"text\" "
					puts (founds)
				end
			end
		end

		def delete(note_id)
			if @notes[note_id] != nil
				@notes.delete_at(note_id)
			end
		end

		def edit(note_id, content)
			if validate(content)
				if @notes[note_id] != nil
					@notes[note_id][:content] = content
				end
			else
				puts_error("You input is invalid")
			end
		end

		def validate(content)
			if content.length > 0
				return true
			else
				return false
			end
		end

		def puts_error(msg = "An error occured")

			puts msg
		end


	end
end

=begin
	app = Sheyi::NotesApplication.new "Sheyi"
	app.create("h")
	app.create("ggh")
	puts app.list

=end