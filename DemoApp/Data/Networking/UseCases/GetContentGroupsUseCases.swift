import Foundation

protocol GetContentGroupsStatus {
    func execute() async throws -> Result<[ContentGroupsResponse], UseCaseError>
}

struct GetContentGroupsUseCases: GetContentGroupsStatus {
    var repo: GetContentGroupsRepository
    
    func execute() async throws -> Result<[ContentGroupsResponse], UseCaseError> {
        do {
            let result = try await repo.getContentGroups()
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




