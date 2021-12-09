require './Utilities/DataLoader.rb'

class Board
  def initialize(tiles)
    @rows = tiles
    @cols = tiles.transpose
    @board = @cols + @rows
    @pulls = []
    @is_active = true
  end

  def remove_num(num)
    @board.each { |row_or_col| row_or_col.delete(num) }
  end

  def record_pull(num)
    @pulls.push(num)
    remove_num(num)

    is_winner = @board.include?([])

    if is_winner && @is_active
      @is_active = false
      return true
    else
      return false
    end
  end

  def get_score(num)
    num.to_i * @rows.flatten.sum { |n| n.to_i }
  end
end

class BingoValidator < DataLoader
  attr_reader :winning_score, :losing_score

  def initialize(path)
    super
    @data = @@data
    @pulls = get_pulls(@data)
    @boards = get_boards(@data)
    @winning_score, @losing_score = get_score
  end

  def get_score
    winners = 0
    pull_index = 0
    winning_score = 0
    losing_score = 0

    while pull_index < @pulls.length do
      board_index = 0

      while board_index < @boards.length do
        board = @boards[board_index]
        pull = @pulls[pull_index]

        result = board.record_pull(pull) 

        if result
          winners += 1
          winning_score = board.get_score(pull) if winners == 1
          losing_score = board.get_score(pull) if winners == @boards.length
        end

        board_index += 1
      end

      pull_index += 1
    end
    
    [winning_score, losing_score]
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