#!/usr/bin/python3
#Entrada de dados
#Variaveis
var_ip=''
var_name=''
var_zona=''

# Montagem do comando
# var_comand = "update add " + var_fqdn + "86400 A " + var_ip
var_comand = '\nupdate add {}.{} 86400 A {}'.format(var_name, var_zona, var_ip)
# gravando o arquivo ns.txt
lines = ['server 10.222.70.22\n', 'zone ', var_zona, var_comand, '\nsend\nquit']
with open('ns.txt', 'w') as f:
    for line in lines:
        f.write(line)
        # f.write('\n')
# Executando o Script
subprocess.run(['nsupdate', 'ns.txt'])