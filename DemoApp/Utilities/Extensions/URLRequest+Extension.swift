import Foundation

extension URLRequest {
    init(_ url: URL) {
        let token: String =  "b3kgsqs1kqytlpact6fhh6pd8grvdj7kqm0nkvd1" //bad practice, in normal way i will save it in KeyChainManager
        self.init(url: url)
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("Bearer " + (token ), forHTTPHeaderField: "Authorization")
    }
        
    var method: HttpMethodsEnum? {
        get {
            guard let method = self.httpMethod else { return nil }
            return HttpMethodsEnum(rawValue: method)
        }
        set {
            self.httpMethod = newValue?.rawValue
        }
    }
}

enum HttpMethodsEnum: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
