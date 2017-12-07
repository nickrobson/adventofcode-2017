#!/usr/bin/env ruby

class Tree

	attr_accessor :id
	attr_reader :weight
	attr_reader :children

	def initialize(id, weight)
		@id = id
		@weight = weight
		@totalweight = nil
		@found_unbalanced = 0
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

	def get_weight()
		if @totalweight == nil
			@totalweight = @weight + @children.map { |c| c.get_weight }.inject(0, :+)
		end
		@totalweight
	end

	def find_unbalanced()
		if @found_unbalanced == 0
			unb = @children.map { |c| c.find_unbalanced }.select { |c| c }
			if unb.empty?
				children_weights = @children.map { |c| c.get_weight }
				if children_weights.uniq.length <= 1
					@found_unbalanced = nil
				else
					counts = children_weights.uniq.map { |w| [children_weights.count(w), w] }
					@found_unbalanced = [@children[children_weights.find_index(counts.min[1])], @children[children_weights.find_index(counts.max[1])]]
				end
			else
				@found_unbalanced = unb[0]
			end
		end
		@found_unbalanced
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
trees.each do |(key, val)| val.convert trees end
unb = trees['bpvhwhh'].find_unbalanced()
p unb[0].weight - unb[0].get_weight + unb[1].get_weight
