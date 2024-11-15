import Foundation

extension Array where Element == ContentGroupsResponse {
    // MARK: - Properties
    var moviesOrSeries: [Asset] {
        getAssetsWithPredicate { $0 == .movies || $0 == .series }
    }
    
    var epgs: [Asset] {
        getAssetsWithPredicate { $0 == .epg }
    }
    
    var liveChannels: [Asset] {
        getAssetsWithPredicate { $0 == .livechannel }
    }
    
    // MARK: - Helpers    
    private func getAssetsWithPredicate(_ predicate: (Element.ContentType) -> Bool) -> [Asset] {
        filter {
            $0.type.contains(where: predicate)
        }
        .map(\.assets)
        .joined()
        .toArray()
    }
}
