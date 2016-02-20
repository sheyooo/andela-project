#$LOAD_PATH << '.'

require_relative "notes"

module InteractiveNote

  $app = nil

  def InteractiveNote.main
    puts "<<<<< Hello there, what is your name? >>>>>"
    name = gets.chomp.to_s

    begin
      $app = Sheyi::NotesApplication.new (name)
    rescue Exception
      puts "=== I need a name to work with! ||| \e[#{31}m Error\e[0m"
      main
    end
    puts "=== Welcome, #{$app.author} \n\n"


    menu
  end

  def InteractiveNote.menu
    puts "<<< Hello #{$app.author}, what do you want to do? >>>"
    puts "[1] ====== Create a note"
    puts "[2] ====== Read a note"
    puts "[3] ====== Edit a note"
    puts "[4] ====== Delete a note"
    puts "[5] ====== Search"
    puts "[6] ====== List all notes"
    puts "[7] ====== Change author"
    puts "[0] ====== Exit"
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
      exit!()
    else
      puts "====== That option doesn't exist. Use a number from 1 to 5 ======\n\n"
      menu
    end
  end

  def InteractiveNote.create 
    puts "==== Wrtie a note"
    note = gets.chomp.to_s

    note = $app.create(note)
    puts "=== Your note id is #{$app.notes.index(note)}" if note != nil
    menu
  end

  def InteractiveNote.list
    $app.list
    menu
  end

  def InteractiveNote.read
    puts "=== What is the id of the note you want to read?"
    id = gets.chomp.to_i
    note = $app.get(id)

    if note != nil
      puts "Note ID: #{id}"
      puts note
    else
      puts "=== I couldn't find that note! ==="
    end
    menu
  end

  def InteractiveNote.edit
    puts "=== Which note do you want to edit, put in an ID."
    id = gets.chomp.to_i

    if $app.get(id)
      puts "=== Input the new content you want for the note. Make sure you write something"
      new_content = gets.chomp.to_s
      res = $app.edit(id, new_content)
      if res == nil
        puts "=== Your note wasn't edited"
      else
        puts "=== Success"
      end
    end

    menu
  end

  def InteractiveNote.delete
    puts "=== Input the ID of the note you want to delete."
    id = gets.chomp.to_i

    $app.delete(id)
    puts "=== Deleted"
    menu
  end

  def InteractiveNote.search 
    puts "=== Input search text."
    text = gets.chomp.to_s

    $app.search(text)

    menu
  end

  def InteractiveNote.change_user
    puts "<<<< What is your name? >>>>"
    author = gets.chomp

    if $app.validate(author)
      $app.author = author
    else
      puts "=== Put a valid name"
      change_user
    end

    menu
  end



  InteractiveNote.main

end