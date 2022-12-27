using IterTools
using Distributed
using FunctionalCollections 
#Read the file seperatly as the vs code debugger gets confused in 
#in the context block
function readUnknownSizeMatrix(filename::String)
    # Read in the contents of the file as a string
    file = open(filename)

    x_dim = 0
    y_dim = 0
    lines = []
    while !eof(file)
        s = readline(file)
        push!(lines, s)
        x_dim = length(s)
        y_dim += 1
    end
    matrix = zeros(Int8, (x_dim, y_dim))

    for r in eachindex(lines)
        for c in 1:length(lines[r])
            matrix[r,c] = parse(Int8, lines[r][c])
        end
    end

    # Return the matrix
    return matrix
end

function find_visible(trees::Matrix{Int8}, visible_trees::BitMatrix, i::Union{StepRange{Int64, Int64},Base.OneTo{Int64}}, rowwise=true)
    max = deepcopy(trees[i[firstindex(i)],:])
    if !rowwise 
        max = deepcopy(trees[:,i[firstindex(i)]])
    end

    outside = true
    for r in i 
        if outside == true #edges are all visible
            if rowwise
                visible_trees[r, :] = BitArray(ones(size(trees[r, :])))
            else
                visible_trees[:, r] = BitArray(ones(size(trees[:, r])))
            end
            outside = false
        else
            if rowwise
                visible_trees[r, :] = visible_trees[r, :] .|| max .< trees[r, :]
            else
                visible_trees[:, r] = visible_trees[:, r] .|| max .< trees[:, r]
            end
        end
        if rowwise
            t = max .< trees[r, :]
            max[t] .= trees[r, t]
        else
            t = max .< trees[:, r]
            max[t] .= trees[t, r]
        end
    end
    return visible_trees
end

trees = readUnknownSizeMatrix("input.txt")
visible_trees = BitMatrix(zeros(size(trees)))

#top to bottom
visible_trees = find_visible(trees, visible_trees, eachindex(trees[1,:]))
#bottom to top 
visible_trees = find_visible(trees, visible_trees, reverse(eachindex(trees[1,:])))
#left to right 
visible_trees = find_visible(trees, visible_trees, eachindex(trees[:,1]), false)
#rigth to left
visible_trees = find_visible(trees, visible_trees, reverse(eachindex(trees[:,1])), false)

println("Day 8 Part 1 answer: ", count(visible_trees))

tree_scores = zeros(size(trees))

function matrix_to_coordinates(matrix)
    # Initialize an empty array to hold the coordinates
    coordinates = []
   
    for i in eachindex(matrix[:,1])
        for j in eachindex(matrix[1,:])
            push!(coordinates, (i, j))
        end
    end
    # Return the coordinates array
    return coordinates
end

addprocs(7) #overkill for input size--actually slows the program down
@everywhere p(f, trees) = x -> f(x,trees) 
@everywhere function find_score(coords, trees)
    #println("Coords ", coords)
    score = zeros(Int, 4) #1: left, 2: top, 3: right, 4: down
    height = trees[coords[1], coords[2]]
    max = height 
    #find top 
    x = coords[1] - 1
    y = coords[2]
    while x >= 1 
        if trees[x,y] < max
            score[2] += 1
        else 
            score[2] += 1
            break
        end
        x -= 1 
    end

    #find left 
    x = coords[1] 
    y = coords[2] - 1
    while y >= 1 
        if trees[x,y] < max
            score[1] += 1
        else
            score[1] += 1
            break
        end
        y -= 1 
    end

    #find bottom 
    x = coords[1] + 1
    y = coords[2] 
    while x <= size(trees)[1]
        if trees[x,y] < max
            score[4] += 1
        else
            score[4] += 1
            break
        end
        x += 1 
    end

    #find right 
    x = coords[1]
    y = coords[2] + 1
    while y <= size(trees)[2]
        if trees[x,y] < max
            score[3] += 1
        else
            score[3] += 1
            break
        end
        y += 1 
    end

    final_score = score[1] * score[2] * score[3] * score[4] 
    #println("final score for coord: ", coords, " is ", final_score )
    return final_score
end

scores = reshape(pmap(p(find_score, trees), matrix_to_coordinates(trees)), size(trees))
#find_score((3,4), trees)
println("Day 8 part 2 answer: ", findmax(scores))