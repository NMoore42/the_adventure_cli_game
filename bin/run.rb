require_relative '../config/environment'

###RUNS ON PROGRAM LAUNCH
puts `clear`
player_name = get_player_name
puts `clear`
player_home = get_player_home(player_name)
puts `clear`
current_player = find_or_create_player(player_name, player_home)

#CASE STATEMENT WITHIN WHILE LOOPS TO CONTROL TTY PROMPTS
while current_player.current_room != "Game Over"
  case current_player.current_room

  when "Entrance"
    puts `clear`
    entrance_1(current_player)
  when "Explore the Path"
    puts `clear`
    winding_path_1a(current_player)
  when "Enter the Cave"
    puts `clear`
    mouth_of_the_cave_2(current_player)
  when "Inspect Object"
    puts `clear`
    inspect_object_2(current_player)
  when "Continue Forward"
    puts `clear`
    cave_fork_3(current_player)
  when "Take the Left Path"
    puts `clear`
    cave_fork_left_path_4(current_player)
  when "Take the Right Path"
    puts `clear`
    cave_fork_right_path_4(current_player)
  when "Buy Battle Axe - 10 Gold"
    puts `clear`
    tinker_choice_axe_5(current_player)
  when "Buy Shield - 110 Gold"
    puts `clear`
    tinker_choice_shield_5(current_player)
  when "Buy Fun Powder - 120 Gold"
    puts `clear`
    tinker_choice_fun_powder_5(current_player)
  when "Continue On"
    puts `clear`
    tinker_choice_continue_5(current_player)
  when "Tell Him You'll Think About It and Come Back Later (Though You Know You Definetly Won't Be Back)"
    puts `clear`
    tinker_choice_continue_5(current_player)
  when "Walk to find water"
    puts `clear`
    water_hole_6(current_player)
  when "Head towards the light"
    puts `clear`
    head_towards_the_light_7(current_player)
  when "Dead Men Have No Choices ☠️"
    puts `clear`
    dead_men_8(current_player)
  when "Exit the cavern"
    puts `clear`
    exit_cavern_9(current_player)
  end

end
