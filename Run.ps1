Function MenuCreate {
    #Creates a main menu that detects userID's existance and also displays it. 
    Write-Host "Pick An Option"
    Write-Host "1: Select Random Subject"
    Write-Host "2: Reset List"
    Write-Host "Q: Please hit 'Q' to quit"
}
Function GetRandom {
    $RunningArray = @()
    $CSV = Import-Csv .\List.csv

    For($idx = 0; $idx -lt $CSV.Count; $idx++) {
        If($CSV[$idx].operations -lt 3){
            $Temp = $CSV[$idx].Subject
            $RunningArray += $Temp
            Write-Host "DEBUG: $($CSV[$idx].Subject) was added"
        }Else{
            Write-Host "$($CSV[$idx].Subject) has been used too much." -Foregroundcolor Yellow
        }
    }
    $Result = $RunningArray[$(Get-Random -Maximum $RunningArray.Count)]
    Write-Host "Random Result: $Result" -Foregroundcolor Blue
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
}
Function OperationReset {
    $CSV = Import-Csv .\List.csv

    For($idx = 0; $idx -lt $CSV.Count; $idx++) {
        $Temp = $CSV[$idx].Operations
        $Temp = 0
        $Csv[$idx].operations = $Temp
    }


    $Csv | Export-Csv .\List.csv
}

While($true) {
    Clear-Host
    MenuCreate
    $Selection = Read-Host "Please make a selection"
    switch ($Selection) {
        '1' { GetRandom }
        '2' { OperationReset }
        'q' {
            write-Host 'Hope we could help!'
            Return
        }
    }
}
