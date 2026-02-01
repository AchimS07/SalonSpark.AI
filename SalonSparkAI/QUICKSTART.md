# Quick Start Guide - SalonSparkAI iOS

## 🚀 Getting Started in 3 Steps

### Step 1: Open the Project
**Method A - Double Click:**
- Locate `SalonSparkAI.xcodeproj` in Finder
- Double-click to open in Xcode

**Method B - From Xcode:**
- Launch Xcode
- File → Open
- Select `SalonSparkAI.xcodeproj`

### Step 2: Choose Your Target
In Xcode toolbar, select a simulator:
- iPhone 15 Pro (recommended)
- iPhone 15
- iPad Pro
- Or any connected iOS device

### Step 3: Run the App
Press **⌘R** (Command + R) or click the Play ▶️ button

## ✨ What You'll See

1. **Onboarding Screen** - Swipe through 3 welcome pages
2. **Dashboard** - View salon statistics and insights
   - Today's bookings and revenue
   - Empty time slots
   - AI-powered recommendations
   - Upcoming appointments

## 🎯 Key Features to Try

### Stats Cards
- View today's bookings and revenue
- Track new clients and fill rate
- See positive trends with arrow indicators

### Quick Actions
- New Booking
- AI Post Generation
- Analytics
- Add Client

### Empty Slots
- View available time slots
- Tap "Promote" to generate AI promotions

### AI Insights
- Flash sale opportunities
- Content posting recommendations
- Optimal posting times

## 📱 Project Structure

```
SalonSparkAI/
├── Views/              # All screen layouts
├── ViewModels/         # Business logic
├── Models/             # Data structures
└── Components/         # Reusable UI elements
```

## 🛠️ Customization Tips

### Change Mock Data
Edit these files to customize sample data:
- `Models/Appointment.swift` - Appointment list
- `Models/EmptySlot.swift` - Available time slots
- `Models/AIInsight.swift` - AI recommendations

### Modify Stats
Edit `ViewModels/DashboardViewModel.swift`:
```swift
let todaysBookings = 8  // Change this number
let revenue = "$485"    // Change revenue
let salonName = "Luxe Beauty Studio"  // Your salon name
```

### Update Colors
1. Open `Assets.xcassets`
2. Select `AccentColor`
3. Choose your brand color

## 🔧 Common Issues

**Issue:** "Cannot find SalonSparkAIApp in scope"
**Solution:** Build the project (⌘B) first

**Issue:** "Signing requires a development team"
**Solution:** 
1. Select project in navigator
2. Select target
3. Signing & Capabilities tab
4. Choose your Apple ID team

**Issue:** Simulator won't launch
**Solution:** Xcode → Preferences → Locations → Command Line Tools (select version)

## 📚 Learn More

### SwiftUI Preview
See live previews without running the app:
- Open any View file
- Press **⌘⌥⏎** (Cmd + Opt + Enter)
- Click Resume/Play in Canvas

### Hot Reload
SwiftUI supports live preview updates:
- Make changes to your code
- Preview updates automatically
- No need to rebuild!

## 🎨 Customization Roadmap

**Beginner:**
- [ ] Change salon name and stats
- [ ] Modify colors in Assets
- [ ] Update SF Symbol icons

**Intermediate:**
- [ ] Add new quick action buttons
- [ ] Create additional stats cards
- [ ] Customize onboarding pages

**Advanced:**
- [ ] Integrate with real API
- [ ] Add data persistence
- [ ] Implement authentication

## 💡 Pro Tips

1. **Use Live Preview** - Fastest way to see changes
2. **SF Symbols App** - Download from Apple to browse 5000+ icons
3. **Xcode Shortcuts:**
   - ⌘R - Run app
   - ⌘B - Build project
   - ⌘. - Stop running
   - ⌘/ - Comment/uncomment
   - ⌘⇧O - Open quickly (search files)

## 🆘 Need Help?

**Xcode Not Working?**
- Restart Xcode
- Clean build folder (⌘⇧K)
- Delete derived data (Xcode → Preferences → Locations)

**Simulator Issues?**
- Device → Erase All Content and Settings
- Restart Mac

## 📖 Next Steps

1. ✅ Run the app successfully
2. ✅ Explore all features
3. ✅ Modify mock data
4. 📝 Read full README.md for details
5. 🔨 Start customizing for your needs

## 🎓 Learning Resources

- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Swift Documentation](https://docs.swift.org/swift-book/)
- [Apple Design Guidelines](https://developer.apple.com/design/)

---

**Ready to build something amazing? Press ⌘R and let's go! 🚀**
