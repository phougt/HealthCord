# HealthCord 🏥

A Flutter app for managing family health records with group-based collaboration.

## Features

- **User Authentication** - Secure login/signup system
- **Family Groups** - Create and join health record groups
- **Medical Entities** - Manage doctors and hospitals information
- **Group Management** - Role-based permissions and member management
- **Secure Storage** - Encrypted local data storage

## Tech Stack

- **Flutter** with Material Design 3
- **Provider** for state management
- **Go Router** for navigation
- **Dio** for API communication
- **Secure Storage** for sensitive data
- **Google Fonts** for typography

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── screens/          # UI screens
├── models/           # Data models
├── viewModels/       # Business logic
├── repositories/     # Data layer
├── managers/         # App-wide managers
├── configs/          # App configuration
└── utils/            # Helper utilities
```

## Key Screens

- **Home** - Dashboard with family groups
- **Authentication** - Login/signup flows
- **Group Management** - Create, join, and manage groups
- **Medical Entities** - Add doctors and hospitals
- **Group Settings** - Configure group preferences

---

Built for managing family health records collaboratively 👨‍👩‍👧‍👦
