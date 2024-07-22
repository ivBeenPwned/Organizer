$DstPath="$env:USERPROFILE\Downloads\"
$Files=(ls -Path $DstPath -Exclude (ls -Path $DstPath -Directory)).Name
$Ext=(ls -Path $DstPath -Exclude (ls -Path $DstPath -Directory)).Extension
$x=0

foreach (
    $i in $Ext | Sort-Object -Unique){
        if (Test-Path "$DstPath\$i") {Continue}
        else {New-Item -Path $DstPath -ItemType Directory -Name "$i"; Write-Output "Diretório $i Criado"}
}

foreach (
        $i in $Files){$dir = (ls "$DstPath\$i").Extension
            try {Move-Item -Path "$DstPath\$i" -Destination "$DstPath\$dir" -ErrorAction Stop}
            catch{do {
                ++$x
                $NewName=[System.IO.Path]::GetFileNameWithoutExtension("$DstPath\$i")+" "+"($x)"+((ls "$DstPath\$i").Extension)
                if (-not (Test-Path -Path "$DstPath\$dir\$NewName")){
                    Rename-Item -Path "$DstPath\$i" -NewName "$DstPath\$NewName"
                    Move-Item -Path "$DstPath\$NewName" -Destination "$DstPath\$dir"
                    break
                    }
        } while ($true)
    }
}
