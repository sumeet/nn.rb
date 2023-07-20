class Float
  def to_s
    format("%.6f", self)
  end
end

class Model
    attr_accessor :or_w1, :or_w2, :or_b
    attr_accessor :nand_w1, :nand_w2, :nand_b
    attr_accessor :and_w1, :and_w2, :and_b

    def randomize!
      @or_w1 = rand
      @or_w2 = rand
      @or_b = rand
      
      @nand_w1 = rand
      @nand_w2 = rand
      @nand_b = rand

      @and_w1 = rand
      @and_w2 = rand
      @and_b = rand
    end

    def learn!(g, rate)
      @or_w1 -= g.or_w1 * rate
      @or_w2 -= g.or_w2 * rate
      @or_b -= g.or_b * rate
      @nand_w1 -= g.nand_w1 * rate
      @nand_w2 -= g.nand_w2 * rate
      @nand_b -= g.nand_b * rate
      @and_w1 -= g.and_w1 * rate
      @and_w2 -= g.and_w2 * rate
      @and_b -= g.and_b * rate
    end
end

def forward(m, x1, x2)
    a = sigmoid(x1*m.or_w1 + x2*m.or_w2 + m.or_b)
    b = sigmoid(x1*m.nand_w1 + x2*m.nand_w2 + m.nand_b)
    return sigmoid(a*m.and_w1 + b*m.and_w2 + m.and_b)
end

def print_xor(m)
  puts "or_w1: #{m.or_w1}"
  puts "or_w2: #{m.or_w2}"
  puts "or_b: #{m.or_b}"
  puts "nand_w1: #{m.nand_w1}"
  puts "nand_w2: #{m.nand_w2}"
  puts "nand_b: #{m.nand_b}"
  puts "and_w1: #{m.and_w1}"
  puts "and_w2: #{m.and_w2}"
  puts "and_b: #{m.and_b}"
end

def finite_diff(m, eps)
  g = Model.new
  c = cost(m)

  saved = m.or_w1
  m.or_w1 += eps
  g.or_w1 = (cost(m) - c) / eps
  m.or_w1 = saved

  saved = m.or_w2
  m.or_w2 += eps
  g.or_w2 = (cost(m) - c) / eps
  m.or_w2 = saved

  saved = m.or_b
  m.or_b += eps
  g.or_b = (cost(m) - c) / eps
  m.or_b = saved

  saved = m.nand_w1
  m.nand_w1 += eps
  g.nand_w1 = (cost(m) - c) / eps
  m.nand_w1 = saved

  saved = m.nand_w2
  m.nand_w2 += eps
  g.nand_w2 = (cost(m) - c) / eps
  m.nand_w2 = saved

  saved = m.nand_b
  m.nand_b += eps
  g.nand_b = (cost(m) - c) / eps
  m.nand_b = saved

  saved = m.and_w1
  m.and_w1 += eps
  g.and_w1 = (cost(m) - c) / eps
  m.and_w1 = saved

  saved = m.and_w2
  m.and_w2 += eps
  g.and_w2 = (cost(m) - c) / eps
  m.and_w2 = saved

  saved = m.and_b
  m.and_b += eps
  g.and_b = (cost(m) - c) / eps
  m.and_b = saved

  g
end

TRAIN_XOR = [
    [0, 0, 0],
    [0, 1, 1],
    [1, 0, 1],
    [1, 1, 0],
]
TRAIN = TRAIN_XOR

def sigmoid(x)
    1.0 / (1.0 + Math.exp(-x))
end

def cost(m)
    result = 0.0
    TRAIN.each do |(x1, x2, y_)|
        y = forward(m, x1, x2)
        d = y - y_
        result += d*d
    end
    result / TRAIN.size
end

#srand(69)
m = Model.new
m.randomize!

eps = 1e-1
rate = 1e-1

100_000.times do
  g = finite_diff(m, eps)
  m.learn!(g, rate)
  # puts "cost: #{cost(m)}"
end

puts "cost: #{cost(m)}"

puts "---------------------------"
[0, 1].each do |x1|
    [0, 1].each do |x2|
        y = forward(m, x1, x2)
        puts "#{x1} ^ #{x2} = #{y}"
    end
end

puts "---------------------------"
puts '"OR" neuron:'
[0, 1].each do |x1|
    [0, 1].each do |x2|
        y = sigmoid(x1*m.or_w1 + x2*m.or_w2 + m.or_b)
        puts "#{x1} | #{x2} = #{y}"
    end
end

puts "---------------------------"
puts '"NAND" neuron:'
[0, 1].each do |x1|
    [0, 1].each do |x2|
        y = sigmoid(x1*m.nand_w1 + x2*m.nand_w2 + m.nand_b)
        puts "#{x1} NAND #{x2} = #{y}"
    end
end

puts "---------------------------"
puts '"AND" neuron:'
[0, 1].each do |x1|
    [0, 1].each do |x2|
        y = sigmoid(x1*m.and_w1 + x2*m.and_w2 + m.and_b)
        puts "#{x1} & #{x2} = #{y}"
    end
end
