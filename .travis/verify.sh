#!/bin/bash

set -o errexit

install_demo(){
    ./bin/demosite.sh
}

verify_lsws(){
    curl -sIk http://localhost:7080/ | grep -i LiteSpeed
    if [ ${?} = 0 ]; then
        echo '[O]  https://localhost:7080/'
    else
        echo '[X]  https://localhost:7080/'
        exit 1
    fi          
}    

verify_page(){
    curl -sik http://localhost:80/ >/dev/null 2>&1
    curl -sIk http://localhost:80/ | grep -I litemage
    if [ ${?} = 0 ]; then
        echo '[O]  http://localhost:80/' 
    else
        echo '[X]  http://localhost:80/'
        exit 1
    fi
    curl -sik https://localhost:443/ >/dev/null 2>&1
    curl -sIk https://localhost:443/ | grep -I litemage
    if [ ${?} = 0 ]; then
        echo '[O]  https://localhost:443/' 
    else
        echo '[X]  https://localhost:443/'
        exit 1
    fi       
}

verify_phpadmin(){
    curl -sIk http://localhost:8080/ | grep -i phpMyAdmin
    if [ ${?} = 0 ]; then
        echo '[O]  http://localhost:8080/' 
    else
        echo '[X]  http://localhost:8080/'
        exit 1
    fi      
    curl -sIk https://localhost:8443/ | grep -i phpMyAdmin
    if [ ${?} = 0 ]; then
        echo '[O]  http://localhost:8443/' 
    else
        echo '[X]  http://localhost:8443/'
        exit 1
    fi      
}

main(){
    verify_lsws
    verify_phpadmin
    install_demo
    verify_page
}
main