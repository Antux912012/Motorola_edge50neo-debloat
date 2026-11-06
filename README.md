# Motorola Edge 50 Neo - Adware & Bloatware Debloater

Safe, non-root, 100% reversible scripts to disable hidden ad networks, tracking services, affiliate redirect engines, and promotional push notifications on the **Motorola Edge 50 Neo** (and other modern Motorola devices running **Hello UI**).

---

## The Problem

Recent Motorola devices running **Hello UI** (Android 14 / 15 / 16) integrate background monetization partners directly into the system software:

1. **Digital Turbine (`com.dti.motorola`)**: A platform that silently pre-installs bloatware and pushes app recommendation notifications.
2. **Taboola (`com.taboola.mip`)**: Embedded native advertising network that powers lockscreen "Pictorial" carousels and "Scoop" news feeds filled with sponsored content.
3. **Smart Feed & SmartStream SDK (`com.motorola.smartfeed`)**: Injects app suggestions into the app tray and hooks into launcher search bars. Uses DeviceNative SDK routines to inject affiliate referral codes when interacting with targeted shopping links.
4. **ironSource Aura (`com.aura.oobe.motorola`) & BRApps (`com.motorola.brapps`)**: Partner app onboarding portals and sponsored app stores.
5. **Motorola Notifications (`com.motorola.ccc.notification`)**: System push channel for promotional campaigns and partner deals.

### Why DNS Ad-Blockers (like AdGuard) Don't Stop Them
DNS filtering only blocks requests sent to known ad domains. These Motorola Hello UI services bypass typical DNS blocking because:
* Notifications and app updates arrive via Google Firebase Cloud Messaging (FCM).
* Content is pushed via internal OEM services or first-party endpoints.
* Monetization SDKs are compiled directly into the system APKs.

---

## The Solution

These scripts use native Android Package Manager commands (`pm disable-user --user 0` and `cmd package suspend --user 0`) to freeze these background components without touching system partitions or requiring root privileges.

* **No root required.**
* **Preserves system updates (OTA):** Disabling for `user 0` does not break OTA updates.
* **100% Reversible:** Running `restore.sh` immediately unfreezes all packages.

---

## Requirements

1. A computer with **ADB (Android Debug Bridge)** installed:
   * **Debian / Ubuntu**: `sudo apt install adb`
   * **Fedora**: `sudo dnf install android-tools`
   * **Arch Linux**: `sudo pacman -S android-tools`
   * **macOS**: `brew install android-platform-tools`
   * **Windows**: Download [Google Platform Tools](https://developer.android.com/tools/releases/platform-tools).
2. **USB Debugging** enabled on your Motorola device:
   * Go to **Settings > About phone**.
   * Tap **Build number** 7 times to enable Developer options.
   * Go to **Settings > System > Developer options** and enable **USB debugging**.
   * Connect your phone via USB and tap **Allow** when prompted on your phone screen.

---

## Quick Start

### 1. Debloat (Disable Ads & Bloat)
Clone the repository, connect your phone, and run:

```bash
git clone https://github.com/Antux912012/Motorola_edge50neo-debloat.git
cd Motorola_edge50neo-debloat
chmod +x debloat.sh restore.sh
./debloat.sh
```

### 2. Restore (Re-Enable Everything)
If you ever want to re-enable all original services:

```bash
./restore.sh
```

---

## Packages Handled

| Package | Purpose / Description | Action |
| :--- | :--- | :--- |
| `com.dti.motorola` | Digital Turbine / Moto App Manager (silent app installs) | `pm disable-user` |
| `com.taboola.mip` | Taboola Mobile Integration (Pictorial lockscreen & feed ads) | `pm disable-user` |
| `com.motorola.smartfeed` | Smart Feed & DeviceNative SDK (app suggestions & affiliate links) | `pm disable-user` |
| `com.aura.oobe.motorola` | ironSource Aura / AppCloud (app recommendation stub) | `pm disable-user` |
| `com.motorola.ccc.notification` | Motorola Notifications (marketing push notifications) | `pm disable-user` |
| `com.motorola.brapps` | BRApps (carrier/regional app promotion portal) | `cmd package suspend` |

For an in-depth breakdown of each package, see [packages.md](packages.md).

---

## License

This project is licensed under the [MIT License](LICENSE).
