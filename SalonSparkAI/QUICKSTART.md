# 🚀 Quick Start Guide - SalonSparkAI

Get up and running in 3 minutes!

## ⚡ Super Quick Start

1. **Open** `SalonSparkAI.xcodeproj` 
2. **Select** iPhone 15 Pro simulator
3. **Press** ⌘R (or click ▶️ Play button)

That's it! The app will launch and show onboarding.

## 📱 What You'll See

### Step 1: Onboarding (First Launch)
- 4 beautiful feature pages
- Swipe to navigate
- Tap "Skip" or "Get Started"

### Step 2: Dashboard
After onboarding, you'll see:

**Stats Section** (Top)
- Today's Bookings: 5 appointments
- Revenue: $485
- New Clients: 12 this week
- Fill Rate: 76%

**Quick Actions** (4 buttons)
- New Booking
- Campaign
- Offer
- Post

**Empty Slots** (3 available)
- 10:00 AM - 1 hour
- 2:00 PM - 30 min
- 4:30 PM - 45 min

**AI Insights** (4 suggestions)
- Flash Sale Opportunity
- Post Trending Content
- Best Posting Time
- Loyalty Reward

**Coming Up** (Next 3 appointments)
- Sarah Johnson - Hair Color & Cut - 9:00 AM
- Emma Williams - Balayage - 11:30 AM
- Olivia Brown - Blowout - 1:00 PM

**Bottom Navigation** (5 tabs)
- Home (active)
- Schedule
- AI Boost (with pulse indicator)
- Clients
- Settings

## 🎮 Try These Features

### Interactive Elements
✅ **Tap any Quick Action button** - See toast notification  
✅ **Tap "Promote" on empty slot** - AI generates promotion  
✅ **Tap "AI Promote All"** - Batch promotion  
✅ **Tap any AI insight action** - Process AI suggestion  
✅ **Pull down to refresh** - Reload data  
✅ **Tap search icon** - Open search (coming soon)  
✅ **Tap notifications bell** - View notifications (coming soon)  
✅ **Tap bottom nav tabs** - Switch sections  

### Animations to Notice
- Floating icon on onboarding
- Fade-up animations in lists
- Scale effect on button press
- Toast slide-up from bottom
- Progress dots morphing
- Tab indicator sliding

## 🎨 Customization Examples

### Change Your Salon Name
```swift
// File: DashboardViewModel.swift (line ~24)
let salonName = "Your Salon Name Here"
```

### Update Revenue
```swift
// File: DashboardViewModel.swift (line ~31)
let revenue = "$999"
```

### Change Accent Color
```swift
// File: Assets.xcassets/AccentColor.colorset/Contents.json
// Change RGB values
"red" : "1.000",  // 0.0 to 1.0
"green" : "0.200",
"blue" : "0.400"
```

### Add Your Own Quick Action
```swift
// File: Models/QuickAction.swift (line ~18)
QuickAction(id: "report", icon: "chart.bar", label: "Reports", color: .purple)
```

## 🐛 Troubleshooting

**App won't build?**
- Clean build folder: ⌘⇧K
- Restart Xcode
- Check all files are in project

**Simulator too slow?**
- Use iPhone 15 Pro (best performance)
- Restart simulator
- Close other apps

**Can't see onboarding?**
```swift
// File: ContentView.swift (line ~11)
@AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
// Change to: = false to see onboarding again
```

**Toast not showing?**
- Check console for errors
- Toast auto-hides after 2.5 seconds
- Try another action to trigger it

## 📖 Key Files Reference

| File | Purpose |
|------|---------|
| `ContentView.swift` | App entry, onboarding logic |
| `OnboardingView.swift` | 4-page onboarding flow |
| `DashboardView.swift` | Main screen layout |
| `DashboardViewModel.swift` | All business logic & data |
| `StatsCardView.swift` | Stat card component |
| `ColorExtensions.swift` | Custom colors |
| `ViewExtensions.swift` | Animations & modifiers |

## 🎯 Common Tasks

### Reset Onboarding
1. Delete app from simulator
2. Or edit `ContentView.swift` line 11 to `= false`

### Change Mock Data
Edit these files in `Models/`:
- `Appointment.swift` - Change appointments
- `EmptySlot.swift` - Change empty slots
- `AIInsight.swift` - Change AI suggestions

### Test Empty State
```swift
// File: DashboardViewModel.swift (line ~14)
@Published var emptySlots: [EmptySlot] = []  // Empty array
```

### Add More Appointments
```swift
// File: Models/Appointment.swift (line ~21)
Appointment(id: "6", clientName: "Your Name", service: "Haircut", time: "7:00 PM")
```

## ⚙️ Xcode Tips

**Shortcuts:**
- ⌘R - Run
- ⌘B - Build
- ⌘. - Stop
- ⌘⇧K - Clean
- ⌘⌥⏎ - Show Canvas/Preview
- ⌘/ - Comment/Uncomment

**Canvas (Live Preview):**
1. Open any View file
2. Press ⌘⌥⏎
3. Click Resume/Play
4. Interact with preview!

**Multiple Previews:**
```swift
#Preview("Light Mode") {
    DashboardView()
}

#Preview("With Data") {
    DashboardView()
        .environment(\.locale, .init(identifier: "en"))
}
```

## 🎨 Design Tokens

**Corner Radius:**
- Small: 8-10pt
- Medium: 12-14pt  
- Large: 16pt
- Extra Large: 24pt

**Padding:**
- Tight: 8pt
- Normal: 12pt
- Comfortable: 16pt
- Spacious: 20-24pt

**Icon Sizes:**
- Small: 14-16pt
- Medium: 18-20pt
- Large: 24-28pt
- Hero: 48-64pt

## 🚦 Next Steps

1. ✅ Run the app
2. ✅ Explore all features
3. ✅ Try customizing colors
4. ✅ Add your salon name
5. ✅ Modify mock data
6. 📚 Read full README.md
7. 🔨 Start building your features!

## 💡 Pro Tips

1. **Use SwiftUI Preview** - Fastest development workflow
2. **Check ViewModel first** - All logic is there
3. **Copy-paste components** - They're all reusable
4. **Follow MVVM** - Keep views simple, logic in ViewModels
5. **Read inline comments** - Code is well-documented

---

**Ready to code? Press ⌘R and have fun! 🎉**

Questions? Check README.md for full documentation.
