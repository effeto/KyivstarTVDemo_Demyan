import Foundation

enum APIServiceError: Error{
    case badUrl, requestError, decodingError, statusNotOK, tokenExpired
}
