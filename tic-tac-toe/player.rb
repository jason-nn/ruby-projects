class Player
  attr_reader :name

  @@count = 0
  @@names = []
  @@list = []

  def initialize(name)
    @name = name
    @@count += 1
    @@names << name
    @@list << self
    puts "#{@name} is player #{@@count}"
    puts
  end

  def self.create
    name = get_name
    puts

    while @@names.include? name
      puts 'Player name is taken'
      name = get_name
      puts
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
