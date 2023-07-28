class Float
  def to_s
    format("%.6f", self)
  end
end

def sigmoid(x)
  1.0 / (1.0 + Math.exp(-x))
end

class Matrix
  attr_accessor :rows, :cols, :es

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @es = Array.new(rows) { Array.new(cols, 0.0) }
  end

  def randomize!(lo, hi)
    fill! { rand * (hi - lo) + lo }
  end

  def fn!(&block)
    (0...@rows).each do |r|
      (0...@cols).each do |c|
        @es[r][c] = block.call(@es[r][c])
      end
    end
  end

  def fill!(&block)
    (0...@rows).each do |r|
      (0...@cols).each do |c|
        @es[r][c] = block.call
      end
    end
  end
end

def mat_dot(dst, a, b)
  fail unless a.cols == b.rows
  fail unless dst.rows == a.rows
  fail unless dst.cols == b.cols

  dst.rows.times do |r|
    dst.cols.times do |c|
      sum = 0.0
      a.cols.times do |i|
        sum += a.es[r][i] * b.es[i][c]
      end
      dst.es[r][c] = sum
    end
  end
end

def mat_sum(dst, src)
  fail unless dst.rows == src.rows && dst.cols == src.cols
  (0...dst.rows).each do |r|
    (0...dst.cols).each do |c|
      dst.es[r][c] += src.es[r][c]
    end
  end
end

def mat_print(m)
  puts "["
  (0...m.rows).each do |r|
    (0...m.cols).each do |c|
      print "    #{m.es[r][c]} "
    end
    puts
  end
  puts "]"
end

def cost(xor, ti, to)
  fail unless ti.rows == to.rows
  (0...ti.rows).each do |r|
  end
end

class Xor
  attr_accessor :a0, :a2

  def initialize
    @a0 = Matrix.new 1, 2
    @w1 = Matrix.new 2, 2
    @b1 = Matrix.new 1, 2
    @a1 = Matrix.new 1, 2
    @w2 = Matrix.new 2, 1
    @b2 = Matrix.new 1, 1
    @a2 = Matrix.new 1, 1

    @w1.randomize!(0.0, 1.0)
    @b1.randomize!(0.0, 1.0)
    @w2.randomize!(0.0, 1.0)
    @b2.randomize!(0.0, 1.0)
  end

  def forward!
    # first layer
    mat_dot(@a1, @a0, @w1)
    mat_sum(@a1, @b1)
    @a1.fn! { |x| sigmoid(x) }

    # second layer
    mat_dot(@a2, @a1, @w2)
    mat_sum(@a2, @b2)
    @a2.fn! { |x| sigmoid(x) }
  end
end

nn = Xor.new

2.times do |i|
  2.times do |j|
    nn.a0.es[0][0] = i
    nn.a0.es[0][1] = j
    nn.forward!
    y = nn.a2.es[0][0]
    puts "#{i} ^ #{j} = #{y}"
  end
end