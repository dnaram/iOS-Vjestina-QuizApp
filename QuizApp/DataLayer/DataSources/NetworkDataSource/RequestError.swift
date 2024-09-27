//
//  RequestError.swift
//  QuizApp
//
//  Created by Andrea Stanic on 16.05.2021..
//
enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case dataDecodingError
}
