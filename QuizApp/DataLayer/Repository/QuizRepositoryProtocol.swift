//
//  QuizRepositoryProtocol.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.06.2021..
//

protocol QuizRepositoryProtocol {
    
    func fetchRemoteData() throws
    func fetchLocalData(filter: FilterSettings) -> [Quiz]
    func deleteLocalData(withId id: Int)
}
