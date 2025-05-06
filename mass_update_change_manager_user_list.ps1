# Input file path
$usersList = "PATH\users_to_update.csv"

# Read the users and managers from the CSV file with the correct encoding
$users = Import-Csv -Path $usersList -Encoding UTF8

# Iterate through each row and update the manager field
foreach ($row in $users) {
    $samAccountName = $user.row
    $managerDN = $user_manager.row

    try {
        # Check that the values ​​are not empty
        if (-not [string]::IsNullOrEmpty($samAccountName) -and -not [string]::IsNullOrEmpty($managerDN)) {
            # Get the user object
            $user = Get-ADUser -Filter "samAccountName -eq '$samAccountName'" -Properties Manager

            if ($user) {
                # Assign the manager
                Set-ADUser -Identity $user.DistinguishedName -Manager $managerDN
                Write-Host "Updated manager for: $samAccountName (Manager=$managerDN)" -ForegroundColor Green
            } else {
                Write-Host "User not found: $samAccountName" -ForegroundColor Yellow
            }
        } else {
            Write-Host "Empty values ​​found for user: $samAccountName o manager: $managerDN" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error updating the manager for the user: $samAccountName. $_" -ForegroundColor Red
    }
}
