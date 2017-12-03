#!/usr/bin/env ruby

PRINT_GRID = ARGV.length > 0 && ARGV[0] == '--grid'

def p_grid(grid, x, y)
	if PRINT_GRID
		grid = grid.each_with_index.map do |row, y0|
			row.each_with_index.map do |cell, x0|
				if x == x0 && y == y0
					'X'
				elsif cell != 0
					cell
				else
					' '
				end
			end
		end
		grid.each do |row|
			puts row.join "\t"
		end
	end
end

def fill_entry(grid, x, y)
	grid[y][x] = (-1..1).inject(0) do |sum, dy|
		(-1..1).inject(sum) do |sum0, dx|
			rx, ry = x + dx, y + dy
			if rx >= 0 && rx < grid[0].length && ry >= 0 && ry < grid.length
				sum0 + grid[ry][rx]
			else
				sum0
			end
		end
	end

end

def move(grid, x, y)
	if x >= 0 && grid[y][x - 1] != 0 && grid[y - 1][x] == 0
		dx, dy = 0, -1
	elsif x >= 0 && y < grid.length - 1 && (grid[y + 1][x - 1] != 0 || grid[y + 1][x] != 0)
		dx, dy = -1, 0
	elsif x < grid[0].length - 1 && y < grid.length - 1 && (grid[y + 1][x + 1] != 0 || grid[y][x + 1] != 0)
		dx, dy = 0, 1
	else
		dx, dy = 1, 0
	end
	x, y = x + dx, y + dy
	return x, y
end

def find_threshold(cap)
	iter, curr, root = 0, 1, 1
	grid = Array.new(20) { |i| Array.new(20) { |i| 0 } }
	x, y = grid.length / 2, grid[0].length / 2
	grid[y][x] = 1
	while curr <= cap
		curr = fill_entry grid, x, y
		x, y = move grid, x, y
		if iter % 5 == 0 || curr > cap
			p_grid grid, x, y
		end
		iter += 1
	end
	curr
end

cap = Integer IO.readlines('input.txt')[0]
val = find_threshold cap
p val