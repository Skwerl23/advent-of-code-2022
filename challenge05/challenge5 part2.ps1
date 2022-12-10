$rules = cat C:\Tools\advent2022\challenge5.txt

$stacks = $rules[0..8]
$moves = $rules[10..10000]
 
foreach ($x in 1..9) {
    Set-Variable a$x -Value @()
}

foreach($x in 0..7) {
    foreach ($i in 0..8) {
        Set-Variable "a$($i+1)" -Value ((Get-Variable "a$($i+1)" -ValueOnly) + $stacks[$x][($i*4)+1])
    }
}
$answer = foreach ($x in 1..9) {
    Set-Variable a$x ((get-Variable a$x -ValueOnly)[-1..-1000] | where {$_ -match '[a-zA-Z]'})   
}

foreach ($m in $moves) {
    $m = $m.split(' ')
    $x = Get-Variable "a$($m[3])" -ValueOnly
    $y = Get-Variable "a$($m[5])" -ValueOnly
    foreach ($q in (-$m[1])..-1) {
        $y += $x[$q]
    }
    Set-Variable "a$($m[5])" -Value $y
    $x = $x[-1000..((-$m[1])-1)]
    Set-Variable "a$($m[3])" -Value $x
}
$answer = foreach ($x in 1..9) {
    (get-Variable a$x -ValueOnly)[-1]
}
$answer -join ''
