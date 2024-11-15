import Foundation

protocol GetAssetDetailsStatus {
    func execute() async throws -> Result<AssetDetailsResponse, UseCaseError>
}

struct GetAssetDetailsUseCases: GetAssetDetailsStatus {
    var repo: GetAssetDetailsRepository
    
    func execute() async throws -> Result<AssetDetailsResponse, UseCaseError> {
        do {
            let result = try await repo.getAssetDetails()
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
