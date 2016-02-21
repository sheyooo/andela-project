module Sheyi

  class NotesApplication

    attr_accessor :author
    attr_reader :notes


    def initialize(author)
      author = clean_string(author)
      if validate(author)
        @author = author
        @notes = []
      else
        raise Exception.new "No name supplied!"
      end

      @list_lambda = lambda { |i|
        puts "\n"
        puts "Note ID: #{@notes.index(i)}"
        puts i[:content]+ "\n\n"
        puts "By Author #{i[:author]} \n\n"
      }
    end

    def create(content)

      if validate(content)
        note = Hash.new
        note[:author] = @author
        note[:content] = content

        @notes.push(note)
        note
      else
        puts_error("Your content cant be empty!")
      end
    end

    def list
      
      for i in @notes do
        @list_lambda.call(i)
      end

      if @notes.length == 0
        puts "=== No notes yet! Create one"
      end

      @notes
    end

    def get(note_id)
      if @notes[note_id] != nil
        return @notes[note_id][:content]
      else
        nil
      end
    end

    def search(text)
      founds = []
      puts "<<<< Showing results for '\e[#{32}m#{text}\e[0m' >>>>"

      match = false
      for i in @notes do
         
        if (i[:content] =~ /#{text}/i)
          @list_lambda.call(i)
          founds.push(@notes.index(i))
          match = true
        end        

      end

      puts "=== No matches found" unless match

      founds
    end

    def delete(note_id)
      if @notes[note_id] != nil
        @notes.delete_at(note_id)
      end
    end

    def edit(note_id, content)
      if validate(content) && (@notes[note_id] != nil)
        @notes[note_id][:content] = content
      else
        nil
      end
    end

    def validate(content)
      if content.length > 0
        return true
      else
        return false
      end
    end

    def clean_string(str)
      str.strip!
      str
    end

    def puts_error(msg = "=== ***An error occured***")

      puts msg
    end


  end
end