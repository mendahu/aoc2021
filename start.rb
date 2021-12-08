require './Submarine'

@sub = Submarine.new

# Data Loading
@sub.load_data('depth', './data/01-depth')
@sub.load_data('dead-reckoning', './data/02-dead-reckoning')
@sub.load_data('diagnostics', './data/03-diagnostics')
@sub.load_data('bingo', './data/04-bingo')