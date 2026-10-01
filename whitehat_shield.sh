#!/bin/bash

# ==============================================================================
# PREMIUM LINUX SECURITY & NETWORK AUTOMATION SUITE (PRO) - v2.0
# Developed by: medeni_whitehat
# ==============================================================================

# Boje za vizuelni semafor
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0;37m' # Resetovanja boje

echo -e "${BLUE}=====================================================${NC}"
# Uspostavljanje naslova
echo -e "${BLUE}    PREMIUM LINUX SECURITY SUITE v2.0 - STARTING     ${NC}"
echo -e "${BLUE}=====================================================${NC}"

# 1. FUNKCIJA: Sajber-Katanac za UFW požarni zid
echo -e "\n${YELLOW}[*] Aktivacija funkcije: Sajber-Katanac za UFW...${NC}"
if command -v ufw &> /dev/null; then
    # Resetovanje i osnovno zaključavanje
    sudo ufw --force reset > /dev/null
    sudo ufw default deny incoming > /dev/null
    sudo ufw default allow outgoing > /dev/null
   
    # Otvaranje samo sigurnih portova (SSH, HTTP, HTTPS)
    sudo ufw allow 22/tcp comment 'SSH Secure' > /dev/null
    sudo ufw allow 80/tcp comment 'HTTP Web' > /dev/null
    sudo ufw allow 443/tcp comment 'HTTPS Secure Web' > /dev/null
   
    # Omogućavanje UFW-a
    echo "y" | sudo ufw enable > /dev/null
    echo -e "${GREEN}[V] USPEH: Sajber-Katanac je zaključao UFW! Otvoreni portovi: 22, 80, 443.${NC}"
else
    echo -e "${RED}[X] GREŠKA: UFW nije instaliran na sistemu!${NC}"
fi

# 2. FUNKCIJA: Sistemski bekap sa automatskim pakovanjem arhive
echo -e "\n${YELLOW}[*] Pokretanje sistemskog bekapa...${NC}"
BACKUP_DIR="$HOME/Documents/Backups"
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/system_backup_$TIMESTAMP.tar.gz"

# Pakovanje konfiguracionog foldera /etc (primer važnih podataka)
if sudo tar -czf "$BACKUP_FILE" /etc 2>/dev/null; then
    echo -e "${GREEN}[V] USPEH: Automatska arhiva je spakovana u:${NC}"
    echo -e "${BLUE}    $BACKUP_FILE${NC}"
else
    echo -e "${RED}[X] GREŠKA: Bekap nije uspeo zbog administratorskih prava.${NC}"
fi

# 3. FUNKCIJA: Vizuelni semafor za potrošnju memorije
echo -e "\n${YELLOW}[*] Provera sistemske memorije (Vizuelni semafor):${NC}"
TOTAL_MEM=$(free | grep Mem | awk '{print $2}')
USED_MEM=$(free | grep Mem | awk '{print $3}')
MEM_PERCENT=$(( USED_MEM * 100 / TOTAL_MEM ))

if [ $MEM_PERCENT -lt 50 ]; then
    # Zeleno - Potrošnja je bezbedna
    echo -e "Status memorije: [${GREEN} IIIIIIIIII ${NC}] - ${GREEN}$MEM_PERCENT% Iskorišćeno (Bezbedno)${NC}"
elif [ $MEM_PERCENT -lt 80 ]; then
    # Žuto - Upozorenje
    echo -e "Status memorije: [${YELLOW} IIIIIIIIII ${NC}] - ${YELLOW}$MEM_PERCENT% Iskorišćeno (Upozorenje)${NC}"
else
    # Crveno - Kritično
    echo -e "Status memorije: [${RED} IIIIIIIIII ${NC}] - ${RED}$MEM_PERCENT% Iskorišćeno (KRITIČNO!)${NC}"
fi

echo -e "\n${BLUE}=====================================================${NC}"
echo -e "${BLUE}          SVI SISTEMI SU POD APSOLUTNIM KONCEM!       ${NC}"
echo -e "${BLUE}=====================================================${NC}"
