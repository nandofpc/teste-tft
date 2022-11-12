<?php

$Parametros   = "ri2b.com.br";

$Result = Shell_Exec('powershell.exe nslookup ' . $Parametros);
    echo $Result;
echo '<br>';

$data = (shell_exec('nslookup ' . $Parametros));

echo $data;

?>
