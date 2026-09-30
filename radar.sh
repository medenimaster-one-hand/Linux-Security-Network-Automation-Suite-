#!/bin/bash
clear
echo -e "\e[1;32m"
echo "        .---.        .-----------.     "
echo "       /     \      /           /|     "
echo "      |  V L  |    /           / |     "
echo "      |  M I  |   /           /  |     "
echo "       \     /   /           /   /     "
echo "        \`---'   '-----------'   '      "
echo -e "\e[0m"
echo -e "\e[1;36m[+] POKRETANJE RADAR & NETWORK AUDIT SYSTEM - KERNEL PRO\e[0m"
echo -e "\e[1;33m--------------------------------------------------------\e[0m"
echo -e "\e[1;34mHARDVERSKI SKEN SISTEMA:\e[0m"
echo -e " Kernel Verzija: \e[1;37m$(uname -r)\e[0m"
echo -e " Temperatura ploce: \e[1;37m19 C (Valjevo)\e[0m"
echo -e "\e[1;33m--------------------------------------------------------\e[0m"
echo -e "\e[1;34mSKENIRANJE LOKALNIH MREŽNIH INTERFEJSA (ip a):\e[0m"
ip -br a
echo -e "\e[1;33m--------------------------------------------------------\e[0m"
echo -e "\e[1;34mISPITIVANJE PROHODNOSTI KA SAMSUNG REZERVRETI (192.168.0.20):\e[0m"
ping -c 3 192.168.0.20 2>&1
echo -e "\e[1;33m--------------------------------------------------------\e[0m"
echo -e "\e[1;34mPROVERA AKTIVNIH MREŽNIH PORTA (netstat):\e[0m"
ss -tulpn | grep -E '8080|4444' || echo "Nema otvorenih netcat ventila na portovima 4444 ili 8080."
echo -e "\e[1;33m--------------------------------------------------------\e[0m"
echo -e "\e[1;34mPOKRETANJE ČIŠĆENJA SISTEMSKOG KEŠA (RAM):\e[0m"
echo "Ciscenje memorije u toku..."
sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches 
