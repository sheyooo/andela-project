#$LOAD_PATH << '.'

require_relative "notes"

app = nil

def main
	puts "Tell me your name?"
	name = gets.chomp.to_s

	begin
		app = Sheyi::NotesApplication.new (name)
	rescue Exception
		puts "=== I need a name to work with! ||| \e[#{31}m Error\e[0m"
		main
	end
	puts "=== Welcome, #{app.author} \n\n"


	menu
end

def menu
	puts "<<< What do you want to do? >>>"
	puts "[1] ====== Create"
	puts "[2] ====== Read"
	puts "[3] ====== Edit"
	puts "[4] ====== Delete"
	puts "[5] ====== Search"
	puts "[0] ====== Exit"
	choice = gets.chomp.to_i

	case choice
	when 1

	when 2

	when 3

	when 4

	when 5

	when 0
		exit!()
	else
		puts "======That option doesn't exist. Use a number from 1 to 5======\n\n"
		menu
	end

end

main