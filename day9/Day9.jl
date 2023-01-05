function dir_to_direction(c::Char)
    if c == 'L'
        return [-1, 0]
    elseif c == 'U'
        return [0, 1]
    elseif c == 'R'
        return [1, 0]
    else
        return [0, -1]
    end
end

file = open("input.txt")
lines = []
while !eof(file)
    s = readline(file)
    push!(lines, s)
end

tail_visited = []
let 
    head = [0,0]
    tail = [0,0]
    for l in lines
        l2 = split(l, ' ')
        for n in range(1, parse(Int, l2[2]))
            #move head
            head += dir_to_direction(l2[1][1]) #hack to make the string a char

            #move tail
            #if head is inline with tail and > 1 away tail needs to move one towards
            if head[1] == tail[1] && abs(head[2] - tail[2]) > 1
                #tail move in direction of head
                tail[2] += (head[2] - tail[2])/2
            elseif head[2] == tail[2] && abs(head[1] - tail[1]) > 1
                tail[1] += (head[1] - tail[1])/2
            else
                #diagonal
                if head[1] != tail[1] && head[2] - tail[2] > 1
                    #up
                    tail[2] += 1 #ceil((head[2] - tail[2])/2)
                    tail[1] = head[1]
                elseif head[1] != tail[1] && head[2] - tail[2] < -1
                    #down
                    tail[2] -= 1 #ceil((head[2] - tail[2])/2)
                    tail[1] = head[1]
                end

                if head[2] != tail[2] && head[1] - tail[1] > 1
                    #right
                    tail[1] += 1 #ceil((head[1] - tail[1])/2)
                    tail[2] = head[2]
                elseif head[2] != tail[2] && head[1] - tail[1] < -1
                    #left
                    tail[1] -= 1 #ceil((head[1] - tail[1])/2)
                    tail[2] = head[2]
                end
            end
            push!(tail_visited, deepcopy(tail))
        end
    end
    answer = length(unique(tail_visited))
    print("Day 9 Part 1 Answer: ", answer)
end