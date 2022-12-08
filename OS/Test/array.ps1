$arr = get-content "$pwd\exec.dat"
[int[]]$sort = $arr[0], $arr[1], $arr[2], $arr[3]
$list = $sort | sort
$Com = $null
$j=0
for ($i=0; $i -lt $list.Count; $i++) {
    $j++
    if ($list[0] -eq $arr[$i]) {
       write-host P$j $arr[$i] 1 
       $Com += "" + $j + " " + $arr[$i] + " " + 1 + "`n"
    }
    if ($list[1] -eq $arr[$i]) {
        write-host P$j $arr[$i] 2 
        $Com += "" + $j + " " + $arr[$i] + " " + 2 + "`n"
    }
    if ($list[2] -eq $arr[$i]) {
        write-host P$j $arr[$i] 3 
        $Com += "" + $j + " " + $arr[$i] + " " + 3 + "`n"
    }
    if ($list[3] -eq $arr[$i]) {
        write-host P$j $arr[$i] 4 
        $Com +="" +  $j + " " + $arr[$i] + " " + 4 + "`n"
    }
}
cls
write-host $com -ForegroundColor red
#out-file -FilePath "$pwd\process.txt" -InputObject $com -Encoding Ascii
