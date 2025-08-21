//
//  FetchService.swift
//  BreakingBad
//
//  Created by Станислав Леонов on 21.08.2025.
//

import Foundation

struct FetchService {
    enum FetchError: Error {
        case badResponce
    }
    
    let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteURL = baseUrl.appending(path: "qoutes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        let(data, response) = try await URLSession.shared.data(from: fetchURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponce
        }
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        return quote
    }
}
