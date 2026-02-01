# SalonSparkAI - iOS Swift Version

## Overview
This is a native iOS application converted from the original React/TypeScript web application. The app provides AI-powered salon management features including:

- Dashboard with key business metrics
- Appointment management
- AI-generated insights for business optimization
- Empty slot promotion
- Revenue tracking
- Client management

## Project Structure

```
SalonSparkAI/
├── SalonSparkAI.xcodeproj/          # Xcode project file
└── SalonSparkAI/                     # Main app directory
    ├── SalonSparkAIApp.swift         # App entry point
    ├── Views/                        # SwiftUI views
    │   ├── ContentView.swift         # Main content view (like Index.tsx)
    │   ├── OnboardingView.swift      # Onboarding flow
    │   └── DashboardView.swift       # Main dashboard
    ├── ViewModels/                   # View models (business logic)
    │   └── DashboardViewModel.swift  # Dashboard state management
    ├── Models/                       # Data models
    │   ├── Appointment.swift         # Appointment data model
    │   ├── EmptySlot.swift          # Empty slot data model
    │   └── AIInsight.swift          # AI insight data model
    ├── Components/                   # Reusable UI components
    │   ├── HeaderView.swift         # Header component
    │   └── StatsCardView.swift      # Stats card component
    ├── Assets.xcassets/             # App assets and icons
    └── Preview Content/             # Preview assets for SwiftUI
```

## Key Conversion Notes

### Architecture Changes
- **React → SwiftUI**: The component-based React architecture has been converted to SwiftUI views
- **TypeScript → Swift**: All TypeScript code converted to Swift with strong typing
- **State Management**: React hooks (useState, useEffect) converted to SwiftUI's @State, @StateObject, and @Published properties
- **Routing**: React Router replaced with SwiftUI's NavigationView and conditional rendering

### Technology Stack
**Original (Web):**
- React
- TypeScript
- Vite
- Tailwind CSS
- shadcn-ui
- React Query

**Converted (iOS):**
- SwiftUI (native iOS UI framework)
- Swift (native programming language)
- MVVM Architecture (Model-View-ViewModel)
- Combine Framework (for reactive programming)

### UI/UX Adaptations
- **Responsive Design**: Optimized for iPhone and iPad screens
- **Native Components**: Using native iOS design patterns and SF Symbols
- **Gestures**: Touch-optimized interactions
- **Navigation**: iOS-style navigation patterns
- **Animations**: SwiftUI animations instead of CSS transitions

### Features Implemented
✅ Onboarding flow with page indicators
✅ Dashboard with stats cards
✅ Quick actions menu
✅ Empty slots management
✅ AI insights display
✅ Upcoming appointments list
✅ Toast notifications
✅ Gradient backgrounds
✅ Responsive layout

### Features to Implement (Future Enhancements)
- [ ] API integration for real data
- [ ] User authentication
- [ ] Calendar integration
- [ ] Push notifications
- [ ] Data persistence (Core Data or SwiftData)
- [ ] Client profile management
- [ ] Booking flow
- [ ] Payment processing
- [ ] Analytics dashboard
- [ ] Social media integration

## Requirements
- Xcode 15.0 or later
- iOS 17.0 or later
- macOS Ventura or later (for development)

## How to Open and Run

### Option 1: Using Xcode
1. Open Xcode
2. Select "Open a project or file"
3. Navigate to the `SalonSparkAI.xcodeproj` file
4. Click "Open"
5. Select a simulator or connected device
6. Press ⌘R (Command + R) to build and run

### Option 2: From Terminal
```bash
cd path/to/SalonSparkAI
open SalonSparkAI.xcodeproj
```

### Option 3: Double-click
Simply double-click the `SalonSparkAI.xcodeproj` file in Finder

## Building for Device
1. Open the project in Xcode
2. Select your development team in Signing & Capabilities
3. Connect your iOS device
4. Select your device from the device menu
5. Press ⌘R to build and run on device

## Code Structure

### Models
Data models use Swift structs with Identifiable protocol:
```swift
struct Appointment: Identifiable {
    let id: String
    let clientName: String
    let service: String
    let time: String
}
```

### ViewModels
Business logic and state management using ObservableObject:
```swift
class DashboardViewModel: ObservableObject {
    @Published var appointments: [Appointment]
    @Published var showToast = false
    // ...
}
```

### Views
SwiftUI views for the user interface:
```swift
struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        // UI code
    }
}
```

## Customization

### Colors
The app uses iOS system colors that automatically support light/dark mode. To customize:
- Open `Assets.xcassets`
- Add custom color sets
- Reference them in SwiftUI: `Color("CustomColor")`

### Icons
Uses SF Symbols for icons. To change icons:
- Visit https://developer.apple.com/sf-symbols/
- Find desired icon name
- Update icon names in code: `Image(systemName: "icon.name")`

## Testing
SwiftUI Preview is available for all views. To test:
1. Open any View file
2. Press ⌘⌥↩ (Command + Option + Enter) to show Canvas
3. Click "▶️" button in preview to interact with the view

## Known Limitations
- Mock data is currently used (no backend integration)
- No data persistence between app launches
- Simplified AI insights (would require actual ML integration)
- No real-time updates

## Next Steps for Production
1. **Backend Integration**
   - Connect to a REST API or GraphQL endpoint
   - Implement proper authentication (OAuth, JWT)
   - Add error handling and loading states

2. **Data Persistence**
   - Implement Core Data or SwiftData
   - Add offline mode support
   - Sync with server

3. **Advanced Features**
   - Implement actual AI/ML models
   - Add calendar sync (EventKit)
   - Integrate payment processing
   - Add push notifications

4. **Testing**
   - Write unit tests
   - Add UI tests
   - Implement snapshot testing

5. **App Store Preparation**
   - Create app icons (1024x1024)
   - Add launch screen
   - Prepare screenshots
   - Write app description

## Differences from Original Web App
1. **Native Performance**: Runs natively on iOS with better performance
2. **Offline Capability**: Can work offline (with proper data persistence)
3. **Native Integrations**: Access to iOS features (Calendar, Contacts, Notifications)
4. **Platform-Specific UI**: Uses iOS design patterns and guidelines
5. **Distribution**: Available through Apple App Store

## Support
For issues or questions about the iOS conversion, please refer to:
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Swift Programming Guide](https://docs.swift.org/swift-book/)

## License
This is a converted version of the original SalonSparkAI project. Please refer to the original project for licensing information.

## Credits
Original web application created with React/TypeScript
iOS conversion to Swift/SwiftUI completed February 2026
