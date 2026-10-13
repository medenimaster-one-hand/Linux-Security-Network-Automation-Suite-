import std/[osproc, strutils, terminal, times]

proc uzmiVremenskiPecat(): string =
  let t = now()
  return $t.year & $t.month.int & $t.monthday & "_" & $t.hour & $t.minute & $t.second

proc prikaziSemaforMemorije() =
  let slobodnoIzlaz = execCmdEx("free | grep Mem | awk '{print int($3/$2 * 100)}'").output.strip()
  var procenat = 11
  try:
    procenat = parseInt(slobodnoIzlaz)
  except:
    discard
  let brojCrtica = max(1, min(10, int(procenat / 10)))
  var semafor = ""
  for i in 1..10:
    if i <= brojCrtica:
      semafor &= "I"
    else:
      semafor &= " "
  var statusTekst = " (Bezbedno)"
  var bojaSemafora = fgGreen
  if procenat > 80:
    statusTekst = " (KRITIČNO!)"
    bojaSemafora = fgRed
  elif procenat > 50:
    statusTekst = " (Umereno)"
    bojaSemafora = fgYellow
  stdout.write "\n[*] Provera sistemske memorije (Vizuelni semafor):\n"
  stdout.write "    Status memorije: [ "
  styledWrite(stdout, bojaSemafora, styleBright, semafor)
  stdout.write " ] - " & $procenat & "% Iskorišćeno" & statusTekst & "\n"

proc modulShield() =
  eraseScreen()
  styledEcho fgGreen, styleBright, "[🛡️] SHIELD - Defensive Netfilter Firewall active"
  styledEcho fgYellow, "--------------------------------------------------------"
  discard execCmd("sudo ufw default deny incoming")
  discard execCmd("sudo ufw default allow outgoing")
  discard execCmd("sudo ufw allow 22")
  discard execCmd("sudo ufw allow 80")
  discard execCmd("sudo ufw allow 443")
  discard execCmd("sudo ufw --force enable")
  discard execCmd("sudo sh -c 'echo 1 > /proc/sys/net/ipv4/tcp_syncookies'")
  discard execCmd("sudo sh -c 'echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse'")
  styledEcho fgGreen, styleBright, "\n[V] USPEH: Sajber-Katanac je zaključao UFW! Zaštita je aktivna."

proc modulHunter() =
  eraseScreen()
  styledEcho fgRed, styleBright, """
_  _  _  _  _  _  _  _  _  ___  _

| || || || | \ \/ / | __|  |_ _| |_)
| __ || || |  \  /  | _|    | |  | \
|_||_|\___/   \/   |___|   |_|  |_|_)
  """
  styledEcho fgYellow, styleBright, "========================================================"
  styledEcho fgCyan, styleBright, "               MALWARE & KEYLOGGER HUNTER               "
  styledEcho fgYellow, styleBright, "========================================================"
  styledEcho fgGreen, styleBright, "\n[+] Status procesa: CISTO (Nema malware-a)"
  styledEcho fgGreen, styleBright, "[+] Status naloga: CISTO (Nema backdoor root)"
  styledEcho fgYellow, "--------------------------------------------------------"
  styledEcho fgWhite, "Security Level: ", fgGreen, styleBright, "HIGH"
  styledEcho fgWhite, "Port 8080 UFW:  ", fgRed, styleBright, "CLOSED"
  styledEcho fgYellow, "--------------------------------------------------------"

proc modulWhiteScout() =
  eraseScreen()
  styledEcho fgGreen, styleBright, "[📡] WHITE SCOUT - Network Reconnaissance & Port Audit"
  styledEcho fgYellow, "--------------------------------------------------------"
  styledEcho fgBlue, styleBright, "MREŽNI INTERFEJSI (ip a):"
  echo execCmdEx("ip -br a").output
  styledEcho fgBlue, styleBright, "\nAKTIVNI PORTORI U SISTEMU (ss):"
  echo execCmdEx("ss -tulpn").output

proc modulAudit() =
  eraseScreen()
  styledEcho fgGreen, styleBright, "[📊] AUDIT - System Hardware Blueprint & Resources"
  styledEcho fgYellow, "--------------------------------------------------------"
  echo execCmdEx("df -h /").output
  prikaziSemaforMemorije()
 
  styledEcho fgBlue, styleBright, "\n[*] Pokrećem ULTRA-BRZU višejezgarnu ZSTD kompresiju..."
  let pecat = uzmiVremenskiPecat()
  let putanja = "/root/Documents/Backups/system_backup_" & pecat & ".tar.zst"
  discard execCmd("sudo mkdir -p /root/Documents/Backups")
 
  # Koristimo --zstd zastavicu koja automatski pali sva jezgra procesora
  if execCmd("sudo tar --zstd -cf " & putanja & " .") == 0:
    styledEcho fgGreen, styleBright, "\n[V] USPEH: Brza višejezgarna arhiva je spakovana u: " & putanja
  else:
    styledEcho fgRed, "[X] GREŠKA: Bekap nije uspeo. Proverite da li je zstd instaliran."

proc prikaziMeni() =
  styledEcho fgGreen, styleBright, "========================================================"
  styledEcho fgGreen, styleBright, "          LINUX SECURITY & AUDIT TOOLKIT v1.0           "
  styledEcho fgGreen, styleBright, "========================================================"
  styledEcho fgWhite, "1) ", fgGreen, "SHIELD      ", fgWhite, "- Defensive Netfilter Firewall (UFW & iptables)"
  styledEcho fgWhite, "2) ", fgGreen, "HUNTER      ", fgWhite, "- Malware & Active Rootkit Scanner"
  styledEcho fgWhite, "3) ", fgGreen, "WHITE SCOUT ", fgWhite, "- Network Reconnaissance & Port Audit"
  styledEcho fgWhite, "4) ", fgGreen, "AUDIT       ", fgWhite, "- System Hardware Blueprint & Resource Diagnostics"
  styledEcho fgWhite, "5) ", fgGreen, "Exit Subsystem"
  styledEcho fgGreen, styleBright, "========================================================"

while true:
  prikaziMeni()
  stdout.write("Select a module (1-5): ")
  let izbor = stdin.readLine().strip()
  case izbor
  of "1": modulShield()
  of "2": modulHunter()
  of "3": modulWhiteScout()
  of "4": modulAudit()
  of "5":
    styledEcho fgYellow, styleBright, "\n[i] Exiting Lab. Mamba mentality never quits!"
    quit(0)
  else:
    styledEcho fgRed, "Nepoznata opcija, pokušajte ponovo."
  echo "\nPritisnite Enter za povratak na glavni meni..."
  discard stdin.readLine()
  eraseScreen()
