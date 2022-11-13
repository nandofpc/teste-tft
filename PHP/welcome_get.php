<?php 

# Update DNS Record

$AMBIENTE = $_GET["hostname"]; 
$DOMAIN = "arodns.local";
$IPLBAPI = $_GET["ip"];
$COMANDO = 'Add-DnsServerResourceRecordA -Name '. $AMBIENTE; // &'-ZoneName $DOMAIN -IPv4Address $IPLBAPI';
echo '<br>';
echo $COMANDO;
//$data = (shell_exec('nslookup ' . $ambiente));
//echo $data;
?>
