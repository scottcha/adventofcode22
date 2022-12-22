struct TreeNode
    parent::Union{Missing, TreeNode}
    name::String
    size::Int
    children::Union{Missing, Vector{TreeNode}}
end
const upper_limit::Int = 100000
const total_space::Int = 70000000
const goal::Int = 30000000 
const current_total::Int = 45174025 #calclated in previous run
const free = total_space - current_total 
dir_totals::Int = 0
possible_dirs::Vector{Int} = [] 
global possible_dirs::Vector{Int} = [] 
function find_dir_sizes(n::TreeNode)
    if n.children === missing 
        return n.size
    else
        dir_size::Int = 0
        for c in n.children
            dir_size += find_dir_sizes(c) 
        end
        if dir_size <=  upper_limit
            #store the answer
            global dir_totals += dir_size
        end
        if free + dir_size >= goal
            push!(possible_dirs, copy(dir_size))
        end
        return dir_size
    end
end
commands = []
#Read the file seperatly as the vs code debugger gets confused in 
#in the context block
open("input.txt") do f
    while !eof(f)
        s = readline(f)
        push!(commands, s)
    end
end
root = TreeNode(missing, "/", 0, Vector{TreeNode}())
current = root
let line_num = 1
    while line_num <= length(commands)
        line = commands[line_num]
        if line[1] == '\$'
            #command
            c = split(line, ' ')
            if c[2] == "cd"
                if c[3] == "/"
                    current = root
                elseif c[3] == ".."
                    current = current.parent
                else
                    #cd to child dir
                    current = current.children[findfirst(item -> item.name == c[3], current.children)]
                end
            elseif c[2] == "ls"
                line_num += 1
                if line_num <= length(commands)
                    line = commands[line_num]
                else
                    break
                end
                #get listing
                while line[1] != '\$'
                    pieces = split(line, ' ')
                    if match(r"[0-9]+", pieces[1]) !== nothing 
                        #file
                        s = parse(Int, pieces[1])
                        push!(current.children, TreeNode(current, pieces[2], s, missing))
                    else 
                        #has to be a dir (TODO: error checking)
                        push!(current.children, TreeNode(current, pieces[2], 0, Vector{TreeNode}()))
                    end
                    line_num += 1
                    if line_num <= length(commands)
                        line = commands[line_num]
                    else
                        break
                    end
                end
                #move one back since we need to process this command in diff part of loop
                line_num -= 1
            end
        end
        line_num += 1
    end
end

total = find_dir_sizes(root)
println("Day 7 part 1 answer: ", dir_totals)
sorted_answers = sort(possible_dirs)
println("Day 7 part 2 answer: ", sorted_answers[1])