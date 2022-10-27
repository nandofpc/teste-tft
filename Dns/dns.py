#Variaveis
    key_name = input('Key_name')
    #key_secret = 
    #server = 
    #zone = 
    #record = 
    #value = 

#Entrada de dados
var_fqdn = input('Informe o FQDN: ')
var_ip = input('Informe o IP: ')

#Montagem do comando
var_comand = "update add " + var_fqdn + "86400 A " + var_ip
    
#Executando o Script
import subprocess
subprocess.run(["nsupdate", var_comand])

