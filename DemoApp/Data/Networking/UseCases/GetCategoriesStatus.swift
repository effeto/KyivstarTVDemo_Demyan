import Foundation

protocol GetCategoriesStatus {
    func execute() async throws -> Result<CategoriesDataResponse, UseCaseError>
}

struct GetCategoriesUseCases: GetCategoriesStatus {
    var repo: GetCategoriesRepository
    
    func execute() async throws -> Result<CategoriesDataResponse, UseCaseError> {
        do {
            let result = try await repo.getCategories()
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
