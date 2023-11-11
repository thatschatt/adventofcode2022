using Printf

rounds = readlines("input2.txt")

values = Dict('A' => 1, 'B' => 2, 'C' => 3,
            'X' => 1, 'Y' => 2, 'Z' => 3) #score for each move

#  R  P  S 
#R
#P
#S
winmat = [3 6 0;
          0 3 6;
          6 0 3] #my scores a a function of our choices

function getscore(rounds)
    rpsscore = 0
    for r in rounds
        op = values[r[1]]
        me = values[r[3]]
        rpsscore += me + winmat[op, me]
    end
    return rpsscore
end

println("score 1 is $(getscore(rounds))")

## part 2
#  L  D  W 
#R S  R  P 
#P R  P  S
#S P  S  R

scoremat = [3 4 8;
            1 5 9;
            2 6 7] #my scores a a function of our choices

function getscore2(rounds)
    rpsscore = 0
    for r in rounds
        op = values[r[1]]
        me = values[r[3]]
   #     println(scoremat[op, me])
        rpsscore += scoremat[op, me]
    end
    return rpsscore
end

println("score 2 is $(getscore2(rounds))")