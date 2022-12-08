$p = 0,15,8,2,5
$time_slice = Read-Host -Prompt 'Input Time Slice'
for (($i=1); $i -le 4; $i++) {
   # write-host $p[$i]
}
cls
write-host "Time Slice = " $time_slice
for (($i=1); $i -le 4; $i++) {
    $ta = $p[$i] / $time_slice
    if ($ta -lt 1.4) { # ta 가 1보다 작거나 같을때
        if ($ta -lt 0.5) { # ta 가 0.4보다 작거나 같을때
            $ta = 1
        } 
        if($ta -ge 1.5) { # ta 가 1보다
            $ta = 2
        }
    }
    write-host $ta
    $ta=[math]::Round($ta)
    write-host $i = $ta "P$i = " $p[$i]
}