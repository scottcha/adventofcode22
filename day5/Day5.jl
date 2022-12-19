function configure_stacks(config, num_containers)
    containers = [] 
    #create the right number of containers
    for x in 1:num_containers
        push!(containers, [])
    end
    
    #fill the containers
    row = (length(config))
    while row > 0
        #indexes 2, 6, 10
        container_iter = 1
        for x in range(2,stop=length(config[row]),step=4)
            c = config[row][x]
            if c != ' '
                push!(containers[container_iter], c)
            end
            container_iter += 1
        end
        row -= 1
    end
    println("final ", containers)
    return containers
end


open("input.txt") do f
    finished_stack_config = false
    stack_config = String[]
    num_containers = -1
    containers = []
    containers2 = []
    while !eof(f)
        s = readline(f)
        if !finished_stack_config
            if s[2] == '1'
                finished_stack_config = true
                num_containers = parse(Int, s[length(s)-1])
                containers = configure_stacks(stack_config, num_containers)
                containers2 = deepcopy(containers)
                #read the blank line
                readline(f)
            end
            push!(stack_config, s)
        else
            command = [x.match for x in eachmatch(r"[0-9]+", s)]
            
            println("command: ", command)
            #part 1 logic
            for x in 1:parse(Int32, command[1])
                tmp = pop!(containers[parse(Int32, command[2])])
                push!(containers[parse(Int32, command[3] )], tmp)
            end

            #part 2 logic
            tmp2 = []
            for x in 1:parse(Int32, command[1])
                var = pop!(containers2[parse(Int32, command[2])])
                append!(tmp2,var)
            end
            append!(containers2[parse(Int32, command[3] )], reverse(tmp2))

        end
    end
    answer = [containers[x][end] for x in 1:length(containers)]
    answer2 = [containers2[x][end] for x in 1:length(containers2)]
    println("Day 5 part 1 answer: ", answer)
    println("Day 5 part 2 answer: ", answer2)
end

