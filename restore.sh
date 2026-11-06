#!/usr/bin/env bash
# ==============================================================================
# Motorola Edge 50 Neo (Hello UI) - Restore Script
# ==============================================================================
# Re-enables all services disabled or suspended by debloat.sh.
# ==============================================================================

set -euo pipefail

echo "======================================================="
echo " Motorola Edge 50 Neo - Restore Disabled Packages"
echo "======================================================="

echo -n "[*] Checking connected ADB device... "
if ! adb get-state 1>/dev/null 2>&1; then
    echo "FAILED"
    echo "Error: No authorized ADB device found. Ensure USB debugging is enabled."
    exit 1
fi

DEVICE_MODEL=$(adb shell getprop ro.product.model | tr -d '\r')
echo "OK ($DEVICE_MODEL)"

TARGET_PACKAGES=(
    "com.dti.motorola"
    "com.taboola.mip"
    "com.motorola.smartfeed"
    "com.aura.oobe.motorola"
    "com.motorola.ccc.notification"
)

echo ""
echo "[*] Re-enabling packages..."
for pkg in "${TARGET_PACKAGES[@]}"; do
    echo -n " -> Enabling $pkg: "
    if adb shell pm enable "$pkg" 2>/dev/null | grep -q "enabled"; then
        echo "SUCCESS"
    else
        echo "FAILED / ALREADY ENABLED"
    fi
done

echo -n " -> Unsuspending com.motorola.brapps: "
if adb shell cmd package unsuspend --user 0 com.motorola.brapps 2>/dev/null | grep -q "false"; then
    echo "SUCCESS"
else
    echo "FAILED / ALREADY ACTIVE"
fi

echo ""
echo "======================================================="
echo " All services have been successfully restored!"
echo "======================================================="
