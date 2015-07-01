class Runner
  def display_options
      options =<<-eos.gsub(/^\s+/, '')
      Welcome to the Game of Life!

      Please select an initial state for the game:
      1) Glider
      2) Pulsar
      3) Diehard
      4) Acorn
      5) Beacon

      Your choice: 
      eos
      print options
  end

  def get_user_choice
    $stdin.gets.chomp.to_i
  end
end
