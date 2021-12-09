require './Utilities/DataLoader.rb'

class Board
  def initialize(tiles)
    @rows = tiles
    @cols = tiles.transpose
    @board = @cols + @rows
    @pulls = []
  end

  def remove_num(num)
    @board.each { |row_or_col| row_or_col.delete(num) }
  end

  def is_there_a_winner
    @board.include?([])
  end

  def record_pull(num)
    @pulls.push(num)
    remove_num(num)

    is_there_a_winner
  end

  def get_score(num)
    num.to_i * @rows.flatten.sum { |n| n.to_i }
  end
end

class BingoValidator < DataLoader
  attr_reader :score

  def initialize(path)
    super
    @data = @@data
    @pulls = get_pulls(@data)
    @boards = get_boards(@data)
    @score = get_score
  end

  def get_score
    has_winner = false
    pull_index = 0
    score = 0

    while !has_winner && pull_index < @pulls.length do
      board_index = 0

      while !has_winner && board_index < @boards.length do
        board = @boards[board_index]
        pull = @pulls[pull_index]

        result = board.record_pull(pull) 

        if result
          has_winner = true
          score = board.get_score(pull)
        else
          board_index += 1
        end
      end

      pull_index += 1
    end
    
    score
  end

  def get_pulls(data)
    data[0].split(",")
  end

  def get_boards(data)
    board_data = data[2...]
    boards = []    
    index = 0
    
    while index < board_data.length
      board_array = [0,1,2,3,4].map { |x| board_data[index + x].split }
      board = Board.new(board_array)
      boards.push(board)
      index += 6
    end

    return boards
  end
end