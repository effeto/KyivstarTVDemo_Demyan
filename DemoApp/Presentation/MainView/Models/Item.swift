
enum Item: Equatable, Hashable {
    case logo
    case promotion(Promotion)
    case category(Category)
    case moviesSeries(Asset)
    case liveСhannels(Asset)
    case epg(Asset)
}

