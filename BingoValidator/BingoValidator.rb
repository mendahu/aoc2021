require './Utilities/DataLoader.rb'

class Board
  def initialize(tiles)
    @board = tiles
    @pulls = []
  end

  def record_pull(num)
    @pulls.push(num)
  end
end

class BingoValidator < DataLoader
  def initialize(path)
    super

    @pulls = get_pulls(@@data)
    @boards = get_boards(@@data)
  end

  def get_pulls(data)
    data[0].split(",")
  end

  def get_boards(data)
    board_data = data[2...-1]
    boards = []    
    index = 0
    
    while index < board_data.length
      board_array = [0...5].map.with_index { |x, i| board_data[index + i].split(" ")}
      board = Board.new(board_array)
      boards.push(board)
      index += 6
    end

    return boards
  end

  def validate
  
  end
end