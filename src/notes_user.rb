require_relative 'notes'

module Sheyi
  class Interactive
    @app = nil

    def initialize
      main
    end

    def main
      puts '<<<<< Hello there, what is your name? >>>>>'
      name = gets.chomp.to_s
      begin
        @app = Sheyi::NotesApplication.new(name)
      rescue 'No name supplied!'
        puts "=== I need a name to work with! ||| \e[31m Error\e[0m"
        main
      end
      puts "=== Welcome, #{@app.author} \n\n"
      menu
    end

    def menu
      puts "<<< Hello #{@app.author}, what do you want to do? >>>"
      puts '[1] ====== Create a note'
      puts '[2] ====== Read a note'
      puts '[3] ====== Edit a note'
      puts '[4] ====== Delete a note'
      puts '[5] ====== Search'
      puts '[6] ====== List all notes'
      puts '[7] ====== Change author'
      puts '[0] ====== Exit'
      choice = gets.chomp.to_i

      case choice
      when 1
        create
      when 2
        read
      when 3
        edit
      when 4
        delete
      when 5
        search
      when 6
        list
      when 7
        change_user
      when 0
        exit!
      else
        puts <<-EOT
            ====== That option doesn\'t exist. Use a number from 1 to 5 ======\n\n
            EOT
        menu
      end
    end

    def create
      puts '==== Wrtie a note'
      note = gets.chomp.to_s

      note = @app.create(note)
      puts "=== Your note id is #{@app.notes.index(note)}" unless note.nil?
      menu
    end

    def list
      @app.list
      menu
    end

    def read
      puts '=== What is the id of the note you want to read?'
      id = gets.chomp.to_i
      note = @app.get(id)

      if !note.nil?
        puts "Note ID: #{id}"
        puts note
      else
        puts '=== I couldn\'t find that note! ==='
      end
      menu
    end

    def edit
      puts '=== Which note do you want to edit, put in an ID.'
      id = gets.chomp.to_i

      if @app.get(id)
        puts <<-STR
          === Input the new content you want for the note. Make sure you write something
              STR
        new_content = gets.chomp.to_s
        res = @app.edit(id, new_content)
        if res.nil?
          puts '=== Your note wasn\'t edited'
        else
          puts '=== Success'
        end
      end

      menu
    end

    def delete
      puts '=== Input the ID of the note you want to delete.'
      id = gets.chomp.to_i

      @app.delete(id)
      puts '=== Deleted'
      menu
    end

    def search
      puts '=== Input search text.'
      text = gets.chomp.to_s

      @app.search(text)

      menu
    end

    def change_user
      puts '<<<< What is your name? >>>>'
      author = gets.chomp

      if @app.validate(author)
        @app.author = author
      else
        puts '=== Put a valid name'
        change_user
      end

      menu
    end
  end
end
