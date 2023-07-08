TRAIN = [
    [0, 0],
    [1, 2],
    [2, 4],
    [3, 6],
    [4, 8],
]

def cost(w, b)
    cost_fn = 0.0
    TRAIN.each do |x, y_|
        y = x*w + b
        d = y - y_
        cost_fn += d*d
    end
    cost_fn / TRAIN.size
end

#srand(69)
w = rand * 10.0
b = rand * 5.0

eps = 1e-3
rate = 1e-3

puts "cost: #{cost(w, b)}"
20_000.times do
    c = cost(w, b)
    dw = (cost(w + eps, b) - c) / eps
    db = (cost(w, b + eps) - c) / eps
    w -= rate*dw
    b -= rate*db
    puts "cost: #{c}, w: #{w}, b: #{b}"
end

puts "at the end, w = #{w}, b = #{b}"