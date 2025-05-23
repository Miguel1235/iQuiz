import Foundation

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
    case userNotFound
}

final class Api {
    static let shared = Api()
    private init() {}
    let baseUrl = "https://opentdb.com"
    
    func getApiQuestions(url: String) async -> Result<[Quiz],ApiError>  {
        guard let url = URL(string: url.isEmpty ? "\(baseUrl)/api.php?amount=10" : url) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            switch statusCode {
            case 404:
                return .failure(.userNotFound)
            case 200:
                let decodedResponse = try JSONDecoder().decode(ResponseQuiz.self, from: data)
                return .success(decodedResponse.results)
            default:
                return .failure(.invalidResponse)
            }
        } catch is DecodingError {
            return .failure(.invalidData)
        } catch {
            return .failure(.unableToComplete)
        }
    }
    
    func getCategories() async -> Result<[QuizCategory], ApiError> {
        guard let url = URL(string: "\(baseUrl)/api_category.php") else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            switch statusCode {
            case 404:
                return .failure(.userNotFound)
            case 200:
                let decodedResponse = try JSONDecoder().decode(QuizCategoryResponse.self, from: data)
                return .success(decodedResponse.triviaCategories)
            default:
                return .failure(.invalidResponse)
            }
            
        } catch is DecodingError {
            return .failure(.invalidData)
        } catch {
            return .failure(.unableToComplete)
        }
    }
}
