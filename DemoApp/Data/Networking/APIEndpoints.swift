import Foundation

enum APIEndpoint {
    case getContentGroups
    case getPromotions
    case getCategories
    case getAssetDetails
    
    var url: String {
        switch self {
        case .getContentGroups: 
            return "\(APIService.baseUrl)/PGgg02gplft-/data"
        case .getPromotions:
            return "\(APIService.baseUrl)/j_BRMrbcY-5W/data"
        case .getCategories:
            return "\(APIService.baseUrl)/eO-fawoGqaNB/data"
        case .getAssetDetails:
            return "\(APIService.baseUrl)/04Pl5AYhO6-n/data"
        }
    }
}
