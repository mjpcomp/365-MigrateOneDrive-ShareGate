# This script must be run via ShareGate Powershell...
# Modify the following three variables to the approporiate setting
# The two tenant names below should be the tenantname that matches your Sharepoint Admin URL
# For example, if it's https://mysourcecompany-admin.sharepoint.com then set the first variable to "mysourcecompany"
$srcTenantName = "SOURCETENANT"
$dstTenantName = "DESTINATIONTENANT"
$csvFile = "C:\PATH\TO\CSV\UsersList.csv"

Import-Module ShareGate
$table = Import-Csv $csvFile -Delimiter ","

$srcSiteConnection = Connect-Site -Url https://$srcTenantName-admin.sharepoint.com -Browser
$dstSiteConnection = Connect-Site -Url https://$dstTenantName-admin.sharepoint.com -Browser

Set-Variable srcSite, dstSite, srcList, dstList

foreach ($row in $table) {
    Clear-Variable srcSite
    Clear-Variable dstSite
    Clear-Variable srcList
    Clear-Variable dstList
    $srcSite = Connect-Site -Url $row.SourceSite -UseCredentialsFrom $srcSiteConnection
    $dstSite = Connect-Site -Url $row.DestinationSite -UseCredentialsFrom $dstSiteConnection
    $srcList = Get-List -Site $srcSite -Name "Documents"
    $dstList = Get-List -Site $dstSite -Name "Documents"
    Copy-Content -SourceList $srcList -DestinationList $dstList
#    Copy-Site -Site $srcSite -DestinationSite $dstSite -Merge -Subsites
}
