import Foundation

extension Int {
    func toTimeString() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60

        if hours > 0 {
            if minutes > 0 {
                return "\(hours)h \(minutes)m"
            } else {
                return "\(hours)h"
            }
        } else if minutes > 0 {
            return "\(minutes)m"
        } else {
            return ""
        }
    }
}
