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

function move_tail(head, tail)
    #if head is inline with tail and > 1 away tail needs to move one towards
    if head[1] == tail[1] && abs(head[2] - tail[2]) > 1
        #tail move in direction of head
        tail[2] += ceil((head[2] - tail[2])/2) #TODO: this likely always just results in 1
    elseif head[2] == tail[2] && abs(head[1] - tail[1]) > 1
        tail[1] += ceil((head[1] - tail[1])/2)
    else
        #diagonal
        if head[2] - tail[2] > 1 && head[1] - tail[1] > 1
            #up right
            tail[1] += 1
            tail[2] += 1 
            return
        elseif head[2] - tail[2] > 1 && head[1] - tail[1] < -1
            #up left
            tail[1] -= 1
            tail[2] += 1 
            return
        elseif head[2] - tail[2] < -1 && head[1] - tail[1] < -1
            #down left
            tail[1] -= 1
            tail[2] -= 1 
            return
        elseif head[2] - tail[2] < -1 && head[1] - tail[1] > 1
            #down right 
            tail[1] += 1
            tail[2] -= 1 
            return
        end
        if head[1] != tail[1] && head[2] - tail[2] > 1
            #up
            tail[2] += 1 
            tail[1] = head[1]
        elseif head[1] != tail[1] && head[2] - tail[2] < -1
            #down
            tail[2] -= 1 
            tail[1] = head[1]
        end

        if head[2] != tail[2] && head[1] - tail[1] > 1
            #right
            tail[1] += 1 
            tail[2] = head[2]
        elseif head[2] != tail[2] && head[1] - tail[1] < -1
            #left
            tail[1] -= 1 
            tail[2] = head[2]
        end
    end
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
            move_tail(head, tail)
            
            push!(tail_visited, deepcopy(tail))
        end
    end
    answer = length(unique(tail_visited))
    println("Day 9 Part 1 Answer: ", answer)
end

tail_visited2 = []
let 
    rope = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
    for l in lines
        l2 = split(l, ' ')
        for n in range(1, parse(Int, l2[2]))
            #move head
            rope[1] += dir_to_direction(l2[1][1]) #hack to make the string a char
            
            for i in range(1, length(rope)-1)
                move_tail(rope[i], rope[i+1])
            end
            push!(tail_visited2, deepcopy(rope[end]))
        end
    end
    answer = length(unique(tail_visited2))
    println("Day 9 Part 2 Answer: ", answer)
end