using Scanf

lines = readlines("input4.txt")

global overlaps = 0
global overlaps2 = 0


for line in lines
    global r, a, b, c, d = @scanf(line, "%d-%d,%d-%d", Int, Int, Int, Int) 
    elf1 = a:b
    elf2 = c:d
 #   println("elf1: $elf1 elf2: $elf2")
    intrsct = intersect(elf1, elf2)
    if intrsct == elf1 || intrsct == elf2 #dirty!
        println(line)
        global overlaps += 1
    end
    if !isempty(intrsct)
        global overlaps2 += 1
    end
end

println("complete overlaps = $overlaps")
println("total overlaps = $overlaps2")