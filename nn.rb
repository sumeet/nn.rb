class Matrix
  attr_reader :rows, :cols, :es

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @es = [[0.0] * cols] * rows
  end

  def randomize!(lo, hi)
    (0...@rows).each do |r|
      (0...@cols).each do |c|
        @es[r][c] = rand * (hi - lo) + lo
      end
    end
  end
end

def mat_dot(dst, a, b)
end

def mat_sum(dst, src)
end

def mat_print(m)
  (0...m.rows).each do |r|
    (0...m.cols).each do |c|
      print "#{m.es[r][c]} "
    end
    puts
  end
end

m = Matrix.new 2, 2
m.randomize!(0, 10)
mat_print(m)