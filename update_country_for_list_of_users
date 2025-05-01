#This script has been created to update the Country attribute in a list of users
# path of the users to update the country 
$users_list = "PATH\set_country_list.txt"

# values to assign (example Ecuador, you need to look into which values do you need for your country)
$countryCode = 218
$countryName = "Ecuador"
$countryCodeAlpha = "EC"

# Read all users in the list
$users_to_update = Get-Content -Path $users_list

# Iterate each user in the list and update the Contry attributes
foreach ($samAccountName in $users_to_update) {
    try {
        # get the user object
        $user_to_update = Get-ADUser -Filter "samAccountName -eq '$samAccountName'" -Properties CountryCode, co, c

        if ($user_to_update) {
            # Updating countryCode, co y c attibrutes
            Set-ADUser -Identity $user_to_update.DistinguishedName -Replace @{
                countryCode = $countryCode
                co = $countryName
                c = $countryCodeAlpha
            }
            Write-Host "countryCode, co and c attributes updated for: $samAccountName (countryCode=$countryCode, co=$countryName, c=$countryCodeAlpha)" -ForegroundColor Green
        } else {
            Write-Host "User not found: $samAccountName" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error to update the user: $samAccountName. $_" -ForegroundColor Red
    }
}
