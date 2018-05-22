#!/usr/bin/env ruby

require "test/unit"

def getScores (players)
    scores = Array.new(players)
    index = 0
    while index < players do 
        scores[index] = STDIN.gets.to_i
        index += 1
    end
    return scores
end

def findIndexDown (scores)
    lowest = scores[0]
    lowestIndex = 0
    scores.each_with_index do |score, index|
        if lowest > scores[index]
            lowest = scores[index]
            lowestIndex = index
        end
    end
    return lowestIndex, scores.length - 1
end

def findIndexUp (scores)
    highest = scores[0]
    highestIndex = 0
    scores.each_with_index do |score, index|
        if highest < scores[index]
            highest = scores[index]
            highestIndex = index
        end
    end
    return highestIndex, 0
end

$numPlayers = STDIN.gets.to_i 
$scores = getScores($numPlayers)
$output = Array.new()

if ARGV[0] <=> "test"
    
    class Testing < Test::Unit::TestCase
    
        def test_getScores
            assert_equal([20, 30, 5, 15, 10], $scores)
        end

        def test_findIndexDown
            assert_equal([2, 4] , findIndexDown($scores))
        end

        def test_findIndexUp
            assert_equal([1, 0], findIndexUp($scores))
        end
    
    end

else 
    index = 0
    i = 0
    j = 0
    state = $scores
    offset = 1
    while index < $numPlayers - 1 do 
        i,j = findIndexUp(state)
        if i != j
            $output.push("#{i + offset} #{j + offset}")
        end
        offset += 1
        state.delete_at(i)
        index += 1
        i,j = findIndexDown(state)
        if i != j
            $output.push("#{i + offset} #{j + offset}")
        end
        state.delete_at(i)
        index += 1
    end
    print $output
end