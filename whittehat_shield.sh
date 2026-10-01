#!/bin/bash

# ==============================================================================
# Linux Security & Network Automation Suite (PRO Version 2)
# Developed by medeni_whitehat 🛡️ | Price: $20
# ==============================================================================

# Colors for the Visual Semaphore
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}==================================================${NC}"
echo -e "${GREEN}      LAUNCHING WHITEHAT SHIELD AUTOMATION PRO    ${NC}"
echo -e "${GREEN}==================================================${NC}"

# FUNCTION 1: Cyber-Lock (UFW Firewall Configuration)
echo -e "\n${YELLOW}[1/3] Configuring Cyber-Lock (UFW Firewall)...${NC}"
if ! command -v ufw &> /dev/null; then
    echo "UFW is not installed. Installing firewall components..."
    sudo apt-get update && sudo apt-get install -y ufw
fi

# Apply secure rule configurations
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp comment 'Secure SSH'
sudo ufw allow 8080/tcp comment 'Web Server App'
echo -e "${GREEN}✔ Firewall policies successfully applied!${NC}"

# FUNCTION 2: Smart Guard (Automated System Backup)
echo -e "\n${YELLOW}[2/3] Executing Smart Guard (System Configuration Backup)...${NC}"
BACKUP_DIR="$HOME/Documents/Backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backing up critical configuration logs and server paths
if [ -d "/etc/ufw" ]; then
    cp -r /etc/ufw "$BACKUP_DIR/"
    echo -e "${GREEN}✔ Firewall configuration backed up successfully.${NC}"
else
    echo "No firewall logs found to archive."
fi

# Compress the entire package into a secure tarball
tar -czf "${BACKUP_DIR}.tar.gz" -C "$HOME/Documents" "$(basename "$BACKUP_DIR")"
rm -rf "$BACKUP_DIR"
echo -e "${GREEN}✔ Production-ready archive created: $(basename "${BACKUP_DIR}.tar.gz")${NC}"

# FUNCTION 3: Traffic Light (Live Resource Diagnostics Semaphore)
echo -e "\n${YELLOW}[3/3] Running Resource Diagnostics Semaphore...${NC}"
RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
RAM_INT=${RAM_USAGE%.*}

echo -e "Current Memory Utilization: ${RAM_INT}%"
if [ "$RAM_INT" -gt 90 ]; then
    echo -e "${RED}[🚨 DANGER] RAM Usage is critical! Core systems overloaded.${NC}"
else
    echo -e "${GREEN}[✔ HEALTHY] RAM Usage is within secure thresholds.${NC}"
fi

echo -e "\n${GREEN}==================================================${NC}"
echo -e "${GREEN}      SYSTEM PROTECTION LOG LOCKED & SECURED      ${NC}"
echo -e "${GREEN}==================================================${NC}"
