#!/usr/bin/python3
import subprocess, sys
#Função linhas
def linha(tam=42):
    return '-'*tam

#Função cabeçalho
def cabeçalho(txt):
    print(linha())
    print(txt.center(42))
    print(linha())

#Função do menu de opções
cabeçalho('Menu de opções')
def menu(lista):
    c = 1
    for item in lista:
        print(f'{c} - {item}')
        c += 1

menu(['corpp.brad', 'arodns.local', 'sair'])
opc = int(input('Digita sua opção: '))

if opc == 1:
    print('Zona escolhida corpp.brad:')
    var_zona = 'corpp.brad'
    var_ip = input('Informe o IP: ')
    var_name = input('Informe o nome do host:')
    var_nslook = var_name + '.' + var_zona
    var_resultado = subprocess.run(['nslookup', var_nslook]).returncode
    if var_resultado == 1:
        # Montagem do comando
        # var_comand = "update add " + var_fqdn + "86400 A " + var_ip
        var_comand = '\nupdate add {}.{} 86400 A {}'.format(var_name, var_zona, var_ip)
        # gravando o arquivo ns.txt
        lines = ['server 172.16.1.5\n', 'zone ', var_zona, var_comand, '\nsend\nquit']
        with open('ns.txt', 'w') as f:
            for line in lines:
             f.write(line)
             # f.write('\n')
        # Executando o Script
        subprocess.run(['nsupdate', 'ns.txt'])
        cabeçalho('Fim')
    else:
        print('Host já registrado')
        exit()

elif opc == 2:
    print('Zona escolhida arodns.local')
    var_zona = 'arodns.local'
    var_ip = input('Informe o IP: ')
    var_name = input('Informe o nome do host:')
    var_nslook = var_name + '.' + var_zona
    var_resultado = subprocess.run(['nslookup', var_nslook]).returncode
    if var_resultado == 0:
        # Montagem do comando
        # var_comand = "update add " + var_fqdn + "86400 A " + var_ip
        var_comand = '\nupdate add {}.{} 86400 A {}'.format(var_name, var_zona, var_ip)
        # gravando o arquivo ns.txt
        lines = ['server 172.16.1.5\n', 'zone ', var_zona, var_comand, '\nsend\nquit']
        with open('ns.txt', 'w') as f:
            for line in lines:
                f.write(line)
                # f.write('\n')
        # Executando o Script
        subprocess.run(['nsupdate', 'ns.txt'], stderr=None)
        cabeçalho('Fim')
    else:
        print('Host já registrado')
        exit()

elif opc == 3:
    print('Encerrando')
    cabeçalho('Fim')
    exit()
else:
    print('Opção invalida.')
