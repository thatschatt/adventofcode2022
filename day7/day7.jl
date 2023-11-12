using Scanf

lines = readlines("input7.txt")

#we need to
#  1) work out the tree structure
#  2) traverse it and sum up files sizes

mutable struct dir
    name::String
    size::Int
    totalsize::Int
    subdirs::Dict{String, dir}
end

function gettree(lines)

    tree = dir("/", 0, 0, Dict())
    treepos = ["/"] #vector representing each possible choices
    for line in lines[2:end]
   #     println("line is: $line")
        if line[1] == '$'
            if line == "\$ cd .."
                pop!(treepos)
     #           println("treepos: $treepos")
            elseif line != "\$ ls" #we changed dir
                _, d = @scanf(line, "\$ cd %s", String)
                push!(treepos, d)
     #           println("treepos: $treepos")
            else #if it's an ls command
    #            println("ls") #don't actually do anything (the else tackles this)
            end
        else #if we are in a directorydump
            #first navigate to the current dir
            d = gotodir(tree, treepos)
       #     println("tree is $tree")
            if line[1] == 'd'
        #        println("dir") #we don't care about dir reports
            else
                fsize =  parse(Int, split(line, " ")[1])
                d.size += fsize
                #and now to walk up the tree adding to all the other dirs
                pd = tree
                pd.totalsize += fsize   
                for parent in (treepos[2:end])
                    pd = pd.subdirs[parent]
                    pd.totalsize += fsize    
                end

       #         println("current dir is now $d")
            end 
        end
    end
    return tree
end

function gotodir(tree, treepos)
    d = tree
    for dirs in treepos[2:end]
        try
            d = d.subdirs[dirs]
        catch # make the directory if it failed
            d.subdirs[dirs] = dir(dirs, 0, 0, Dict())
            d = d.subdirs[dirs]
        end
    end
    return d
end

#this will recursively walk through the tree looking for bigguns
function traverseforbiggies(tree::dir, sizethresh, biglist)   
    if tree.totalsize <= sizethresh
        push!(biglist, (tree.name, tree.totalsize))
    end
    for subs in tree.subdirs
        traverseforbiggies(subs[2], sizethresh, biglist)
    end
    return biglist
end

#and now to search for the smallest folder we can delete
function traverseforkillable(tree::dir, sizethresh, currentbest::dir)
    if tree.totalsize >= sizethresh
        if tree.totalsize < currentbest.totalsize
            currentbest = tree
            println("new best is $(tree.name)")
        end
    end
    for subs in tree.subdirs
        currentbest = traverseforkillable(subs[2], sizethresh, currentbest)
    end
    return currentbest
end

tree = gettree(lines)
println(tree)
println("\n*****\n")
bigs =  traverseforbiggies(tree, 100000, [])
println(bigs)
global total_s = 0
for d in bigs
    global total_s += d[2]
end

println("***\ntotal size is $total_s")

#now to work out deleting
availspace = 70000000 - tree.totalsize
neededspace = 30000000 - availspace
println("available space = $availspace")
println("needed space = $neededspace")
killfolder = traverseforkillable(tree, neededspace, tree)
println("$killfolder")
