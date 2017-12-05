#!/usr/bin/env ruby

def execute(instructions, pc)
	current = instructions[pc]
	instructions[pc] += current >= 3 ? -1 : 1
	pc + current
end

instructions = IO.readlines('input.txt').map! { |a| Integer(a) }
pc, steps = 0, 0

while pc >= 0 && pc < instructions.length 
	pc = execute instructions, pc
	steps += 1
end

p steps