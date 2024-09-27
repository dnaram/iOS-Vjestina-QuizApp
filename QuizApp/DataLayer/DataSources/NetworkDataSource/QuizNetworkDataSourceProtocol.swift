//
//  QuizNetworkDataSourceProtocol.swift
//  QuizApp
//
//  Created by Andrea Stanic on 06.06.2021..
//

protocol QuizNetworkDataSourceProtocol {
    func fetchQuizzesFromNetwork() -> [Quiz]
}
