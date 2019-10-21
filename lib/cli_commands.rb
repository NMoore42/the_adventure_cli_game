PROMPT = TTY::Prompt.new


def get_user_name
  PROMPT.ask("Ho! Brave traveler, you've come a long way indeed.  Thank you for answering my summons. What is your name?", default: ENV["User"])
end

def get_user_home(user_name)
  PROMPT.select("#{user_name}, you are a brave soul. From which realm do you hail?\n\n", ["The Forbidden Swamps", "Greenwitch Hills", "The Whispering Coast", "Sundesta Valley"])
end

def determine_user_type(user_home)
  case user_home
  when "The Forbidden Swamps"
    return "Troll"
  when "Greenwitch Hills"
    return "Witch"
  when "The Whispering Coast"
    return "Wizard"
  when "Sundesta Valley"
    return "Barbarian"
  end
end

def find_or_create_user(user_name, user_home)
  user_type = determine_user_type(user_home)
  full_name = "#{user_name} the #{user_type}"
  current_player = Player.find_by(name: full_name)
  if current_player
    PROMPT.select("Yes, #{full_name} - I remember you!! I thought you were out in the world battling my demons?  Luckily, I have a few pinches of pixie dust leftover from your last adventure. I can transfer you back to your last location.\n\n", ["Continue Your Adventure"])
  else
    current_player = Player.create(name: full_name, health: 100, gold: 100)
    PROMPT.select("#{user_home}? You're a #{user_type.downcase}!! I am going to call you #{full_name}.\nThe dragon's lair is northeast of the kingdom, past the Crumbled Mountain. Find the golden cup, and I'll make you a Duke of your own dutchy. Take this 100 pieces of gold to help you on your way. \n\nGood luck!\n\n", ["Start Your Adventure"])
  end
  current_player.current_room = "Entrance"
  current_player
end
