//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.06.2021..
//

class QuizRepository {
    
    private let networkDataSource: QuizNetworkDataSourceProtocol
    private let databaseDataSource: QuizCoreDataSourceProtocol
    
    init(networkDataSource: QuizNetworkDataSourceProtocol, databaseDataSource: QuizCoreDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.databaseDataSource = databaseDataSource
    }
    
    func fetchRemoteData() throws {
        let quizzes = networkDataSource.fetchQuizzesFromNetwork()
        databaseDataSource.saveNewQuizzes(quizzes)
    }

    func fetchLocalData(filter: FilterSettings) -> [Quiz] {
        databaseDataSource.fetchQuizzesFromCoreData(filter: filter)
    }

    func deleteLocalData(withId id: Int) {
        databaseDataSource.deleteQuiz(withId: id)
    }
}


