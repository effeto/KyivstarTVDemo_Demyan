import Foundation

protocol GetCategoriesDataSource {
    func getCategories() async throws -> CategoriesDataResponse
}

struct GetCategoriesAPIImplamentation: GetCategoriesDataSource {
    
    func getCategories() async throws -> CategoriesDataResponse {
        guard let url = URL(string: "\(APIEndpoint.getCategories.url)") else {
            throw APIServiceError.badUrl
        }
        
        print(url)
        
        var request = URLRequest(url)
        request.method = .get
        
        guard let (data, response) = try? await URLSession.shared.data(for: request), let httpResponse = response as? HTTPURLResponse else {
            print("Data request error")
            throw APIServiceError.requestError
        }
        
        if httpResponse.statusCode != 200 {
            print("Status code error: \(httpResponse.statusCode)")
            if let utf8String = String(data: data, encoding: .utf8) {
                print(utf8String)
            }
            throw APIServiceError.statusNotOK
        } else if httpResponse.statusCode == 401 {
            throw APIServiceError.tokenExpired
        }
        
        do {
            let result = try JSONDecoder().decode(CategoriesDataResponse.self, from: data)
            return result
        } catch let error {
            print("Error decoding JSON: \(error)")
            throw APIServiceError.decodingError
        }
    }
}
