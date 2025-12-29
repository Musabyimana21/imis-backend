# 📍 Location Picker Feature - IMIS

## Overview
Interactive location selection using **Leaflet.js** with **OpenStreetMap** tiles, optimized for Rwanda.

## ✨ Features

### 🗺️ Interactive Map
- **Real Rwanda Map** - OpenStreetMap tiles showing actual Rwanda geography
- **Click to Select** - Click anywhere on the map to set location
- **Drag Marker** - Drag the red marker to adjust position
- **Zoom Controls** - Zoom in/out for precise location selection
- **Rwanda Bounds** - Map restricted to Rwanda territory

### 📍 Location Methods

#### 1. Manual Entry
- Type location name directly (e.g., "Kigali City Market")
- Coordinates auto-update when using map

#### 2. GPS Auto-Detect
- Click "📍 GPS" button
- Browser requests location permission
- Automatically centers map on your location
- High accuracy mode enabled

#### 3. Map Selection
- Click "🗺️ Select on Map" button to show/hide map
- Click anywhere on Rwanda map
- Marker appears at selected location
- Location name auto-fills via reverse geocoding

### 🔄 Reverse Geocoding
- Automatically converts coordinates to readable addresses
- Uses OpenStreetMap Nominatim API
- Shows: Road, Suburb, City, State
- Fallback to coordinates if address unavailable

## 🎯 User Experience

### Report Lost Item Flow
1. Fill in item details
2. Scroll to "Location" section
3. Choose location method:
   - Type location name, OR
   - Click GPS button, OR
   - Click "Select on Map" and click location
4. Location name and coordinates auto-fill
5. Submit form

### Report Found Item Flow
Same as above, optimized for "Where did you find it?"

## 🛠️ Technical Details

### Component: LocationPicker.svelte
```javascript
Props:
- latitude: number (default: -1.9536 - Kigali)
- longitude: number (default: 30.0606 - Kigali)
- locationName: string
- label: string (customizable label)

Events:
- locationChange: { latitude, longitude, locationName }
```

### Dependencies
- **Leaflet.js 1.9.4** - Loaded dynamically from CDN
- **OpenStreetMap** - Free tile provider
- **Nominatim API** - Reverse geocoding

### Rwanda Configuration
```javascript
RWANDA_BOUNDS = [
  [-2.84, 28.86],  // Southwest corner
  [-1.05, 30.90]   // Northeast corner
]

DEFAULT_CENTER = [-1.9536, 30.0606]  // Kigali
DEFAULT_ZOOM = 13
```

## 📱 Browser Compatibility

### GPS Feature Requirements
- HTTPS connection (or localhost for testing)
- User permission for geolocation
- Modern browser (Chrome, Firefox, Safari, Edge)

### Map Feature
- Works on all modern browsers
- Responsive design (mobile & desktop)
- Touch-friendly on mobile devices

## 🚀 Quick Test

### Start System
```bash
TEST_LOCATION_FEATURE.bat
```

### Test Steps
1. Navigate to http://localhost:5173/report-lost
2. Scroll to "Location" section
3. Click "🗺️ Select on Map"
4. Click anywhere on Rwanda map
5. Verify:
   - ✅ Marker appears at clicked location
   - ✅ Location name auto-fills
   - ✅ Coordinates display below
   - ✅ Can drag marker to adjust
   - ✅ GPS button works (if permission granted)

## 🎨 UI Features

### Visual Elements
- 400px height map container
- Rounded corners with border
- Loading spinner for GPS
- Show/Hide map toggle
- Coordinate display
- Helpful instructions

### Accessibility
- Keyboard navigation support
- Screen reader friendly labels
- Clear button states
- Error messages for GPS failures

## 🔧 Configuration Options

### Map Settings
```javascript
maxBounds: RWANDA_BOUNDS,
maxBoundsViscosity: 1.0,  // Prevent panning outside Rwanda
maxZoom: 18,              // Street level
minZoom: 8                // Country level
```

### GPS Settings
```javascript
enableHighAccuracy: true,
timeout: 10000,           // 10 seconds
maximumAge: 0             // No cached positions
```

## 📊 Data Flow

### Location Selection
```
User Action → Map Click/GPS
    ↓
Update Coordinates
    ↓
Reverse Geocoding API
    ↓
Update Location Name
    ↓
Dispatch Event
    ↓
Update Form Data
    ↓
Submit to Backend
```

## 🌍 API Integration

### Reverse Geocoding
```javascript
URL: https://nominatim.openstreetmap.org/reverse
Parameters:
  - format: json
  - lat: latitude
  - lon: longitude
  - zoom: 18
  - addressdetails: 1
```

### Response Format
```json
{
  "address": {
    "road": "KN 4 Ave",
    "suburb": "Nyarugenge",
    "city": "Kigali",
    "state": "Kigali City"
  },
  "display_name": "Full address string"
}
```

## 🎯 Best Practices

### For Users
1. **Use GPS** for current location (most accurate)
2. **Use Map** for specific known locations
3. **Zoom In** for precise selection
4. **Verify** location name before submitting

### For Developers
1. **Lazy Load** Leaflet.js (only when needed)
2. **Cleanup** map instance on component destroy
3. **Error Handling** for GPS and API failures
4. **Fallback** to coordinates if geocoding fails

## 🐛 Troubleshooting

### GPS Not Working
- **Check**: HTTPS or localhost
- **Check**: Browser permissions
- **Solution**: Use map selection instead

### Map Not Loading
- **Check**: Internet connection
- **Check**: CDN availability
- **Solution**: Refresh page

### Wrong Location Name
- **Cause**: Geocoding API limitations
- **Solution**: Manually edit location name

## 📈 Future Enhancements

### Potential Features
- [ ] Search locations by name
- [ ] Save favorite locations
- [ ] Show nearby landmarks
- [ ] Distance calculator
- [ ] Multiple markers for route
- [ ] Offline map support
- [ ] Custom map styles

## 🎓 Learning Resources

### Leaflet.js
- Official Docs: https://leafletjs.com/
- Tutorials: https://leafletjs.com/examples.html

### OpenStreetMap
- About: https://www.openstreetmap.org/about
- Tile Usage: https://operations.osmfoundation.org/policies/tiles/

### Nominatim API
- Docs: https://nominatim.org/release-docs/latest/
- Usage Policy: https://operations.osmfoundation.org/policies/nominatim/

## 📞 Support

For issues with location feature:
1. Check browser console for errors
2. Verify internet connection
3. Test GPS permissions
4. Contact: gaudencemusabyimana21@gmail.com

---

**Built with ❤️ by MUSABYIMANA Gaudence | Rwanda 🇷🇼 | 2025**
