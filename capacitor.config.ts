import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.mka.tajneed',
  appName: 'MKA Tajneed',
  webDir: 'dist',
  server: {
    androidScheme: 'https',
  },
  android: {
    allowMixedContent: true,
    backgroundColor: '#1a3d28',
  },
  plugins: {
    StatusBar: {
      style: 'DARK',
      backgroundColor: '#1a3d28',
    },
    Keyboard: {
      resize: 'body',
      resizeOnFullScreen: true,
    },
  },
};

export default config;
