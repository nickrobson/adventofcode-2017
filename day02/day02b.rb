#!/usr/bin/env ruby

def line_div(line)
	xs = line.split /\t/
	xs.map! { |s| Integer s }
	xs.each_with_index.inject(0) do |sum, (x, i)|
		after = xs.slice(i+1..-1)
		after.map! do |y|
			if x % y == 0
				x / y
			elsif y % x == 0
				y / x
			else
				0
			end
		end
		sum + (after.inject 0, :+)
	end
end

input_lines = IO.readlines 'input.txt'
input_lines.map! { |line| line_div line }
p input_lines.inject 0, :+