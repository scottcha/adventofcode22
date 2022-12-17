open("input.txt") do f
    num_contained = 0
    num_overlap = 0
    while !eof(f)
        s = readline(f)
        bounds = []
        for x in eachsplit(s, [',','-'])
            append!(bounds, parse(Int32, x))
        end
        #part 1
        if bounds[1] <= bounds[3] && bounds[2] >= bounds[4]
            #is second inside first
            num_contained += 1
        elseif bounds[3] <= bounds[1] && bounds[4] >= bounds[2]
            #is first inside second 
            num_contained += 1
        end

        #part 2
        if bounds[1] >= bounds[3] && bounds[1] <= bounds[4] || bounds[2] >= bounds[3] && bounds[2] <= bounds[4]
            num_overlap += 1
        elseif bounds[3] >= bounds[1] && bounds[3] <= bounds[2] || bounds[4] >= bounds[1] && bounds[4] <= bounds[2]
            num_overlap += 1
        end
    end
    println("Day 4 part 1 answer: ", num_contained)
    println("Day 4 part 1 answer: ", num_overlap)
end
