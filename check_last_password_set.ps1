# Define the group names
$groups = @("GROUP1", "GROUP2")

$daysThreshold = 50
$thresholdDate = (Get-Date).AddDays(-$daysThreshold)

$users = foreach ($group in $groups) {
    # Check if the group Verifica si el group existe
    if (Get-ADGroup -Filter { Name -eq $group }) {
        Get-ADGroupMember -Identity $group -Recursive | Where-Object { $_.objectClass -eq 'user' }
    } else {
        Write-Warning "The group '$group' does not exist Active Directory."
    }
}

$users = $users | Sort-Object -Property SamAccountName -Unique

$users | ForEach-Object {
    $user = Get-ADUser -Identity $_.SamAccountName -Properties Name, SamAccountName, PasswordLastSet
    if ($user.PasswordLastSet -lt $thresholdDate) {
        [PSCustomObject]@{
            Name            = $user.Name
            SamAccountName = $user.SamAccountName
            PasswordLastSet = $user.PasswordLastSet
        }
    }
}
