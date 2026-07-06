# 📱 Flo Wallet

A secure, modern, and scalable Digital Wallet mobile application built using **Flutter** and **Firebase**. This project strictly adheres to **Clean Architecture** principles and utilizes advanced state management to ensure a robust and maintainable codebase.

---

## 🚀 Features

- **Secure Authentication:** Phone number registration with dynamic OTP verification flow.
- **Wallet Management:** Real-time balance updates and account state tracking.
- **Transaction History:** Comprehensive ledger of all incoming and outgoing financial transactions.
- **QR Code Scanner:** Fast and secure peer-to-peer money transfers via QR code scanning.
- **Modern UI/UX:** Responsive layouts, custom buttons, dynamic theme support, and sleek onboarding screens.
- **Advanced Exception Handling:** Secure remote data sources with robust mapping of server and Firebase exceptions.

---

## 📸 Media & Assets

- **App Screenshots:** All visual previews, user interface flows, and application screenshots are organized and available in the `/screenshots` directory at the root of this repository.

---

## 🏗️ Architecture & Tech Stack

This project is built using **Clean Architecture** split into three distinct layers to ensure separation of concerns and high testability:

- **Data Layer:** Handles API/Firebase communication, model parsing (`TransactionModel`, `WalletModel`), and remote data sources implementation.
- **Domain Layer:** Contains business logic, entities, and use cases (e.g., `GetWalletUseCase`, `ConfirmOtpUseCase`).
- **Presentation Layer:** Built using UI views and **BLoC/Cubit** for reactive and clean state management.

### Key Technologies:
- **Framework:** Flutter & Dart
- **State Management:** BLoC / Cubit
- **Asynchronous Data:** Reactive Streams (StreamBuilder / Stream-driven BLoCs) for real-time synchronization.
- **Data Optimization:** Custom Pagination logic for loading large transaction histories seamlessly without draining device memory.
- **Backend/Database:** Firebase Auth & Cloudinary
- **Dependency Injection:** Service Locator via GetIt
- **Routing:** Declarative App Router

---

## 📲 Download & Try the App

You can download the production-ready application binary directly from the GitHub Releases section. To ensure smooth performance across all hardware, two optimized versions are available:

1. Go to the **Releases** section on the right sidebar of this repository.
2. Choose the appropriate version for your Android device:
   - **`flo-wallet-arm64-v8a.apk`:** Optimized for modern/new devices (64-bit architecture).
   - **`flo-wallet-armeabi-v7a.apk`:** Optimized for older devices (32-bit architecture).
3. Download, install, and run it on your smartphone.

---

## 🔒 Security & Best Practices

- **Configuration Secrets:** Google Services configuration files (`google-services.json`/`GoogleService-Info.plist`) and local environment configuration variables are completely secured and untracked via `.gitignore`.
