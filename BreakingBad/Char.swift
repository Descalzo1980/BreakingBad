//
//  Char.swift
//  BreakingBad
//
//  Created by Станислав Леонов on 21.08.2025.
//

import Foundation

struct Char: Decodable {
    let name: String
    let bithday: String
    let occupation: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death?
    
    enum CodingKeys: CodingKey {
        case name
        case bithday
        case occupation
        case images
        case aliases
        case status
        case portrayedBy
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.bithday = try container.decode(String.self, forKey: .bithday)
        self.occupation = try container.decode([String].self, forKey: .occupation)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        
        
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deathData = try Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        death = try deathDecoder.decode(Death.self, from: deathData)
    }
}
