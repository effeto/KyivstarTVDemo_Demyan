import SwiftUI

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cleanedHex.hasPrefix("#") {
            cleanedHex.removeFirst()
        }

  
        var rgbValue: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
