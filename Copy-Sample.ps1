Import-Module ShareGate
$csvFile = "C:\CSV\CopySites.csv"
$table = Import-Csv $csvFile -Delimiter ","

$srcSiteConnection = Connect-Site -Url https://.sharepoint.com/ -Browser
$dstSiteConnection = Connect-Site -Url https://.sharepoint.com/ -Browser

Set-Variable srcSite, dstSite

foreach ($row in $table) {
    Clear-Variable srcSite
    Clear-Variable dstSite
    $srcSite = Connect-Site -Url $row.SourceSite -UseCredentialsFrom $srcSiteConnection
    $dstSite = Connect-Site -Url $row.DestinationSite -UseCredentialsFrom $dstSiteConnection
    Copy-Site -Site $srcSite -DestinationSite $dstSite -Merge -Subsites
}
