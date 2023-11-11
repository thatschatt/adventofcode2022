sacks = readlines("test3.txt")

badsum = 0

for s in sacks
    items = collect(s)
    comp1 = items[1:Int(floor(length(items)/2))]
    comp2 = items[Int(floor(length(items)/2))+1:end]
    baditem = intersect(comp1, comp2)[1]
    if islowercase(baditem)
        priority = baditem - 'a' + 1
    else
        priority = baditem - 'A' + 27
    end

    global badsum += priority
    println("$baditem priority is $priority")

end

println("sum is $badsum")

