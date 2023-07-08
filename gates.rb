class Float
  def to_s
    format("%.6f", self)
  end
end

TRAIN_OR = [
    [0, 0, 0],
    [0, 1, 1],
    [1, 0, 1],
    [1, 1, 1],
]
TRAIN = TRAIN_OR

def sigmoid(x)
    1.0 / (1.0 + Math.exp(-x))
end

def cost(w1, w2, b)
    result = 0.0
    TRAIN.each do |(x1, x2, y_)|
        y = sigmoid(x1*w1 + x2*w2 + b)
        d = y - y_
        result += d*d
    end
    result / TRAIN.size
end

#srand(69)
w1 = rand
w2 = rand
b = rand

puts "w1: #{w1}, w2: #{w2}, b: #{b}"

eps = 1e-1
rate = 1e-1

puts "cost: #{cost(w1, w2, b)}"

50_000.times do
    c = cost(w1, w2, b)
    puts "w1: #{w1}, w2: #{w2}, b: #{b}, cost: #{c}"
    dw1 = (cost(w1 + eps, w2, b) - c) / eps
    dw2 = (cost(w1, w2 + eps, b) - c) / eps
    db = (cost(w1, w2, b + eps) - c) / eps
    w1 -= rate * dw1
    w2 -= rate * dw2
    b -= rate * db
end

puts "--------------------"
c = cost(w1, w2, b)
puts "w1: #{w1}, w2: #{w2}, b: #{b}, cost: #{c}"

[0, 1].each do |x1|
    [0, 1].each do |x2|
        y = sigmoid(x1*w1 + x2*w2 + b)
        puts "#{x1} ^ #{x2} = #{y}"
    end
end