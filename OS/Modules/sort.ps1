# Priority Scheduling Sorting Scripts

# sort.csv 데이터를 담고있는 $sort 변수에 Process, Execution_Time 헤더 추가
$sort = Import-Csv -Header "Process", "Execution_Time" -delimiter ',' sort.csv 

# Execution_Time 헤더를 정수형으로 변환
$sort | % { $_.Execution_Time = [int]$_.Execution_Time }

# Execution_Time 헤더 오름차순 정렬 후 $sorting 변수에 저장
$sorting = $sort | Sort-Object Execution_Time

# $sorting 데이터가 $pwd\ = 현재 폴더, sortdata.txt = 저장 파일,에 ascii 인코딩으로 저장됨
Out-file -FilePath "$pwd\sortdata.txt" -InputObject $sorting -Encoding ascii
