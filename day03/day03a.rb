#!/usr/bin/env ruby

# copied from my python file and converted to ruby:
# https://github.com/nickrobson/scripts/blob/master/cycle.py
def to_coord(id)
    if id <= 1
        return 0, 0
    end
    prev_root = Math.sqrt(id - 1).to_i
    prev_pow = prev_root ** 2
    next_pow = (prev_root + 1) ** 2
    if prev_root % 2 == 1 # is odd
        top_right = prev_pow
        bottom_right = prev_pow + (next_pow - prev_pow) / 2 + 1
        x = prev_root / 2 + 1
        if id > bottom_right
            x -= id - bottom_right
        end
        y = prev_root / 2 + 1 + top_right - [bottom_right, id].min
    else # is even
        bottom_left = prev_pow + 1
        top_left = prev_pow + (next_pow - prev_pow) / 2 + 1
        x = -prev_root / 2
        if id > top_left
            x += id - top_left
        end
        y = -prev_root / 2 - bottom_left + [top_left, id].min
    end
    return x, y
end

id = Integer IO.readlines('input.txt')[0]
coord = to_coord id
p coord[0].abs + coord[1].abs
