require './Utilities/DataLoader.rb'

class Board
  attr_reader :pulls
  def initialize(tiles)
    @board = tiles
    @pulls = []
  end

  def get_row(index)
    @boards[index]
  end

  def get_column(index)
    @boards.map { |x| x[index] }
  end

  def check_row_or_column(arr, num)
    arr.include(num)
  end

  def check_board(num)
    row = get_row(0)
    check_row_or_column(row, num)
  end

  def record_pull(num)
    @pulls.push(num)
    check_board(num)
  end
end

class BingoValidator < DataLoader
  def initialize(path)
    super

    @data = [
      "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
      "",
      "22 13 17 11  0",
      "8  2 23  4 24",
      "21  9 14 16  7",
      "6 10  3 18  5",
      "1 12 20 15 19",
      "",
      "3 15  0  2 22",
      "9 18 13 17  5",
      "19  8  7 25 23",
      "20 11 10 24  4",
      "14 21 16 12  6",
      "",
      "14 21 17 24  4",
      "10 16 15  9 19",
      "18  8 23 26 20",
      "22 11 13  6  5",
      "2  0 12  3  7",
    ]

    @pulls = get_pulls(@data)
    @boards = get_boards(@data)
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

  def validate
    @pulls.each do |pull| @boards.each 

      do |board| 
        result = board.record_pull(pull) 
        if result == true return board
      end 

    end
  end
end