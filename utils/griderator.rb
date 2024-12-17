class Griderator5000
  attr_reader :grid

  def initialize(initial_grid = nil, default_value: nil, rows: nil, cols: nil)
    if initial_grid
      @grid = initial_grid.map { |line| line.chars }.dup
    else
      raise ArgumentError, "rows and cols must be specified if no initial_grid is given" unless rows && cols
      @grid = Array.new(rows) { Array.new(cols, default_value) }
    end
  end

  def [](row, col)
    return nil unless in_bounds?(row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    return unless in_bounds?(row, col)
    @grid[row][col] = value
  end

  def in_bounds?(row, col)
    row >= 0 && col >= 0 && row < @grid.size && col < @grid.first.size
  end

  def get_homies(row, col, diagonals: false)
    directions = [
      [-1, 0], [1, 0],
      [0, -1], [0, 1]
    ]
    if diagonals
      directions += [
        [-1, -1], [-1, 1],
        [1, -1], [1, 1]
      ]
    end

    directions.map { |dr, dc| [row + dr, col + dc] }
              .select { |nr, nc| in_bounds?(nr, nc) }
  end

  def each_cell
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        yield(row_idx, col_idx, cell)
      end
    end
  end

  def each
    @grid.each do |row|
      yield(row)
    end
  end

  def find_location(character)
    each_cell do |row_idx, col_idx, cell|
      return [row_idx, col_idx] if cell == character
    end
    nil
  end

  def grid_me
    puts @grid.map { |row| row.map { |cell| cell.nil? ? '.' : cell }.join(' ') }.join("\n")
  end

  def fill_grid_with_stuff(value)
    each_cell do |row, col, _|
      @grid[row][col] = value
    end
  end

  def map!
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |value, col_idx|
        @grid[row_idx][col_idx] = yield(value, row_idx, col_idx)
      end
    end
  end

  def map
    new_grid = @grid.map.with_index do |row, row_idx|
      row.map.with_index do |cell, col_idx|
        yield(cell, row_idx, col_idx)
      end
    end
    Griderator5000.new(new_grid)
  end

  def find_all_locations(character)
    locations = []
    each_cell do |row, col, value|
      locations << [row, col] if value == character
    end
    locations
  end

  def find_all_not_locations(character)
    locations = []
    each_cell do |row, col, value|
      locations << [row, col] if value != character
    end
    locations
  end

  def transpose
    new_grid = @grid.transpose
    Griderator5000.new(new_grid)
  end

  def turn_sideways_clockwise
    new_grid = @grid.map(&:reverse).transpose
    Griderator5000.new(new_grid)
  end

  def turn_sideways_the_ther_way
    new_grid = @grid.map(&:reverse).transpose.map(&:reverse)
    Griderator5000.new(new_grid)
  end

  def flip_horizotal
    new_grid = @grid.map(&:reverse)
    Griderator5000.new(new_grid)
  end

  def flip_vertical
    new_grid = @grid.reverse
    Griderator5000.new(new_grid)
  end

  def in_line?(point1, point2)
    row1, col1 = point1
    row2, col2 = point2

    return true if row1 == row2

    return true if col1 == col2

    return true if (row1 - row2).abs == (col1 - col2).abs

    false
  end

  def points_in_line(points)
    result = {}

    points.each do |point|
      aligned_points = []

      points.each do |other_point|
        next if point == other_point
        aligned_points << other_point if in_line?(point, other_point)
      end

      result[point] = aligned_points
    end

    result
  end

  def get_difference(point1, point2)
    row1, col1 = point1
    row2, col2 = point2
    [row2 - row1, col2 - col1]
  end

  def height
    @grid.size
  end

  def width
    @grid.first.size
  end

  def move_to_new_location(point, velocity)
    row, col = point
    vx, vy = velocity

    new_row = row + vx
    new_col = col + vy

    if in_bounds?(new_row, new_col)
      [new_row, new_col]
    else
      nil
    end
  end

  def move_to_new_location_with_wrap(point, velocity)
    row, col = point
    vx, vy = velocity

    new_row = (row + vx) % height
    new_col = (col + vy) % width

    new_row += grid_height if new_row < 0
    new_col += grid_width if new_col < 0

    [new_row, new_col]
  end

  def is_wall?(row, col, wall_character: '#')
    @grid[row, col] == wall_character || @grid[row, col] == nil
  end
end

# initial_grid = [
#   ['a', 'b', 'c'],
#   ['d', 'e', 'f'],
#   ['g', 'h', 'i']
# ]

# grid = Griderator5000.new(initial_grid)
# puts "Grid initialized from array:"
# puts grid.grid_me

# puts "\nFinding location of 'e':"
# location = grid.find_location('e')
# puts location ? "Found at: #{location}" : "Not found"

# puts grid.get_homies(1, 1).inspect
# puts grid.get_homies(1, 1, diagonals: true).inspect
