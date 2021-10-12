# Création de la OU Administration
New-ADOrganizationalUnit -Name "Administration" -Path "DC=ASURMarieJarod,DC=local"
# Permet de ne pas activer la protection anti supression de l'OU
Get-ADOrganizationalUnit -filter "Name -eq 'Administration'" | Set-ADOrganizationalUnit  -ProtectedFromAccidentalDeletion $False
Pause

#Crée les users
New-ADUser -Name "admin_jarod" -GivenName "Jarod" -Surname "Marie" -SamAccountName "admin_jarod" -UserPrincipalName "admin_jarod@ASURMarieJarod.local" -AccountPassword (ConvertTo-SecureString -AsPlainText "admin_jm1" -Force)  -Enable $true -ChangePasswordAtLogon $true
New-ADUser -Name "admin_dtrump" -GivenName "Donald" -Surname "Trump" -SamAccountName "admin_dtrump" -UserPrincipalName "admin_dtrump@ASURMarieJarod.local" -AccountPassword (ConvertTo-SecureString -AsPlainText "admin_dt1" -Force) -Enable $true -ChangePasswordAtLogon $true
Get-ADuser -Identity "admin_jarod"
Get-ADuser -Identity "admin_dtrump"
Pause

#Crée des groupes
New-ADGroup -Name "L3_admin" -GroupScope Global 
New-ADGroup -Name "L1_admin" -GroupScope Global 

Get-ADGroup -Identity L3_admin
Get-ADGroup -Identity L1_admin
Pause

#Déplacer les users vers les groupes atitré
Add-ADGroupMember -Identity L3_admin -Members admin_jarod
Add-ADGroupMember -Identity L1_admin -Members admin_dtrump
Pause

#Deplace le groupe L1_admin vers la OU administration
Move-ADObject -Identity "CN=L1_admin,CN=Users,DC=ASURMarieJarod,DC=local" -TargetPath "OU=Administration,DC=ASURMarieJarod,DC=local"
Move-ADObject -Identity "CN=L3_admin,CN=Users,DC=ASURMarieJarod,DC=local" -TargetPath "OU=Administration,DC=ASURMarieJarod,DC=local"
Get-ADGroup -Identity L1_admin
Get-ADGroup -Identity L3_admin
Pause

#Deplace le groupe L3_admin vers le groupe Admins du domaine
Add-ADGroupMember -Identity "Admins du domaine" -Members L3_admin 
Get-ADGroup -Identity L3_admin
Pause