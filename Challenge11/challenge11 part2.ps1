﻿
$data = cat C:\tools\advent2022\challenge11.txt

$dataguys = 7


$worrydivisor = 1
    foreach ($num in 0..$dataguys) {
        
        $monkey[$num] = ($data[7*$num+1],$data[7*$num+2],$data[7*$num+3],$data[7*$num+4],$data[7*$num+5])
        $monkey[$num][0] = $monkey[$num][0].split(':').trim().split(',').trim()[1..50]
        $monkey[$num][1] = $monkey[$num][1].split()[-2..-1]
        $monkey[$num][2] = $monkey[$num][2].split()[-1]
        $monkey[$num][3] = $monkey[$num][3].split()[-1]
        $monkey[$num][4] = $monkey[$num][4].split()[-1]
        $worrydivisor *= [int]$monkey[$num][2]
    }
    $worrydivisor
    $monkeyInspections = @{}
    $round = 0

#foreach ($i in 2..1000) {
    foreach ($round in 1..10000) {
        foreach ($guy in 0..$dataguys) {
            
            foreach ($item in $monkey[$guy][0]) {
                $monkeyInspections[$guy]+=1
                if ($item -eq 0) {continue}
                $worry = [double]$item 
                if ($monkey[$guy][1][1] -eq "OLD") {
                    $worry = [double]$item * [double]$item
                }
                elseif ($monkey[$guy][1][0] -eq "*") {
                    $worry = [double]$item * [double]$monkey[$guy][1][1] 
                }
                elseif ($monkey[$guy][1][0] -eq "+") {
                    $worry = [double]$item + [double]$monkey[$guy][1][1]
                }

                $worry = [double]$worry % $worrydivisor
                $monkey[$guy][0] = $monkey[$guy][0] | where {$_ -notmatch $item}
                if ($worry % [int]$monkey[$guy][2] -eq 0) {
                    $newmonkey = $monkey[$guy][3]
                }            
                else {
                    $newmonkey = $monkey[$guy][4]
                }
                
                [string[]]$monkey[$newmonkey][0] += $worry
                
 
            }
        }
}  
    $ans  = $monkeyInspections.GetEnumerator() | sort value -Descending | select -first 2
    $ans# | where value -match 103

    $total = [double]$ans.value[0]*$ans.value[1] 

    $total

#}