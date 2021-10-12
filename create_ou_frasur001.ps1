#Crée les users
New-ADUser -Name "admin_jarod.FR" -GivenName "Jarod" -Surname "Marie" -SamAccountName "admin_jarod" -UserPrincipalName "admin_jarod@fr.ASURMarieJarod.local" -AccountPassword (ConvertTo-SecureString -AsPlainText "admin_jm1" -Force)  -Enable $true -ChangePasswordAtLogon $true
New-ADUser -Name "admin_dtrump.FR" -GivenName "Donald" -Surname "Trump" -SamAccountName "admin_dtrump" -UserPrincipalName "admin_dtrump@fr.ASURMarieJarod.local" -AccountPassword (ConvertTo-SecureString -AsPlainText "admin_dt1" -Force) -Enable $true -ChangePasswordAtLogon $true
Get-ADuser -Identity "admin_jarod.FR"
Get-ADuser -Identity "admin_dtrump.FR"
Pause

#Crée des groupes
New-ADGroup -Name "L3_admin" -GroupScope Global 
New-ADGroup -Name "L1_admin" -GroupScope Global 

Get-ADGroup -Identity L3_admin
Get-ADGroup -Identity L1_admin
Pause

#Déplacer les users vers les groupes atitré
Add-ADGroupMember -Identity L3_admin -Members admin_jarod.FR
Add-ADGroupMember -Identity L1_admin -Members admin_dtrump.FR
Pause

#Deplace le groupe L1_admin vers la OU administration
Move-ADObject -Identity "CN=L1_admin,CN=Users,DC=fr,DC=ASURMarieJarod,DC=local" -TargetPath "OU=Administration,DC=fr,DC=ASURMarieJarod,DC=local"
Move-ADObject -Identity "CN=L3_admin,CN=Users,DC=fr,DC=ASURMarieJarod,DC=local" -TargetPath "OU=Administration,DC=fr,DC=ASURMarieJarod,DC=local"
Get-ADGroup -Identity L1_admin
Get-ADGroup -Identity L3_admin
Pause

#Deplace le groupe L3_admin vers le groupe Admins du domaine
Add-ADGroupMember -Identity "Admins du domaine" -Members L3_admin 
Get-ADGroup -Identity L3_admin
Pause