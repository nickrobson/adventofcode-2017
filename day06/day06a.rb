#!/usr/bin/env ruby

def next_state(state)
    idx = state.find_index(state.max)
    new_state = state.map { |e| e }
    new_state[idx] = 0
    (0...state[idx]).each do
    	idx = idx.next % new_state.length
    	new_state[idx] += 1
    end
    return new_state
end

state = IO.readlines('input.txt')[0].split("\t").map! { |s| Integer(s) }
seen = []

while not seen.include? state
	seen.push state
	state = next_state state
end

p seen.length