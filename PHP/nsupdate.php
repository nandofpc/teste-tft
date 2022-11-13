<?php 

# Update DNS Record
// nsupdate server 172.16.1.5 zona ardns.local pdate add leon.arodns.local. 86400 A 172.16.1.50
$AMBIENTE = $_GET["hostname"];
$SERVIDOR = '172.16.1.5';
$DOMAIN = "arodns.local";
$IPLBAPI = $_GET["ip"];

//Montando o arquivo txt

$myfile = fopen("ns.txt", "w") or die("Unable to open file!");
$txt = "server ". $SERVIDOR. "\n";
fwrite($myfile, $txt);
$txt = "zone ". $DOMAIN. "\n";
fwrite($myfile, $txt);
$txt = "update add ". $AMBIENTE. '.' . $DOMAIN. ' 86400 A ' . $IPLBAPI. "\n";
fwrite($myfile, $txt);
$txt = "send\n";
fwrite($myfile, $txt);
$txt = "quit\n";
fwrite($myfile, $txt);
fclose($myfile);

//$COMANDO = 'Add-DnsServerResourceRecordA -Name '. $AMBIENTE . ' -ZoneName '. $DOMAIN . ' -IPv4Address '. $IPLBAPI;
$COMANDO = 'nsupdate server '. $SERVIDOR . ' zone '. $DOMAIN . ' update add ' . $AMBIENTE. '.' . $DOMAIN . ' 86400 A ' . $IPLBAPI;
echo '<br>';
//$data = (shell_exec('pwsh ' . $COMANDO));
$data = (shell_exec($COMANDO));
echo $COMANDO;
echo '<br>';
echo $data
?>