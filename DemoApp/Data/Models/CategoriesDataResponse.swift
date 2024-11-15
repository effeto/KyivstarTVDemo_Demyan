import Foundation

struct CategoriesDataResponse: Codable {
    let categories: [Category]?
}

struct Category: Codable, Equatable, Hashable, Identifiable {
    let id: String?
    let name: String?
    let image: URL?
}
