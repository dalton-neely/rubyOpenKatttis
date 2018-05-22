#!/usr/bin/ruby

MAX_ENTRIES = 50
MAX_CHARACTERS = 100
ENTRIES = STDIN.gets
NUM_LETTERS = 26

$i = 1
$letters = Array.new(26)

until $i > ENTRIES.to_i do 
    $line = STDIN.gets
    $pangram = 1
    $j = 65
    $k = 97
    while $j < NUM_LETTERS + 65 do
        if ($line.include? $j.chr) || ($line.include? $k.chr)
            $letters[$j - 65] = 1
        else 
            $letters[$j - 65] = 0
            $pangram = 0
        end
        $j += 1
        $k += 1
    end
    if $pangram == 1
        puts 'pangram'
    else
        print 'missing '
        $letters.each_with_index do |letter, index|
            if letter == 0
                print (index.to_i+97).chr
            end
        end
        print "\n"
    end
    $i += 1
end
