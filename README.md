# Prophezy

A TikTok-style social prediction app where users vote with micro-bets on future events and earn rewards based on accuracy and participation.

## Overview

Prophezy is a decentralized prediction market platform built on Starknet that allows users to:

- Create and participate in prediction markets
- Place micro-bets on future events
- Earn rewards based on prediction accuracy
- Engage with a social community of predictors

## Tech Stack

- **Frontend**: Flutter
- **Blockchain**: Starknet

## Prerequisites

- Flutter SDK (>=3.2.3)
- Git
- Windows Developer Mode (for Windows users)
- Chocolatey (Windows package manager, for Dart SDK)

## Development Environment Setup

### 1. Install Chocolatey (Windows)

1. Open PowerShell as Administrator
2. Run the following command:

```sh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### 2. Install Dart SDK

```sh
choco install dart-sdk
```

### 3. Install Flutter SDK

1. Download the Flutter SDK from [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. Extract the downloaded zip to a desired location (e.g., `C:\src\flutter`)
3. Add Flutter to your PATH:
   - Open System Properties > Advanced > Environment Variables
   - Under System Variables, edit Path
   - Add the full path to `flutter\bin`
4. Verify installation:

```sh
flutter doctor
```

### 4. Install VS Code

1. Download VS Code from [code.visualstudio.com](https://code.visualstudio.com/)
2. Run the installer and follow the setup wizard
3. Install Flutter and Dart extensions:
   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X)
   - Search for "Flutter" and install
   - Search for "Dart" and install

### 5. Install Android Studio (for Emulator)

1. Download Android Studio from [developer.android.com](https://developer.android.com/studio)
2. Run the installer and follow the setup wizard
3. During installation, make sure to select:
   - Android SDK
   - Android SDK Platform
   - Android Virtual Device

## Installation

1. Clone the repository:

```sh
git clone https://github.com/yourusername/prophezy.git
cd prophezy
```

2. Install dependencies:

```sh
flutter pub get
```

3. Set up environment variables:

   - Copy `.env.example` to `.env`
   - Fill in your Starknet configuration:
     ```
     ACCOUNT_CLASS_HASH=your_account_class_hash
     RPC=your_starknet_rpc_url
     ```

4. Enable Developer Mode (Windows only):

```sh
start ms-settings:developers
```

## Development

1. Start the development server:

```sh
flutter run
```

2. Build for production:

```sh
flutter build apk  # for Android
flutter build ios  # for iOS
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built for Starknet Hackathon 2025 (Re-Ignite)
- Inspired by TikTok's social engagement model
- Powered by Starknet's scalability
