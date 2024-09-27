//
//  QuizCoreDataSourceProtocol.swift
//  QuizApp
//
//  Created by Andrea Stanic on 06.06.2021..
//

protocol QuizCoreDataSourceProtocol {

    func fetchQuizzesFromCoreData(filter: FilterSettings) -> [Quiz]
    func saveNewQuizzes(_ quizzes: [Quiz])
    func deleteQuiz(withId id: Int)

}
