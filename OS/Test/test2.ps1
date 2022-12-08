$p = 15,8,2,5
$array=@()
cls
$j=0
$ts = Read-Host -Prompt 'Input Time Slice'
# write-host "타임슬라이스 $ts"
for (($i=0); $i -lt 4; $i++) {
    $e=$p[$i] % $ts
    $c=$p[$i] / $ts
    if ($e -gt 0) {
        $temp = echo("$c").split(".")[0]
        $value = [int]$temp
        $qt = $value+1
    } else {
        $qt = $c
    }
    $array+=$qt
    write-host "P$i` 실행시간이" $p[$i]"초며, 타임 슬라이스 $ts 가 적용되면 수행 횟수는 $qt 이다."
}
$arrayt=$array[0]+$array[1]+$array[2]+$array[3]
$i=0
for(($i=0), ($j=0); $i -le $arrayt; $i++) {
    $j++
    
    if ($j -ge 4) { $j = 1 }
    if ($ttp -ne 0) {
       # write-host "P$j 프로세스 실행"
    }
    $ttp=$array[$j]-1
    write-host $ttp
}