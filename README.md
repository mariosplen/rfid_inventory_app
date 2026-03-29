# SnapRFID — AI-Powered RFID Inventory App

> Undergraduate thesis project — Democritus University of Thrace, Department of Informatics (April 2025)  
> **Marios M. Plenchidis** · Supervisor: Dimitrios Karampatzakis, Assistant Professor

A Flutter mobile application that combines **UHF RFID** hardware with **Google Gemini AI** to automate inventory management. Point your phone's camera at any item, let AI fill in the details, and track everything in real time via a Raspberry Pi + WebSocket pipeline.

---

## ✨ Features

| Feature | Description |
|---|---|
| 📡 **Real-time RFID scanning** | Connects to a UHF RFID reader (Impinj Speedway R420) via WebSocket and detects tags instantly |
| 🤖 **AI item identification** | Take a photo of any object — Google Gemini auto-fills name, category, tags, and color |
| 📦 **Inventory management** | Create and manage multiple inventories, each with location, description, and notes |
| 🎨 **Tag-based filtering** | Filter items by category, tags, color, or detection status |
| 🌙 **Light & dark mode** | Full theme support for both light and dark UI |
| 📴 **Offline-first storage** | All data stored locally with Hive; no cloud dependency for core operations |

---

## 🏗️ Architecture

```
┌─────────────────┐     ┌──────────────────────┐     ┌─────────────────────┐
│  UHF RFID       │     │   Raspberry Pi         │     │   Flutter App       │
│  Antenna +      │────▶│   Python (Tornado)     │────▶│   (Android / iOS)   │
│  Speedway R420  │     │   WebSocket Server     │     │                     │
└─────────────────┘     └──────────────────────┘     └──────────┬──────────┘
                                                                  │
                                                    ┌─────────────▼──────────┐
                                                    │   Google Gemini API    │
                                                    │   (via Firebase /GCP)  │
                                                    └────────────────────────┘
```

**Hardware side:** The RFID reader connects to a Raspberry Pi over Ethernet. A Python script (using the Tornado framework) reads tag EPCs and broadcasts them over a WebSocket connection on the local network.

**App side:** The Flutter app connects to the WebSocket, receives tag data in real time, and lets users associate tags with inventory items. When an internet connection is available, it calls the Gemini API to auto-populate item details from a photo.

**Storage:** Item and inventory data is persisted locally using a Hive NoSQL database with the following schema:

```
Inventory { id, name, description, location, note, items[] }
    └── Item { epc, name, category, color, tags[], image }
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Mobile app | Flutter (Dart) |
| State management | Cubit (flutter_bloc) |
| Local database | Hive |
| AI | Google Gemini API |
| Backend / auth | Firebase (Google Cloud Platform) |
| Hardware bridge | Python + Tornado WebSocket |
| RFID hardware | Impinj Speedway R420 + UHF antenna |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.x
- A Firebase project with Gemini API access enabled
- A Raspberry Pi on the same local network as your phone
- An Impinj Speedway R420 (or compatible) UHF RFID reader

### Installation

```bash
git clone https://github.com/mariosplen/rfid_inventory_app.git
cd rfid_inventory_app
flutter pub get
```

Set up Firebase by placing your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in the appropriate directories, then run:

```bash
flutter run
```

### Connecting to the RFID reader

1. Make sure your phone and the Raspberry Pi are on the **same local network**.
2. On the Raspberry Pi, run the Python WebSocket server (see `/raspberry_pi` if included, or configure your own Tornado script).
3. Open the app, enter the Raspberry Pi's **IP address** and **port**, and tap **Connect**.

---

## 📱 App Walkthrough

**Connect → Inventory list → Item detail → Edit / AI fill**

1. **Connect to Reader** — Enter the WebSocket address and port.
2. **Inventory screen** — See all your inventories, item counts, and any unregistered tags the reader has detected.
3. **Create an inventory** — Give it a name, location, and optional notes.
4. **Register a tag** — Tap an unregistered tag and fill in item details manually, or use **Auto Fill with AI**: take a photo and Gemini returns name, category, tags, and color automatically.
5. **Filter & track** — Filter items by category, tags, or color. Items detected by the reader are highlighted; items out of range are marked as not detected.

---

## 📄 Academic Context

This project was developed as an undergraduate thesis at the **Department of Informatics, Democritus University of Thrace** (April 2025). The thesis covers:

- IoT fundamentals and RFID technology history and architecture
- AI/ML object recognition methods (CNNs, YOLO, SSD, Faster R-CNN)
- Large Language Models and multimodal learning (GPT, LLaMA, Gemini)
- System requirements, design, hardware setup, and app implementation

## Thesis

📄 [Read the full thesis (PDF)](https://github.com/mariosplen/rfid_inventory_app/blob/main/Thesis_Marios_Plenchidis.pdf)

---

## 📃 License

This project is the intellectual property of the author, the supervising professor, and the Department of Informatics, DUTh, protected under Greek copyright law (Law 2121/1993) and applicable international law.
