def split_cake(cake)
  raisins = []
  cake.each_with_index do |row, i|
    row.chars.each_with_index do |cell, j|
      raisins << [i, j] if cell == 'o'
    end
  end

  best_solution = nil

  #  чи є шматки правильними (одна родзинка )
  def valid_pieces?(pieces)
    pieces.all? { |piece| piece.join.count('o') == 1 }
  end

  #  обчислення площі шматка
  def piece_area(piece)
    piece.length * piece.first.length
  end

  #  горизонтальне розрізання
  def horizontal_cut(cake, raisins)
    pieces = []
    last_row = -1

    raisins.each do |(row, _)|
      if row > last_row
        piece = cake[last_row + 1..row].map(&:dup)
        pieces << piece
        last_row = row
      end
    end

    pieces
  end

  # вертикальне розрізання
  def vertical_cut(cake, raisins)
    transposed_cake = cake.map(&:chars).transpose.map(&:join)
    horizontal_pieces = horizontal_cut(transposed_cake, raisins.map { |r, c| [c, r] })
    horizontal_pieces.map { |piece| piece.map(&:chars).transpose.map(&:join) }
  end

  horizontal_pieces = horizontal_cut(cake, raisins)
  vertical_pieces = vertical_cut(cake, raisins)

  #  найкраще рішення
  if horizontal_pieces.any? && valid_pieces?(horizontal_pieces)
    best_solution = horizontal_pieces
  end

  if vertical_pieces.any? && valid_pieces?(vertical_pieces)
    if best_solution.nil? || (piece_area(vertical_pieces.first) == piece_area(best_solution.first) && vertical_pieces.first.size > best_solution.first.size)
      best_solution = vertical_pieces
    end
  end

  best_solution || []
end

# приклад
cake = %w(
  .o......
  ......o.
  ....o...
  ..o.....
)

result = split_cake(cake)

#  результат
result.each do |piece|
  piece.each { |line| puts line }
  puts "-" * 10
end