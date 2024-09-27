//
//  QuizNetworkDataSource.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.06.2021..
//

class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {
    
    func fetchQuizzesFromNetwork() -> [Quiz] {
        return NetworkService().getQuizzes()
    }
}
