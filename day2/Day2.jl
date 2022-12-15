function rps_score_part1(a, b)
    score = -1
    if(b == 'X')
        score = 1
        if(a == 'A')
            return score + 3
        elseif (a == 'B')
            return score + 0
        elseif(a == 'C')
            return score + 6
        else 
            return -1
        end
    elseif(b == 'Y')
        score = 2
        if(a == 'A')
            return score + 6
        elseif (a == 'B')
            return score + 3
        elseif(a == 'C')
            return score + 0
        else 
            return -1
        end
    elseif(b == 'Z')
        score = 3
        if(a == 'A')
            return score + 0
        elseif (a == 'B')
            return score + 6
        elseif(a == 'C')
            return score + 3
        else 
            return -1
        end
    end
end

function rps_score_part2(a, b)
    score = -1
    if(b == 'X')
        score = 0
        if(a == 'A')
            return score + 3 #scissors
        elseif (a == 'B')
            return score + 1 #rock
        elseif(a == 'C')
            return score + 2 #paper
        else 
            return -1
    end
    elseif(b == 'Y')
        score = 3
        if(a == 'A')
            return score + 1 #rock
        elseif (a == 'B')
            return score + 2 #paper
        elseif(a == 'C')
            return score + 3 #scissors
        else 
            return -1
        end
    elseif(b == 'Z')
        score = 6
        if(a == 'A')
            return score + 2 #paper
        elseif (a == 'B')
            return score + 3 #scissors
        elseif(a == 'C')
            return score + 1 #rock
        else 
            return -1
        end
    else 
        return -1
    end

    if(a == 'A')
        return score + 1
    elseif (a == 'B')
        return score + 2
    elseif(a == 'C')
        return score + 3
    else 
        return -1
    end
end

open("C:/Users/scott/source/repos/adventofcode22/day2/input.txt") do f
    total_score = 0
    total_score2 = 0
    while !eof(f)
        s = readline(f)
        tmp = rps_score_part1(s[1], s[3])
        if(tmp == -1)
            println("error for line", s)
        end
        total_score += tmp
        
        tmp2 = rps_score_part2(s[1], s[3])
        if(tmp2 == -1)
            println("part2 error for line", s)
        end
        total_score2 += tmp2
    end
    println("Day2 part1 answer: ", total_score)
    println("Day2 part2 answer: ", total_score2)
end