# Création de la OU Administration
New-ADOrganizationalUnit -Name "Comptabilité"   -Path "DC=fr,DC=ASURMarieJarod,DC=local"
New-ADOrganizationalUnit -Name "Ordinateurs"    -Path "DC=fr,DC=ASURMarieJarod,DC=local"
New-ADOrganizationalUnit -Name "Administration" -Path "DC=fr,DC=ASURMarieJarod,DC=local"
New-ADOrganizationalUnit -Name "Direction"      -Path "DC=fr,DC=ASURMarieJarod,DC=local"
New-ADOrganizationalUnit -Name "Serveurs"       -Path "DC=fr,DC=ASURMarieJarod,DC=local"
New-ADOrganizationalUnit -Name "Filers"         -Path "DC=fr,DC=ASURMarieJarod,DC=local"
Pause

# Permet de ne pas activer la protection anti supression de l'OU
Get-ADOrganizationalUnit -filter "Name -eq 'Comtabilité'"    | Set-ADOrganizationalUnit  -ProtectedFromAccidentalDeletion $False
Get-ADOrganizationalUnit -filter "Name -eq 'Ordinateurs'"    | Set-ADOrganizationalUnit  -ProtectedFromAccidentalDeletion $False
Get-ADOrganizationalUnit -filter "Name -eq 'Administration'" | Set-ADOrganizationalUnit  -ProtectedFromAccidentalDeletion $False
Get-ADOrganizationalUnit -filter "Name -eq 'Direction'"      | Set-ADOrganizationalUnit  -ProtectedFromAccidentalDeletion $False
Get-ADOrganizationalUnit -filter "Name -eq 'Serveurs'"       | Set-ADOrganizationalUnit  -ProtectedFromAccidentalDeletion $False
Get-ADOrganizationalUnit -filter "Name -eq 'Filers'"         | Set-ADOrganizationalUnit  -ProtectedFromAccidentalDeletion $False
Pause

#Déplacer les OU Ordinateurs vers Comptabilité et Filers vers Serveurs
Move-ADObject -Identity "OU=Ordinateurs,DC=fr,DC=ASURMarieJarod,DC=local" -TargetPath "OU=Comptabilité,DC=fr,DC=ASURMarieJarod,DC=local"
Move-ADObject -Identity "OU=Filers,DC=fr,DC=ASURMarieJarod,DC=local" -TargetPath "OU=Serveurs,DC=fr,DC=ASURMarieJarod,DC=local"
Pause