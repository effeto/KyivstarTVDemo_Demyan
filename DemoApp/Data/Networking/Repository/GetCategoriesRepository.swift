import Foundation

protocol GetCategoriesRepository {
    func getCategories() async throws -> CategoriesDataResponse
}

struct GetCategoriesRepositoryImpl: GetCategoriesRepository {
    
    var dataSource: GetCategoriesDataSource
    
    func getCategories() async throws -> CategoriesDataResponse {
        let result = try await dataSource.getCategories()
        return result
    }
}
