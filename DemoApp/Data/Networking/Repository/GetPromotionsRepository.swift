import Foundation

protocol GetPromotionsRepository {
    func getPromotions() async throws -> PromotionDataResponse
}

struct GetPromotionsRepositoryImpl: GetPromotionsRepository {
    
    var dataSource: GetPromotionsDataSource
    
    func getPromotions() async throws -> PromotionDataResponse {
        let result = try await dataSource.getPromotions()
        return result
    }
}
