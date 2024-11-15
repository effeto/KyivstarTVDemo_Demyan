import Foundation

struct AssetDetailsResponse: Codable, Identifiable {
    let id: String?
    let name: String?
    let image: URL?
    let company: String?
    let similar: [SimilarItem]?
    let duration: Int?
    let progress: Int?
    let purchased: Bool?
    let updatedAt: String?
    let description: String?
    let releaseDate: String?
}

struct SimilarItem: Codable {
    let id: String?
    let name: String?
    let image: URL?
    let company: String?
    let progress: Int?
    let purchased: Bool?
    let updatedAt: String?
    let releaseDate: String?
}
