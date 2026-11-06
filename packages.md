# Motorola Hello UI Adware & Bloatware Technical Breakdown

This document details the background monetization packages, telemetry engines, and ad injectors discovered on Motorola Hello UI devices (specifically analyzed on **Motorola Edge 50 Neo**, Android 16 / Build `W1UI36H.39-25-11-4`).

---

### 1. `com.dti.motorola` (Digital Turbine / Moto App Manager)
* **Underlying platform:** Digital Turbine Ignite (`dtignite.com`)
* **Split APKs discovered:**
  * `split_dynamicInstalls.apk`
  * `split_notification.apk`
  * `split_contentMedia.apk`
  * `split_singleTap.apk`
  * `split_packageUsageStats.apk`
* **Network Endpoints:** `notice.dtignite.com`, `sti.dtignite.com`, `delivers.dtignite.com`, `wizard.dtignite.com`
* **Behavior:** Digital Turbine acts as a privileged system install broker. It can silently push apps and games in the background without user interaction, display install suggestion cards in lock screens and notifications, and provide single-tap sponsored download links.

---

### 2. `com.taboola.mip` (Taboola Mobile Integration Platform)
* **Components:**
  * `PictorialSlideActivity`
  * `PictorialCarouselActivity`
  * `com.taboola.android.scoop.widget.news.ui.screens.WidgetActivity`
* **Behavior:** Integrates Taboola's native advertising network into Hello UI. This powers the "Pictorial" lock screen carousel, "Scoop" news feeds, and sponsored clickbait stories throughout Motorola's feed widgets.

---

### 3. `com.motorola.smartfeed` (Motorola Smart Feed)
* **SDKs & Integrations:**
  * `com.motorola.smartstreamsdk` (DeviceNative / DNA monetization SDK)
  * `CastSearchBarService` & `ALL_APPS_OVERLAY_SETTINGS_SERVICE` (tied into `com.motorola.launcher3`)
  * `DailyDropsSettingsActivity`
* **Behavior:** Hooks into the stock launcher and app drawer overlay. Beyond displaying recommended articles and app trays ("Daily Drops"), its underlying SmartStream SDK acts as an affiliate redirection broker: clicking certain shopping links (Amazon, AliExpress, etc.) or app suggestions routes the request through tracking domains (`devicenative.com`) to inject affiliate referral tags.

---

### 4. `com.aura.oobe.motorola` (ironSource Aura AppCloud)
* **Binary Path:** `/product/priv-app/AppCloudOobeMotorolaStub`
* **Components:** `LauncherPostOOBEActivity`, `SystemEventsBroadcastReceiver`
* **Behavior:** ironSource Aura is an OEM app recommendation engine that triggers during initial phone setup (OOBE) and following software updates to encourage downloading sponsored apps.

---

### 5. `com.motorola.brapps` (BRApps)
* **Binary Path:** `/product/priv-app/BRApps2/BRApps2.apk`
* **Behavior:** Regional and carrier partner app portal that pushes recommended apps and partner services. It is protected against standard `pm disable` shell calls, but can be safely frozen using Android's native `cmd package suspend`.

---

### 6. `com.motorola.ccc.notification` (Motorola Notifications)
* **Behavior:** Push notification channel managed by Motorola to send surveys, promotional ads for Moto accessories, partner deals, and system feature spotlights.
