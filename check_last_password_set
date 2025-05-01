#name of groups you want to check
$groups = @("GROUP1", "GROUP2")
#time in days back you want to check
$daysThreshold = 50
$thresholdDate = (Get-Date).AddDays(-$daysThreshold)

$users = foreach ($group in $groups) {
    Get-ADGroupMember -Identity $group -Recursive | Where-Object { $_.objectClass -eq "user" } |
    Get-ADUser -Properties pwdLastSet | Where-Object {
        $_.pwdLastSet -ne 0 -and ([datetime]::FromFileTimeUtc($_.pwdLastSet) -lt $thresholdDate)
    }
}

#showing in screen the list
$users | Select-Object Name, SamAccountName, @{Name="LastPasswordSet"; Expression={[datetime]::FromFileTimeUtc($_.pwdLastSet)}} |
    Format-Table -AutoSize
