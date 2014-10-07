################################################################################
# Porter Stemmer for Spanish
#
# Based on algorithm described in:
# http://snowball.tartarus.org/algorithms/spanish/stemmer.html
#
# Author: Jason J
# Start: 6 October 2014
################################################################################

# Test Cases
# beautiful
# R1: iful
# R2: ul
#
# beauty
# R1: y
# R2: 
#
# beau
# R1: 
# R2 
#
# animadversion
# R1: imadversion
# R2: adversion
#
# sprinkled
# R1: kled
# R2: 
#
# eucharist
# R1: harist
# R2: ist

# Get the R1 of the word.
def get_r1(word)
  # R1 should be empty string if nothing matches.
  r1 = ""
  
  matches = /(?<r1_start>[aeiouáéíóúü][b-df-hj-np-tv-zñ])/.match(word)
  
  if matches != nil
    # puts "#{matches[:r1_start]}"
    r1 = word[/(?<r1_start>[aeiouáéíóúü][b-df-hj-np-tv-zñ].*)/]
    r1.sub!(matches[:r1_start], "")
    # puts "#{r1}"
  end
  
  return r1
end

# So R2 is to R1 what R1 is to the word.
def get_r2(word)
  # r2 = ""
  #
  # matches = /(?<r2_start>[aeiouáéíóúü][b-df-hj-np-tv-zñ])/.match(word)
  #
  # if matches != nil
  #   r2 = word[/(?<r2_start>[aeiouáéíóúü][b-df-hj-np-tv-zñ].*)/]
  #   r2.sub!(matches[:r2_start], "")
  # end
  #
  # return r2
  
  return get_r1(word)
end

def get_rv(word)
  rv = ""
  
  if /[b-df-hj-np-tv-zñ]/.match(word[1]) != nil
    rv = word.sub(/^.[b-df-hj-np-tv-zñ]*[aeiouáéíóúü]/, "")
  elsif /^[aeiouáéíóúü]{2}/.match(word) != nil
    rv = word.sub(/^[aeiouáéíóúü]*[b-df-hj-np-tv-zñ]/, "")
  else
    rv = word[3..-1]
  end
  
  return rv
end

def vowel?(letter)
  return (/^[aeiouáéíóúü]$/.match(letter) != nil)
end

puts "Enter a word:"
word = gets.chomp

r1 = get_r1(word)
r2 = get_r2(r1)
rv = get_rv(word)

puts "R1: #{r1}"
puts "R2: #{r2}"
puts "RV: #{rv}"