$sort = Import-Csv -Header "Process", "Execution_Time" -delimiter ',' sort.csv
$sort | % { $_.Execution_Time = [int]$_.Execution_Time }
$sorting = $sort | Sort-Object Execution_Time
Out-file -FilePath "$pwd\sortdata.txt" -InputObject $sorting -Encoding ascii