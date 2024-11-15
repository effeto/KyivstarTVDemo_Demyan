import Foundation

protocol GetPromotionsStatus {
    func execute() async throws -> Result<PromotionDataResponse, UseCaseError>
}

struct GetPromotionsUseCases: GetPromotionsStatus {
    var repo: GetPromotionsRepository
    
    func execute() async throws -> Result<PromotionDataResponse, UseCaseError> {
        do {
            let result = try await repo.getPromotions()
            return .success(result)
        } catch(let error) {
            switch(error) {
            case APIServiceError.decodingError:
                return .failure(.decodingError)
            case APIServiceError.tokenExpired:
                return .failure(.tokenExpired)
            default:
                return .failure(.networkError)
            }
        }
    }
}
