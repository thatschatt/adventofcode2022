using Scanf

lines = readlines("input5.txt")
nstacks = 9 #change for input2

function loadstacks(lines)
    stacks = [[] for _ in 1:nstacks]
    n_line = 0
    for (nline, line) in enumerate(lines)
        if !contains(line, '[')
            n_line = nline
            break
        end
        for n in 0:(nstacks-1)
            c = line[n*4+2]
            if c != ' '
                push!(stacks[n+1], c)
 #               println("$(c)")
            end
        end
    end
    #reverse the stacks
    for n in 1:nstacks
        reverse!(stacks[n])
    end

    return (stacks, n_line)
end

function movestacks!(stacks, lines, startline)
    for line in lines[startline+2:end]
        _, n, from, to = @scanf(line, "move %d from %d to %d", Int, Int, Int)
 #       println("move $n from $from to $to")
        for i in 1:n
            push!(stacks[to], pop!(stacks[from]))
        end 
    end
end

function movestacks_9001!(stacks, lines, startline)
    for line in lines[startline+2:end]
        _, n, from, to = @scanf(line, "move %d from %d to %d", Int, Int, Int)
        println("$stacks")
        println("move $n from $from to $to")
        stacks[to] = cat(stacks[to], stacks[from][end-n+1:end], dims=1)
        [pop!(stacks[from]) for _ in 1:n]
    end
end

stacks, endline = loadstacks(lines)
movestacks_9001!(stacks, lines, endline)
print("\n\n")
for n in 1:nstacks
    print("$(stacks[n][end])")
end
println("")

println("$stacks")