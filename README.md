# NYTimes Most Viewed Articles App

An iOS application that displays the most viewed articles from the New York Times, built with SwiftUI, MVVM architecture, SwiftData, and modern iOS technologies.

---

## ✨ Features

- 📰 Fetches most viewed articles (1/7/30 days) from the NYT API
- 📥 Caching support to reduce API calls and improve UX
- ❤️ Like/unlike articles and view them in a separate tab
- 🔍 Filter by time range (1, 7, or 30 days)
- 🔄 Pull-to-refresh and auto-pagination
- 📱 Beautiful SwiftUI UI with async image loading and native caching
- ✅ Unit tests and UI tests with XCTest

---

## 📦 Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Concurrency**: `async/await`, Combine
- **Persistence**: SwiftData
- **Image Caching**: Native or [`SDWebImageSwiftUI`](https://github.com/SDWebImage/SDWebImageSwiftUI) via Swift Package Manager
- **Testing**: XCTest (unit and UI tests)

---

## 🔑 API Key

This app uses the New York Times Most Viewed Articles API.

> **Note**: You must request and use your own NYT API key. You should have received it via email.

### Add your key here:

```swift
final class NYTAPIConfiguration {
    static let shared = NYTAPIConfiguration()
    private let keychainKey = Bundle.main.bundleIdentifier! + ".NYTAPIKey"

    private let testAPIKey = "use the key from mail"
}
'''

Keep the key secure and avoid committing it to version control.


🚀 Getting Started
Clone the repo:
git clone https://github.com/yourusername/NYTimesMostViewed.git
cd NYTimesMostViewed
Open the project in Xcode:
open NYTimesMostViewed.xcodeproj
Make sure the dependencies load via Swift Package Manager (SDWebImageSwiftUI should auto-resolve).
Add your NYT API key as shown above.
Build and run on iOS Simulator or device.
🧪 Running Tests
All unit tests are written using XCTest.
To run tests:

Open the project in Xcode
Use Cmd + U to run the entire test suite

📁 Project Structure
NYTimesMostViewed/
├── Models/
├── Views/
├── ViewModels/
├── Services/
├── Persistence/
├── Resources/
│   └── Assets.xcassets
├── Tests/
│   ├── UnitTests/
└── README.md


👨‍💻 Author
Jeslin Johnson
