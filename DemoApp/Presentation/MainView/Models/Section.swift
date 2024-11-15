
enum Section: Hashable {
    case logo
    case promotions
    case category
    case moviesSeries(String, canBeDeleted: Bool) 
    case liveChannel(String, canBeDeleted: Bool)
    case epg(String, canBeDeleted: Bool)
    
    var name: String? {
        switch self {
        case .logo: return nil
        case .promotions: return nil
        case .category: return "Категорії:"
        case .moviesSeries: return "Новинки Київстар ТБ"
        case .liveChannel: return "Дитячі телеканали"
        case .epg: return "Пізнавальні"
        }
    }
    
    var isAsset: Bool {
        switch self {
        case .moviesSeries, .liveChannel, .epg:
            return true
        default:
            return false
        }
    }
    
    var canBeDeleted: Bool {
        switch self {
        case .moviesSeries(_, let canBeDeleted),
             .liveChannel(_, let canBeDeleted),
             .epg(_, let canBeDeleted):
            return canBeDeleted
        default:
            return false
        }
    }
}
