#!/usr/bin/env ruby

def line_diff(line)
	xs = line.split /\t/
	xs.map! { |s| Integer s }
	return xs.max - xs.min
end

input_lines = IO.readlines 'input.txt'
input_lines.map! { |line| line_diff line }
p input_lines.inject 0, :+