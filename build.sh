#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# MKA Tajneed — Android APK Build Script
# Run this once to install everything and build the APK
# Requirements: Node.js 18+, JDK 17+, Android SDK (or Android Studio)
# ═══════════════════════════════════════════════════════════════

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}═══════════════════════════════════════════${NC}"
echo -e "${GREEN}   MKA Tajneed — Android Build Script      ${NC}"
echo -e "${GREEN}═══════════════════════════════════════════${NC}"

# Check Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js not found. Install from https://nodejs.org${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Node.js: $(node --version)${NC}"

# Check Java
if ! command -v java &> /dev/null; then
    echo -e "${RED}❌ Java not found. Install JDK 17 from https://adoptium.net${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Java: $(java -version 2>&1 | head -1)${NC}"

# Check ANDROID_HOME
if [ -z "$ANDROID_HOME" ]; then
    # Try common paths
    if [ -d "$HOME/Library/Android/sdk" ]; then
        export ANDROID_HOME="$HOME/Library/Android/sdk"
    elif [ -d "$HOME/Android/Sdk" ]; then
        export ANDROID_HOME="$HOME/Android/Sdk"
    elif [ -d "/opt/android-sdk" ]; then
        export ANDROID_HOME="/opt/android-sdk"
    else
        echo -e "${YELLOW}⚠️  ANDROID_HOME not set.${NC}"
        echo -e "${YELLOW}   Install Android Studio: https://developer.android.com/studio${NC}"
        echo -e "${YELLOW}   Then set: export ANDROID_HOME=~/Library/Android/sdk (macOS)${NC}"
        echo -e "${YELLOW}   Or:       export ANDROID_HOME=~/Android/Sdk (Linux)${NC}"
        echo ""
        echo -e "${YELLOW}   Continuing — will attempt to build anyway...${NC}"
    fi
else
    echo -e "${GREEN}✅ Android SDK: $ANDROID_HOME${NC}"
fi

echo ""
echo -e "${YELLOW}📦 Step 1: Installing npm dependencies...${NC}"
npm install

echo ""
echo -e "${YELLOW}🔨 Step 2: Building React app...${NC}"
npm run build

echo ""
echo -e "${YELLOW}📱 Step 3: Setting up Capacitor...${NC}"
if [ ! -f "capacitor.config.json" ] && [ ! -d "android" ]; then
    npx cap init "MKA Tajneed" "com.mka.tajneed" --web-dir dist
    npx cap add android
else
    echo "Capacitor already initialized, syncing..."
fi

npx cap sync android

echo ""
echo -e "${YELLOW}🏗️  Step 4: Building APK...${NC}"
cd android
chmod +x gradlew 2>/dev/null || true

# Build debug APK
./gradlew assembleDebug

APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
if [ -f "$APK_PATH" ]; then
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════${NC}"
    echo -e "${GREEN}✅ APK built successfully!${NC}"
    echo -e "${GREEN}📍 Location: android/$APK_PATH${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════${NC}"
    echo ""
    echo -e "Transfer to your Android phone and install."
    echo -e "Enable 'Install from Unknown Sources' in Android Settings first."
else
    echo -e "${RED}❌ APK not found. Check errors above.${NC}"
    exit 1
fi
