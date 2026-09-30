#!/bin/bash

# Provera root prava (da bi skeniranje hardvera prošlo kako treba)
if [ "$EUID" -ne 0 ]; then
    echo -e "\e[1;31m[-] Greška: Ovaj audit modul zahteva sudo privilegije!\e[0m"
    echo "Pokreni ponovo sa: sudo ./radar_audit.sh"
    exit 1
fi

prikazi_audit_meni() {
    clear
    echo -e "\e[1;35m========================================================\e[0m"
    echo -e "\e[1;33m       ⚡ SYSTEM BLUEPRINT & HARDWARE AUDIT ⚡\e[0m"
    echo -e "\e[1;35m========================================================\e[0m"
    echo -e " 1) \e[1;36mPROCESOR AUDIT\e[0m  - Detaljan scan CPU arhitekture i jezgara"
    echo -e " 2) \e[1;36mMEMORY & DISK\e[0m   - Rentgen particija, RAM-a i zauzeća"
    echo -e " 3) \e[1;36mPCI & USB GRAPH\e[0m - Popis matične ploče, grafike i periferija"
    echo -e " 4) \e[1;32mPovratak u glavni meni\e[0m"
    echo -e "\e[1;35m========================================================\e[0m"
}

while true; do
    prikazi_audit_meni
    read -p "Izaberite opciju (1-4): " opcija
   
    case $opcija in
        1)
            echo -e "\n\e[1;34m[+] Pokrećem CPU audit...\e[0m"
            echo "--------------------------------------------------------"
            lscpu | grep -E "Model name|Architecture|CPU(s):|Thread(s) per core|Core(s) per socket|BogoMIPS|Virtualization"
            echo "--------------------------------------------------------"
            read -p "Pritisnite [Enter] za nazad..."
            ;;
        2)
            echo -e "\n\e[1;34m[+] Skeniram skladište i operativnu memoriju...\e[0m"
            echo "--------------------------------------------------------"
            echo -e "\e[1;33m--- ZAUZEĆE RAM MEMORIJE ---\e[0m"
            free -h
            echo ""
            echo -e "\e[1;33m--- PREGLED DISKOVA I PARTICIJA ---\e[0m"
            df -h -x devtmpfs -x tmpfs
            echo "--------------------------------------------------------"
            read -p "Pritisnite [Enter] za nazad..."
            ;;
        3)
            echo -e "\n\e[1;34m[+] Popisujem hardverske kontrolere (PCI/USB)...\e[0m"
            echo "--------------------------------------------------------"
            echo -e "\e[1;33m--- GRAFIČKA KARTA & AUDIO ---\e[0m"
            lspci | grep -E "VGA|Audio|Network|Ethernet"
            echo ""
            echo -e "\e[1;33m--- AKTIVNI USB UREĐAJI ---\e[0m"
            lsusb
            echo "--------------------------------------------------------"
            read -p "Pritisnite [Enter] za nazad..."
            ;;
        4)
            echo -e "\n[+] Zatvaram audit dnevnik. Povratak..."
            exit 0
            ;;
        *)
            echo -e "\n\e[1;31m[-] Nevažeća opcija!\e[0m Izaberite broj od 1 do 4."
            sleep 2
            ;;
    esac
done
