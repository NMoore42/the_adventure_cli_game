require_relative '../config/environment'
puts `clear`
user_name = get_user_name
puts `clear`
user_home = get_user_home(user_name)
puts `clear`
current_user = find_or_create_user(user_name, user_home)

#Case statement within while loop to control TTY prompts.
while
  case current_user.current_room

  when "Entrance"
    puts `clear`
    puts "You are at the entrance"
  end
end
