//
//  FetchService.swift
//  BreakingBad
//
//  Created by Станислав Леонов on 21.08.2025.
//

import Foundation

extension GlobalEnvironment {
    private static func obtainProperty(for key: Keys) -> String {
        guard let property = Bundle.main.object(
            forInfoDictionaryKey: key.rawValue
        ) as? String else {
            fatalError("\(key.rawValue) property undefined")
        }
        return property
    }
}

extension GlobalEnvironment {
    static let baseUrl: String = {
        obtainProperty(for: .urlHost)
    }()
}

public struct GlobalEnvironment {
    enum Keys: String {
        case urlHost = "BASE_URL"
    }
}

struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseUrl = URL(string: GlobalEnvironment.baseUrl)!
    
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteURL = baseUrl.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        let(data, response) = try await URLSession.shared.data(from: fetchURL)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw FetchError.badResponse
        }
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Char {
        let characterURL = baseUrl.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        let(data, response) = try await URLSession.shared.data(from: fetchURL)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw FetchError.badResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let characters = try decoder.decode([Char].self, from: data)
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let deathUrl = baseUrl.appending(path: "deaths")
        
        let(data, response) = try await URLSession.shared.data(from: deathUrl)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw FetchError.badResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deaths = try decoder.decode([Death].self, from: data)
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        return nil
    }
}
