import Foundation

class APIService {
    static let baseUrl: String = {
        if let url = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String, !url.isEmpty {
            return url
        } else {
            print("Warning: API_URL is missing or invalid in Info.plist. Using default value.")
            return ""
        }
    }()
}
