import Foundation

protocol GetAssetDetailsRepository {
    func getAssetDetails() async throws -> AssetDetailsResponse
}

struct GetAssetDetailsRepositoryImpl: GetAssetDetailsRepository {
    
    var dataSource: GetAssetDetailsDataSource
    
    func getAssetDetails() async throws -> AssetDetailsResponse {
        let result = try await dataSource.getAssetDetails()
        return result
    }
}
