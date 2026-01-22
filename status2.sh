#!/bin/bash

server_name=$(hostname)

function memory_check(){
    echo ""
    echo "The current memory usage on server ${server_name} is:"
    free -h
    echo ""
}

function cpu_check(){
    echo ""
    echo "The current CPU load on server ${server_name} is:"
    echo ""
    uptime
    echo ""
}

function tcp_check(){
    echo ""
    echo "TCP connections on ${server_name} are:"
    echo ""
    cat /proc/net/tcp
}

function kernel_check(){
    echo ""
    echo "The current kernel version on ${server_name} is:"
    uname -r
    echo ""
}

function uptime_check(){
    echo ""
    echo "The system uptime on ${server_name} is:"
    uptime -p
    echo ""
}

function disk_check(){
    echo ""
    echo "Disk usage on ${server_name} is:"
    df -h | grep -E '^Filesystem|/$'
    echo ""
}

function ip_check(){
    echo ""
    echo "The IP addresses assigned to ${server_name} are:"
    echo "Local IP: $(hostname -I | awk '{print $1}')"
    echo "Public IP: $(curl -s ifconfig.me)"
    echo ""
}

function all_checks(){
    memory_check
    cpu_check
    tcp_check
    kernel_check
    uptime_check
    disk_check
    ip_check
}

##
# Color Variables
##
green='\e[32m'
blue='\e[34m'
red='\e[31m'
clear='\e[0m'

## 
#  Color Function
##

ColorGreen(){
    echo -ne $green$1$clear
}
ColorBlue(){
    echo -ne $blue$1$clear
}

menu(){
echo -ne "
My First Menu
$(ColorGreen '1)') Memory usage
$(ColorGreen '2)') CPU Load
$(ColorGreen '3)') Number of TCP connections
$(ColorGreen '4)') Kernel Version
$(ColorGreen '5)') System Uptime
$(ColorGreen '6)') Disk Space
$(ColorGreen '7)') IP Address
$(ColorGreen '8)') Check All
$(ColorBlue 'Choose an option: ') "
        read a
        case $a in
                1) memory_check ; menu ;;
                2) cpu_check ; menu ;;
                3) tcp_check ; menu ;;
                4) kernel_check ; menu ;;
                5) uptime_check ; menu ;;
                6) disk_check ; menu ;;
                7) ip_check ; menu ;;
                8) all_checks ; menu ;;
                0) exit 0 ;;
                *) echo -e "${red}Wrong option.${clear}"; menu
;;
       esac
}

menu