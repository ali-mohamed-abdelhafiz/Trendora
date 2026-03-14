# Trendora - Modern E-Commerce Application

Trendora is a professional e-commerce mobile application developed using Flutter. Built on Clean Architecture principles, the project emphasizes scalability and high performance to deliver a premium user experience.

## Download App

Download the latest version for Android:
[Download APK](https://drive.google.com/file/d/1j3BnCI9xB9cCWT8fxa_P97msJosnCPh6/view)

## Project Overview

Trendora provides a comprehensive shopping solution with modern UI/UX design. The application handles complex user flows from authentication to checkout with efficiency.

## Core Features

### User Experience
* Authentication: Secure registration and login systems with token management.
* Product Discovery: Dynamic interface with categories and promotional highlights.
* Product Details: Detailed information pages with high-resolution imagery.
* Cart Management: Real-time shopping cart functionality.

### Account and Logistics
* Profile Management: User sections for account settings and order history.
* Address System: Management of delivery locations and user addresses.
* Navigation: Intuitive transitions between app features.
* Splash Screen: Professional application initialization sequence.

## Technical Architecture

### Development Framework
* Framework: Flutter
* Design Pattern: Clean Architecture

### Core Technologies
* State Management: BLoC
* Navigation: GoRouter
* Networking: Dio
* Dependency Injection: Get It
* Functional Programming: Dartz
* Security: Flutter Secure Storage

### UI and Performance
* Responsiveness: Scaling via flutter_screenutil.
* Visuals: Animations using Lottie and staggered transitions.
* Loading: Shimmer effect for skeleton loading.
* Images: Cached network imaging for performance.

## Directory Structure

```text
lib/
├── core/               # Shared global infrastructure
│   ├── networking/     # API services
│   ├── routing/        # Router configuration
│   ├── styling/        # Themes and typography
│   ├── utils/          # Helpers and service locator
│   └── widgets/        # Reusable UI components
└── features/           # Independent business modules
    ├── auth/           # Authentication
    ├── home_screen/    # Product browsing
    ├── product_screen/ # Product details
    ├── cart/           # Shopping cart
    ├── account/        # User profile
    └── address/        # Location services
```

## Getting Started

1. Install Dependencies
   ```bash
   flutter pub get
   ```

2. Code Generation
   ```bash
   flutter pub run build_runner build
   ```

3. Execution
   ```bash
   flutter run
   ```

Developed with a focus on technical excellence and user-centric design.

