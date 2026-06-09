# MKA Tajneed — Android App

## Build an APK in 3 Steps

### Prerequisites (install once)
1. **Node.js 18+** → https://nodejs.org
2. **JDK 17+** → https://adoptium.net
3. **Android Studio** → https://developer.android.com/studio
   - During setup, install **Android SDK** and accept licenses
   - Note your SDK path (usually `~/Library/Android/sdk` on Mac, `~/Android/Sdk` on Linux/Windows)

---

### Step 1 — Set Android SDK path
**macOS / Linux:**
```bash
export ANDROID_HOME=~/Library/Android/sdk        # macOS
export ANDROID_HOME=~/Android/Sdk                # Linux
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

**Windows (PowerShell):**
```powershell
$env:ANDROID_HOME = "$HOME\AppData\Local\Android\Sdk"
$env:PATH += ";$env:ANDROID_HOME\tools;$env:ANDROID_HOME\platform-tools"
```

---

### Step 2 — Run the build script
```bash
cd mka-android
chmod +x build.sh
./build.sh
```

**Windows:**
```powershell
cd mka-android
npm install
npm run build
npx cap init "MKA Tajneed" com.mka.tajneed --web-dir dist
npx cap add android
npx cap sync android
cd android
.\gradlew.bat assembleDebug
```

---

### Step 3 — Install on Android phone
1. Find the APK at: `android/app/build/outputs/apk/debug/app-debug.apk`
2. Copy to your phone (USB or Google Drive)
3. On phone: **Settings → Security → Install Unknown Apps** → Enable
4. Tap the APK file to install

---

## Manual step-by-step (alternative)
```bash
npm install
npm run build
npx cap add android
npx cap sync android
npx cap open android        # Opens Android Studio
# In Android Studio: Build → Build APK(s)
```

---

## App Features
- **General Login** — Data entry, no password
- **Sub-Admin Login** — Manage one Local Majlish (password protected)
- **Admin Login** — Full access: all members, charts, structure, accounts
  - Demo: `admin` / `admin@mka2024`
- **Advanced filtering** by category, region, zilla, blood group, profession, etc.
- **Auto password** generation for new Local Majlish
- **CSV export** of all member data
- **Charts** — Category, profession, blood group, region distribution

## App ID
`com.mka.tajneed`

## Credentials (demo)
| Role | ID | Password |
|------|----|----------|
| Admin | admin | admin@mka2024 |
| Sub-Admin | sub001 | sub@123 |
