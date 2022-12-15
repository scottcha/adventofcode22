#find most calories from any single elf

elfCalories = [0]
open("input.txt") do f
    elf = 1
    
    #elfCalories = zeros(0)
    s = ""
    line = 0
    while ! eof(f)
        s = readline(f)        
        if(s == "")            
            elf += 1            
            append!(elfCalories, 0)
        else            
            elfCalories[elf] += parse(Int32, s)
        end
        line += 1
    end
end

function find_most_calories(elves)
    currentMax = (1, elves[1])
    for i in 1:length(elves)
        if elves[i] > currentMax[2]
            currentMax = (i, elves[i])
        end
    end
    return currentMax
end

answer = find_most_calories(elfCalories)

println("Day1 part one answer: ", answer[2])

#find most calories for top 3 elves

function find_most_calories(elves, n = 3)
    return sum(sort(elves, rev=true)[1:n])
end

answer2 = find_most_calories(elfCalories)

println("Day1 part two answer: ", answer2)


