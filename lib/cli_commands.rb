PROMPT = TTY::Prompt.new


def get_player_name
  PROMPT.ask("Ho! Brave traveler, you've come a long way indeed.  Thank you for answering my summons. What is your name?", default: ENV["User"])
end

def get_player_home(player_name)
  PROMPT.select("#{player_name}, you are a brave soul. From which realm do you hail?\n\n", ["The Forbidden Swamps", "Greenwitch Hills", "The Whispering Coast", "Sundesta Valley"])
end

def determine_player_type(player_home)
  case player_home
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



def display_stats(current_player)
  items_string = ""
  current_player.items.each {|item| items_string += " #{item.emoji} "}
  puts "❤️  #{current_player.health}  |  💰  #{current_player.gold}  |  #{items_string}\n\n\n\n\n"
end

def find_or_create_player(player_name, player_home)
  player_type = determine_player_type(player_home)
  full_name = "#{player_name} the #{player_type}"
  current_player = Player.find_by(name: full_name)
  if current_player
    PROMPT.select("Yes, #{full_name} - I remember you!! I thought you were out in the world battling my demons?  Luckily, I have a few pinches of pixie dust leftover from your last adventure. I can transfer you back to your last location.\n\n", ["Continue Your Adventure"])
  else
    current_player = Player.create(name: full_name, health: 100, gold: 100)
    PROMPT.select("#{player_home}? You're a #{player_type.downcase}!! I am going to call you #{full_name}.\nThe dragon's lair is northeast of the kingdom, past the Crumbled Mountain. Find the golden cup, and I'll make you a Duke of your own dutchy. Take this 100 pieces of gold to help you on your way. \n\nGood luck!\n\n", ["Start Your Adventure"])
  end
  current_player.current_room = "Entrance"
  current_player
end





# ************************************************************
#ROOM FUNCTIONS
# ************************************************************

def entrance_1(current_player)
  display_stats(current_player)
  current_player.current_room = PROMPT.select("You approach the entrance to a cave. To the side, there is a small, winding path.\n\n", ["Enter the Cave", "Explore the Path"])
end

def winding_path_1a(current_player)
  current_player.update(health: current_player.health -= 10, current_room: "Explore the Path")
  display_stats(current_player)
  PROMPT.select("You make your way down the path, pushing through layers of cobwebs and debris. At the end of the path, you find a crumpled note.  You pick it up and read it, \n\n 'Beware of poisonous spiders - curiosity can be fatal.'\n\n  You then feel something bite the back of your neck...\n\n", ["Return to Entrance"])
  current_player.current_room = "Entrance"
end

def mouth_of_the_cave_2(current_player)
  display_stats(current_player)
  current_player.update(current_room: "Mouth of the Cave")
  current_player.current_room = PROMPT.select("You enter the cave. It's dark...and musty. Somewhere in the distance, you can hear a slithering sound. Your foot bumps into something hard.\n\n", ["Continue Forward", "Inspect Object"])
end

def inspect_object_2(current_player)

  current_player.update(current_room: "Inspect Object")
  current_player.items << Item.first
  display_stats(current_player)
  current_player.current_room = PROMPT.select("You pick up the object. It is hard, and cold, and sharp. On closer inspection, you see a faded writing on the side of the blade. You feel grateful to feel armed.\n\n", ["Continue Forward"])
end

def cave_fork_3(current_player)
  display_stats(current_player)
  current_player.update(current_room: "Continue Forward")
  current_player.gold > 100 ? current_player.current_room = PROMPT.select("You're back at the fork. To the right, an eerie blue glow is ommitting from the shadows. To the left, you can still smell the blood of the young devil child. You shudder as you remember his freakish mouth full of sharp, brown teeth.\n\n", ["Take the Right Path"]) : current_player.current_room = PROMPT.select("You come reach a a fork in the path. To the right, an eerie blue glow is ommitting from the shadows.  To the left, you hear a small child cackling.\n\n", ["Take the Left Path", "Take the Right Path"])
end

def cave_fork_left_path_4(current_player)
  current_player.items.find_by(name: "Engraved Sword") ? current_player.update(gold: current_player.gold += 30) : current_player.update(health: current_player.health -= 30)
  display_stats(current_player)
  current_player.current_room = PROMPT.select("A small, frightful child scrambles out of a crack in the wall. He projects himself towards your face. #{current_player.items.find_by(name: "Engraved Sword") ? "You use your newfound sword to slash the baby before it can make contact. You discover 30 pieces of gold on it's mutilated body." : "Defenseless, the baby lands a devasting blow, ripping off the tip of your nose. Your health takes a toll."}\n\n", ["Go Back to the Fork"])
  current_player.current_room = "Continue Forward"
end

def cave_fork_right_path_4(current_player)
  display_stats(current_player)
  current_player.update(current_room: "Take the Left Path")
  current_player.current_room = PROMPT.select("You approach the blue glow and find it is coming from the latern of a tinker. He beckons you over and displays his wares. His beady eyes bore into you as you decide what to buy.\n\n", ["Buy Battle Axe - 10 Gold", "Buy Shield - 110 Gold", "Buy Fun Powder - 120 Gold", "Tell Him You'll Think About It and Come Back Later (Though You Know You Definetly Won't Be Back)"])
end

def tinker_choice_axe_5(current_player)
  current_player.update(current_room: "Take the Left Path", gold: current_player.gold -= 10)
  current_player.items << Item.find(2)
  display_stats(current_player)
  current_player.current_room = PROMPT.select("You purchase the battle axe. Upon closer inspection, you see that it's made of plastic.\n\n 'It's a child's toy. It costs 10 gold, what did you expect?'\n\n states the tinker. Maybe next time don't be so cheap and purchase a real weapon.\n\n", ["Continue On",  { name: 'Return Item', disabled: "(Must Have Receipt)" }])
end

def tinker_choice_shield_5(current_player)
  current_player.update(current_room: "Take the Left Path", gold: current_player.gold -= 110)
  display_stats(current_player)
  current_player.items << Item.find(3)
  current_player.current_room = PROMPT.select("You purchase the shield. As he hands it over, it's weight amazes you. It's a quality item, forged from Elvish silversteel. You feel grateful to be so well equipped.\n\n", ["Continue On"])
end

def tinker_choice_fun_powder_5(current_player)
  current_player.update(current_room: "Take the Left Path", gold: current_player.gold -= 120, health: 1500)
  display_stats(current_player)
  current_player.current_room = PROMPT.select("You purchase the fun powder and immediately ingest it. YOU FEEL GREAT. LIKE THE BEST YOU'VE EVER FELT. THIS IS THE BEST ADVENTURE YOU'VE EVER BEEN ON. WHEN YOU RETURN, YOU SHOULD START YOU'RE OWN TACO TRUCK COMPANY.  EVERYONE LOVES TACOS. WHY ARE THERE NO TACOS IN THIS CAVE? WHY DO CAVES EXIST? ARE CAVES LIKE CASTLES BUT FOR CREEPY THINGS. CAVE. THAT'S A WEIRD WORD. IT'S ODD HOW WHEN YOU SAY CAVE, IT STARTS AT THE BACK OF YOUR MOUTH AND THEN ENDS AT THE FRONT. IF I SWALLOW A FLY, DOES THE FLY THINK MY MOUTH IS A CAVE? IS MY MOUTH A CAVE? AM I IN SOMETHING'S MOUTH?.\n\n", ["Continue On"])
end
