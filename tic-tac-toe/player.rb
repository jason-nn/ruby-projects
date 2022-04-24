class Player
  @@count = 0
  @@names = []
  @@list = []

  def initialize(name)
    @name = name
    @@count += 1
    @@names << name
    @@list << self
    puts "#{@name} is player #{@@count}"
  end

  def self.create
    name = get_name

    while name.length < 3
      puts 'Player name should be at least 3 characters'
      name = get_name
    end

    while @@names.include? name
      puts 'Player name is taken'
      name = get_name
    end

    Player.new(name)
  end

  def self.list
    @@list
  end

  private

  def self.get_name
    print "Enter player #{@@count + 1} name: "
    return gets.chomp
  end
end
