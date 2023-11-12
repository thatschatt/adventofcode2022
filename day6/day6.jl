lines = readlines("input6.txt")

function getmarker(line, mlength)
    last4 = [' ' for n in 1:mlength]
    for (n, c) in enumerate(line)
        prepend!(last4, c)
        pop!(last4)
        if sort(unique(last4)) == sort(last4) && n>mlength
            println(last4)
            return n
        end
    end 
    return -1
end

for line in lines
    println(getmarker(line, 14))
end