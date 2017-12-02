#!/usr/bin/env ruby

input_lines = IO.readlines 'input.txt'
input = input_lines[0].strip!
input = input.split ''
input.map! { |c| Integer c }

mid = input.length / 2
nexts = input[mid..-1] + input[0...mid]
input = input.zip nexts
input.map! do |a, b|
	if a == b then
		a
	else
		0
	end
end
p input.inject 0, :+