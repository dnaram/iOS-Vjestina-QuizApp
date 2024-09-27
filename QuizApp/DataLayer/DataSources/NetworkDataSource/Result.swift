//
//  Result.swift
//  QuizApp
//
//  Created by Andrea Stanic on 16.05.2021..
//
enum Result<Success, Failure> where Failure : Error {
    
    /// A success, storing a 'Success' value.
    case success(Success)
    
    /// A failure, storing a 'Failure' value.
    case failure(Failure)
}
