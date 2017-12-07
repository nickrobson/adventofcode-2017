#!/usr/bin/env ruby

class Tree

	attr_accessor :id
	attr_accessor :value
	attr_reader :children

	def initialize(id, value)
		@id = id
		@value = value
		@children = []
	end

	def add_child(child)
		@children.push(child)
	end

	def convert(trees)
		@children.each_with_index do |val, idx|
			@children[idx] = trees[val]
		end
	end

end

trees = Hash.new nil
lines = IO.readlines('input.txt')
lines.each do |line|
	words = line.strip.split(' ', 4)
	tree = Tree.new words[0], Integer(words[1][1...-1])
	if words.length > 2
		words[3].split(', ').each do |word|
			tree.add_child word
		end
	end
	trees[tree.id] = tree
end

used_trees = []
trees.each do |(key, val)|
	val.convert trees
	used_trees.push *val.children
end

used_trees.each do |tree| trees.delete tree.id end
trees.each do |(key, val)| p key end
