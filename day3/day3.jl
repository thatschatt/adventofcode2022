sacks = readlines("input3.txt")

badsum = 0
badgesum = 0
elfgroup = [[], [], []]

for (n, s) in enumerate(sacks)
    items = collect(s)
    global elfgroup[(n%3) + 1] = items
    if n%3 == 0
        badge = intersect(elfgroup[1], elfgroup[2], elfgroup[3])[1]
        if islowercase(badge)
            priority_badge = badge - 'a' + 1
        else
            priority_badge = badge - 'A' + 27
        end
        global badgesum += priority_badge
        println("badge is $badge, priority is $priority_badge")
    end
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
println("badgesum is $badgesum")

