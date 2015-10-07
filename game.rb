class Player
  attr_accessor :name, :blood, :manna

  $name = %w[]
  $blood = []
  $manna = []
  $count = $name.count

  def all_players
    puts $name
    puts $count
  end

  def add_player
    if $count >= 3
      puts '', '     <MAX PLAYER>'
      puts "#-----------------------------------------------------#\n\n"
    else
      puts "\n#-----------------------------------------------------#"
      puts "#                    ADD PLAYER                       #"
      puts "#-----------------------------------------------------#"
      print "     Creating a character: "
      new_name = gets.chomp

      check = $name.include? new_name
      if (check == false)
        $name << new_name
        $blood << 100
        $manna << 100
        $count += 1
        puts '','     <Player added>'
        puts "#-----------------------------------------------------#\n\n"
      else
        puts '','     <error'
        puts "#-----------------------------------------------------#\n\n"
      end
    end
  end

  def select_player
    print "     Select Attacker: "
    STDOUT.flush
    attacker = gets.chomp.downcase

    print "     Select Target: "
    STDOUT.flush
    target = gets.chomp.downcase

    checkatt = $name.include? attacker
    checktar = $name.include? target

    if (checkatt == false && checktar == false)
      puts '','     <ATTACKER & TARGET NOT AVAILABLE>'
      puts "#-----------------------------------------------------#\n\n"
    elsif (checkatt == false)
      puts '','     <ATTACKER NOT AVAILABLE>'
      puts "#-----------------------------------------------------#\n\n"
    elsif (checktar == false)
      puts '','     <TARGET NOT AVAILABLE>'
      puts "#-----------------------------------------------------#\n\n"
    else
      puts battle_on(attacker, target)
    end
  end

  def battle_on(attacker, target)
    index_attacker = $name.index(attacker)
    index_target = $name.index(target)
    att_name = $name[index_attacker].upcase
    tar_name = $name[index_target].upcase
    blood_attacker = $blood[index_attacker]
    blood_target = $blood[index_target]
    manna_attacker = $manna[index_attacker]
    manna_target = $manna[index_target]
    manna_attacker_new = manna_attacker-20
    blood_target_new = blood_target-20
    $manna[index_attacker] = manna_attacker_new
    $blood[index_target] = blood_target_new

    if ($blood[index_target] != 0)
      puts "", "     <#{att_name} IS ATTACKING #{tar_name}!!!>", ""
      puts "     DESCRIPTION:"
      puts "#-----------------------------------------------------#"
      print "     * #{att_name}: Blood = #{blood_attacker}, Manna = #{$manna[index_attacker]}\n"
      print "     * #{tar_name}: Blood = #{$blood[index_target]}, Manna = #{manna_target}\n"
    else
      puts "", "     <#{att_name} IS ATTACKING #{tar_name}!!!>", ""
      puts "     DESCRIPTION:"
      puts "#-----------------------------------------------------#"
      print "     * #{att_name}: Blood = #{blood_attacker}, Manna = #{$manna[index_attacker]}\n"
      print "     * #{tar_name}: Blood = #{$blood[index_target]}, Manna = #{manna_target}\n"
      puts "", "     <GAME OVER, #{tar_name} IS WIN!!!"
      puts "#-----------------------------------------------------#"
     end
  end

end

class Menu
  #getter
  attr_reader :quit
  # *menu_args is making an array
  def initialize( *menu_args )
    @menu_args = menu_args
    @quit = "quit"
  end

  def get_menu_choice
    #header
    puts "#=====================================================#"
    puts "#              Welcome to Battle Arena                #"
    puts "#-----------------------------------------------------#"
    puts "#    Description :                                    #"

    #print the menu
    @menu_args.each_with_index do | item, index |
      puts "#    #{index + 1}. #{item}"
  end

  puts "#-----------------------------------------------------#"
  print "     * Current Player: "
  puts $count
  $name.each {|x| puts "     - Player Name: #{x}"}
    puts "     * Max Player 2 or 3"
    puts "#-----------------------------------------------------#"
    #ask for user choice
    print "     * Enter your choice: "
    user_choice = gets.chomp.downcase
    #return user choice
    return user_choice
  end
end

menu = Menu.new(
	"Type 'new' to add character                   #",
	"Type 'start' to start the battle              #",
	"Type 'quit' to exit the game                  #"
)

player = Player.new

while((choice = menu.get_menu_choice) != menu.quit)
  if choice == "new"
    player.add_player

  elsif choice == "start"
    puts "#=====================================================#"
    puts "#              Welcome to Battle Arena                #"
    puts "#-----------------------------------------------------#"
    puts "#    Battle Start :                                   #"
    puts '#-----------------------------------------------------#'
    player.select_player

  else
    puts '', '     <PLEASE CHOOSE BETWEEN NEW, START OR QUIT!!!>', ''
  end
end
