import Foundation

enum UseCaseError: Error {
    case networkError, decodingError, validationError, tokenExpired
}
