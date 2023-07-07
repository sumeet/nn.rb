TRAIN = [
    [0, 0],
    [1, 2],
    [2, 4],
    [3, 6],
    [4, 8],
]

def cost(w)
    cost_fn = 0.0
    TRAIN.each do |x, y_|
        y = x*w
        d = y - y_
        cost_fn += d*d
    end
    cost_fn / TRAIN.size
end

srand(69)
w = rand

eps = 1e-3
rate = 1e-3

puts "cost: #{cost(w)}"
100_000.times do
    dcost = (cost(w + eps) - cost(w)) / eps
    w -= rate*dcost
    puts "cost: #{cost(w)}, w: #{w}"
end

puts "at the end, w = #{w}"