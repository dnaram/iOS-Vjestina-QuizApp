//
//  FilterSettings.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.06.2021..
//

struct FilterSettings {
    
    let searchText: String?
    
    init(searchText: String? = nil, price: String? = nil) {
        self.searchText = (searchText?.isEmpty ?? true) ? nil : searchText
    }
}
