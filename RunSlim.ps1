$RunningArray = @()
$CSV = Import-Csv .\List.csv

For($idx = 0; $idx -lt $CSV.Count; $idx++) {
    If($CSV[$idx].operations -lt 3){
        $Temp = $CSV[$idx].Subject
        $RunningArray += $Temp
        Write-Host "DEBUG: $($CSV[$idx].Subject) was added"
    }Else{
        Write-Host "$($CSV[$idx].Subject) has been used too much."
    }
}

$Result = $RunningArray[$(Get-Random -Maximum $RunningArray.Count)]
Write-Host "Random Result: $Result"
For($ID = 0; $ID -lt $CSV.Count; $ID++){
    If($Result -eq $Csv[$ID].Subject){
        Write-Host "DEBUG: Result Equals Array"
        $Temp = [int]$Csv[$ID].operations
        $Temp++
        $CSV[$ID].operations = $Temp
    }
}
$Csv | Export-Csv .\List.csv
Pause