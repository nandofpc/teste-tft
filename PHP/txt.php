<?php
$myfile = fopen("ns.txt", "w") or die("Unable to open file!");
$txt = "Fernando\n";
fwrite($myfile, $txt);
$txt = "Coelho\n";
fwrite($myfile, $txt);
fclose($myfile);
?>