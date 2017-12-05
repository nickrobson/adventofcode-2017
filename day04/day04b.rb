#!/usr/bin/env ruby

def is_valid_passphrase(s)
	words = s.split ' '
	words.map! { |e| e.chars.sort.join }
	words == words.uniq
end

passphrases = IO.readlines('input.txt')
passphrases.select! { |e| is_valid_passphrase e }
p passphrases.length
