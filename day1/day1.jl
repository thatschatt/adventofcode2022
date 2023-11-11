lines = readlines("input.txt")

blanks = [0; findall(lines .== ""); length(lines)+1] #add a dud for the first, and an extra at the end
n_elves = length(blanks)-1 #there might be an off by one here, but easily fixed
rations = zeros(Int, n_elves)

for n in (1:n_elves)
    for m in (blanks[n]+1 : blanks[n+1]-1)
        rations[n] += parse(Int, lines[m])
    end
end

maximum(rations)