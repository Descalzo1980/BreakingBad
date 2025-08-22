//
//  ViewModel.swift
//  BreakingBad
//
//  Created by Станислав Леонов on 22.08.2025.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    enum FetchStatus {
        case notStaring
        case fetching
        case success
        case failed(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStaring
    
    private let fetcher = FetchService()
    
    var quote: Quote
    
    var character: Char
    
    init(status: FetchStatus, quote: Quote, character: Char) {
        self.status = status
        self.quote = quote
        self.character = character
    }
}
