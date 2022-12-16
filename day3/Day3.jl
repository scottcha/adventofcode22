function badge_priority(badge)
    if(badge >= 97)
        return badge - 96
    else
        return badge - 65 + 27
    end
end

open("input.txt") do f
    score = 0
    score2 = 0
    elf_counter = 0
    e1 = Set 
    e2 = Set 
    e3 = Set 
    while !eof(f)
        s = readline(f)

        #part 1
        size = Int(length(s) / 2)
        c1 = SubString(s, 1, size)
        c2 = SubString(s, size + 1, length(s))

        badge = Int(pop!(intersect(Set(c1), Set(c2))))
        score += badge_priority(badge)        

        #part 2
        if elf_counter == 0
            e1 = Set(s)
            elf_counter += 1
        elseif elf_counter == 1
            e2 = Set(s)
            elf_counter += 1
        elseif elf_counter == 2
            e3 = Set(s)
            badge = Int(pop!(intersect(e1, e2, e3)))
            score2 += badge_priority(badge)
            elf_counter = 0
        else
            println("Error, shouldn't be here")
        end
    end
    println("Day 3 part 1 answer: ", score)
    println("Day 3 part 2 answer: ", score2)
end