import Foundation

struct ContentGroupsResponse: Codable, Identifiable {
    let id: String?
    let name: String?
    let type: [ContentType]
    let assets: [Asset]
    let hidden: Bool?
    let sortIndex: Int?
    let canBeDeleted: Bool?
    
    enum ContentType: String, Codable, Equatable {
        case epg = "EPG"
        case livechannel = "LIVECHANNEL"
        case movies = "MOVIE"
        case series = "SERIES"
        case noNeedToDisplay = "NO_NEED_TO_DISPLAY"
    }
}


struct Asset: Codable, Equatable, Hashable, Identifiable {
    let id: String?
    let name: String?
    let image: URL?
    let company: String?
    let progress: Int?
    let purchased: Bool?
    let sortIndex: Int?
    let updatedAt: String?
    let releaseDate: String?
}
