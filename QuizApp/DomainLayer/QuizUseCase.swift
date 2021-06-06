//
//  QuizUseCase.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.06.2021..
//
import Reachability

final class QuizUseCase {
    
    private let quizRepository: QuizRepositoryProtocol
    
    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }
    
    func refreshData() throws {
        guard let r = Reachability(hostname: "https://www.google.com") else { return }
        switch r.currentReachabilityStatus() {
        case .ReachableViaWWAN, .ReachableViaWiFi:
            try quizRepository.fetchRemoteData()
            break
        default:
            break
        }
    }
    
    func getQuizzes(filter: FilterSettings) -> [Quiz] {
        quizRepository.fetchLocalData(filter: filter)
    }
    
    func deleteQuiz(withId id: Int) {
        quizRepository.deleteLocalData(withId: id)
    }
}