import Foundation

protocol GetContentGroupsRepository {
    func getContentGroups() async throws -> [ContentGroupsResponse]
}

struct GetContentGroupsRepositoryImpl: GetContentGroupsRepository {
    
    var dataSource: GetContentGroupsDataSource
    
    func getContentGroups() async throws -> [ContentGroupsResponse] {
        let result = try await dataSource.getContentGroups()
        return result
    }
}
