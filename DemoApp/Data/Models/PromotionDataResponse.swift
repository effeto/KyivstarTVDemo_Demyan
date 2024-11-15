import Foundation

struct PromotionDataResponse: Codable, Equatable, Hashable, Identifiable {
    let id: String?
    let name: String?
    let promotions: [Promotion]?
}

struct Promotion: Codable, Equatable, Hashable, Identifiable {
    let id: String?
    let name: String?
    let image: URL?
    let company: String?
    let updatedAt: String?
    let releaseDate: String?
}



