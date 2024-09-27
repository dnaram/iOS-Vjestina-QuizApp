//
//  NetworkService.swift
//  QuizApp
//
//  Created by Andrea Stanic on 16.05.2021..
//

import Foundation

class NetworkService {
    
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping
                            (Result<T, RequestError>) -> Void) {
        
        // stvaranje URLSessionData task objekta i pozivanje funkcije dataTask()
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            // radi provjeru o postojanju grešaka s klijenta i poslužitelja
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noDataError))
                }
                return
            }
            
            // dohvaćeni podatci se pokušavaju dekodirati u tekst
            guard let value = try? JSONDecoder().decode(T.self, from: data)
            else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.dataDecodingError))
                }
                return
            }
            
            // u slučaju uspjeha, klozuri se predaju dekodirani podaci, bez greške
            DispatchQueue.main.async {
                completionHandler(.success(value))
            }
        }
        
        // pozivanje funkcije resume() kako bi se zadatak započeo
        return dataTask.resume()
    }
    
    func getQuizzes() -> [Quiz] {
            let group = DispatchGroup()
            var quizzes: [Quiz] = []
            guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else { return []}
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            group.enter()
            DispatchQueue.global().async {
                NetworkService().executeUrlRequest(request) { (result: Result<QuizzesResponse, RequestError>) in
                    switch result {
                    case.failure(let error):
                        print(error)
                        return
                    case.success(let value):
                        quizzes = value.quizzes
                        print(quizzes)
                    }
                    group.leave()
                }
            }
            group.wait()
            return quizzes
        }
    
}
