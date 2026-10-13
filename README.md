# ⚡ MEDOX SECURITY SUITE v2.5 - PREMIUM ⚡
### Global Network Security & Automation Suite for Linux Systems

An advanced, compiled, and ultra-fast Attack & Defence toolkit written in **Nim**. Designed for rapid server hardening, live diagnostics, system audit, and multi-core automated backups in high-pressure cybersecurity environments.

---

## 🛡️ Core Modules & Features

The suite consolidates critical administrative and whitehat defensive utilities into a single, dependency-free binary execution file:

1. **` Hardening Firewall (UFW Cyber-Lock)`**
   * Forces strict global network policies (`Deny Incoming` / `Allow Outgoing`).
   * Deploys the **Golden Rule Protocol** to mitigate SYN Flood, DoS, and brute-force network attacks via kernel level tweaks (`tcp_syncookies`, `tcp_tw_reuse`).
   * Automatically configures and enables UFW protection persistently across system reboots.

2. **` Run Automated System Backup Archive`**
   * Scans system partitions (`df -h`) and includes volatile memory optimization routines (`drop_caches`) to flush RAM leakages under heavy load with a live visual traffic-light indicator.
   * Executes high-speed, volatile runtime storage preservation using kernel-optimized multi-core **ZSTD (Zstandard)** compression.
   * Packages system assets into an isolated `.tar.zst` archive.

3. **` Show Visual System Resource Monitor`**
   * Acts as a live blueprint hardware scanner and monitor.
   * Exposes active system sockets and networks.

4. **` Exit Lab (Close program)`**
   * Safely terminates operations and clears the secure terminal space.

---

## 🚀 Installation & Deployment

### Prerequisites
Ensure your system has the Nim compiler installed along with standard administration tools (`ufw`, `ss`, `zstd`).

### Compilation
Compile the suite directly into a native Linux binary for maximum execution speed and zero interpreter overhead:

```bash
nim c -d:release nanotools.nim
```

### Execution
The suite interacts directly with network filters and kernel memory systems, meaning **root privileges are mandatory** for deployment:

```bash
chmod +x nanotools
sudo ./nanotools
```

---
*Developed under the Whitehat Shield standards for network integrity protection.*
