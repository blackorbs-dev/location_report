```markdown
# 📍 Location Report App

A Flutter application for creating and managing location-based incident reports. Users can capture media, select a report type, enter a description, and submit with automatic location tagging and address resolution.

---

## 🔧 Features

- 🗂 **Feature-Based Architecture** (Modular and scalable)
- 🧠 **BLoC State Management** (Clean separation of UI and logic)
- 📦 **ObjectBox** for fast local storage with embedded location entity and enum support
- 🗺️ **Google Maps Integration** (`google_maps_flutter`)
- 📍 **Geocoding** from coordinates to address
- 📸 **Image & Video Capture** using `image_picker`
- 🖋 **Overlay Text** on media with `image` package
- 🔀 **Navigation** via `go_router`

---

## 🚀 Getting Started

### 🔑 Prerequisites

- Flutter SDK (3.22 or newer recommended)
- A Google Maps API key

### 🔨 Setup Instructions

```bash
# Clone the repository
git clone https://github.com/blackorbs-dev/location_report.git
cd location_report

# Install dependencies
flutter pub get

# Run the app with your Maps API key
flutter run --dart-define=MAPS_API_KEY="ADD YOUR GOOGLE MAPS API KEY"
```

---

---

## 📁 Project Structure (Feature-based)

```text
lib/
├── core/              # Shared utilities, services, constants
├── features/
│   └── report/
│       ├── data/      # ObjectBox model, storage logic
│       ├── domain/    # Entities, enums
│       ├── logic/     # Bloc/Cubit
│       ├── presentation/
│           ├── pages/
│           └── widgets/
├── routes/            # go_router config
main.dart              # Entry point
```


## 📌 Notes

- No Firebase or backend integration required.
- Location data is embedded in each report.

---

## 📜 License

MIT License © 2025 [BlackOrbs Technology](https://github.com/blackorbs-dev)
```
