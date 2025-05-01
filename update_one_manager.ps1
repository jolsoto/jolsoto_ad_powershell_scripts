# path of list.txt with the sAMAccountName of users what you need to update the specific
$users_list = "PATH\list.txt"

# distinguishedName of Manager
$managerDN = "CN=Example Manager,OU=DEPARTMENT1,OU=PICHINCHA,OU=USERS,DC=example,DC=com"

# read the users in the list to update
$users_to_update = Get-Content -Path $users_list

# iterate each user and update the "Manager" attribute
foreach ($samAccountName in $users_to_update) {
    try {
        # get the object user
        $users_to_update = Get-ADUser -Filter "samAccountName -eq '$samAccountName'" -Properties Manager

        if ($users_to_update) {
            # set up the manager
            Set-ADUser -Identity $users_to_update.DistinguishedName -Manager $managerDN
            Write-Host "Manager updated for user: $samAccountName (Manager=$managerDN)" -ForegroundColor Green
        } else {
            Write-Host "User not found: $samAccountName" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error to update the manager attribute for the user: $samAccountName. $_" -ForegroundColor Red
    }
