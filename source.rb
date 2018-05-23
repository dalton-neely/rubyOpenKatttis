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

def printOutput (output)
    index = 0
    while index < output.length
        puts output[index]
        index += 1
    end
end

def locateI (players)
    i = 0
    upOrDown = nil
    players.each_with_index do |player, index|
        if (index != players.length - 1) && (index != 0)
            prv = index - 1
            nxt = index + 1
            if (player < players[nxt] && player < players[prv]) || (player > players[nxt] && player > players[prv])
                i = index
                if (player > players[nxt] && player > players[prv])
                    upOrDown = "up"
                else
                    upOrDown = "down"
                end
                break
            end
        end
    end
    return i, upOrDown
end

def locateJ (iVal, players, upOrDown)
    j = 0
    players.each_with_index do |player, index|
        if upOrDown == "down"
            if index = players.length - 1
                if player > iVal
                    j = players.length - 1
                end
            else
                if player < iVal
                    j = index
                    break
                end
            end
        else
            if player > iVal
                j = index
                break
            end
        end
    end
    return j
end

def isSorted? (players)
    players.each_with_index do |player, index|
        if index != players.length - 1
            if player < players[index + 1]
                return false
            end
        end
    end
    return true
end

def moveUp(i,j,players)
    temp = players[i]
    while i != j do
        i -= 1
        players[i + 1] = players[i]
    end
    players[j] = temp
    return players
end

def moveDown(i,j,players)
    temp = players[i]
    while i != j do
        i += 1
        players[i - 1] = players[i]
    end
    players[j] = temp
    return players
end

def move(i,j,players)
    if i > j
        return moveUp(i,j,players)
    else
        return moveDown(i,j,players)
    end
end

def ranklistSort (players)
    output = Array.new()
    numMoves = 0
    until isSorted?(players)
        i, upOrDown = locateI(players)
        j = locateJ(players[i], players, upOrDown)
        numMoves += 1
        output.push("#{i + 1} #{j + 1}")
        players = move(i, j, players)
    end
    output = ["#{numMoves}"] + output
    return output
end

$numPlayers = STDIN.gets.to_i 
$scores = getScores($numPlayers)

if ARGV[0] <=> "test"
    
    class Testing < Test::Unit::TestCase
    
        def test_getScores
            assert_equal([20, 30, 5, 15, 10], $scores)
        end

        def test_locateI
            assert_equal([1, "up"], locateI($scores))
            assert_equal([2, "down"], locateI([30,20,5,15,10]))
        end

        def test_locateJ
            assert_equal(0, locateJ(30, $scores, "up"))
            assert_equal(4, locateJ(5, [30, 20, 5, 15, 10], "down"))
        end

        def test_isSorted
            assert_equal(true, isSorted?([30, 20, 15, 10, 5]))
            assert_equal(false, isSorted?([30, 20, 45, 10, 5]))
            assert_equal(false, isSorted?([1, 20, 15, 10, 5]))
            assert_equal(false, isSorted?([30, 20, 15, 10, 45]))
        end

        def test_moveUp
            assert_equal([30,20,5,15,10], moveUp(1,0, $scores))
        end

        def test_moveDown
            assert_equal([30,20,15,10,5], moveDown(2,4,[30,20,5,15,10]))
        end

        def test_ranklistSort
            assert_equal(["2", "2 1", "3 5"], ranklistSort([20,30,5,15,10]))
        end
    end

else
    output = ranklistSort($scores)
    printOutput(output)
end