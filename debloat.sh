#!/usr/bin/env bash
# ==============================================================================
# Motorola Edge 50 Neo (Hello UI) - Reversible Adware & Bloatware Debloat Script
# ==============================================================================
# This script safely disables monetization, tracking, and promotional bloatware
# services using native Android package manager commands (`pm disable-user` and
# `package suspend`).
#
# Safe and 100% reversible (run restore.sh to re-enable everything).
# ==============================================================================

set -euo pipefail

echo "======================================================="
echo " Motorola Edge 50 Neo - Adware & Bloatware Debloater"
echo "======================================================="

# Verify ADB connection
echo -n "[*] Checking connected ADB device... "
if ! adb get-state 1>/dev/null 2>&1; then
    echo "FAILED"
    echo "Error: No authorized ADB device found. Ensure USB debugging is enabled."
    exit 1
fi

DEVICE_MODEL=$(adb shell getprop ro.product.model | tr -d '\r')
echo "OK ($DEVICE_MODEL)"

# List of packages to disable via disable-user
TARGET_PACKAGES=(
    "com.dti.motorola"              # Digital Turbine / Moto App Manager (dynamic app installs & ads)
    "com.taboola.mip"               # Taboola Mobile Integration (lockscreen Pictorial & Scoop ads)
    "com.motorola.smartfeed"        # Smart Feed & DeviceNative SDK (app suggestions & affiliate redirects)
    "com.aura.oobe.motorola"        # ironSource Aura OOBE Stub (app recommendation framework)
    "com.motorola.ccc.notification" # Motorola Notifications (promotional & marketing push notifications)
)

echo ""
echo "[*] Disabling ad-serving packages for user 0..."
for pkg in "${TARGET_PACKAGES[@]}"; do
    echo -n " -> Disabling $pkg: "
    if adb shell pm disable-user --user 0 "$pkg" 2>/dev/null | grep -q "disabled"; then
        echo "SUCCESS"
    else
        echo "ALREADY DISABLED / NOT FOUND"
    fi
done

# Suspend BRApps (protected from direct component state disable)
echo -n " -> Suspending com.motorola.brapps: "
if adb shell cmd package suspend --user 0 com.motorola.brapps 2>/dev/null | grep -q "true"; then
    echo "SUCCESS"
else
    echo "ALREADY SUSPENDED / NOT FOUND"
fi

echo ""
echo "======================================================="
echo " Debloat complete!"
echo " All changes are 100% reversible. Run ./restore.sh anytime."
echo "======================================================="
