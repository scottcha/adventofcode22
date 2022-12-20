open("input.txt") do f
    char_count = 4 
    buffer = []
    count_from_beginning = 0
    while !eof(f)
        s = read(f, Char)
        push!(buffer, s)
        count_from_beginning += 1
        if length(buffer) < char_count
            continue
        else
            #size char_count
            if(length(Set(buffer))) == char_count
                break
            else
                popfirst!(buffer)
            end
        end
    end
    println("Day6 part 1 answer: ", count_from_beginning)
end

open("input.txt") do f
    char_count = 14 
    buffer = []
    count_from_beginning = 0
    while !eof(f)
        s = read(f, Char)
        push!(buffer, s)
        count_from_beginning += 1
        if length(buffer) < char_count
            continue
        else
            #size char_count
            if(length(Set(buffer))) == char_count
                break
            else
                popfirst!(buffer)
            end
        end
    end
    println("Day6 part 2 answer: ", count_from_beginning)
end