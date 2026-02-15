//
//  QuizAttempt.swift
//  ProbeMe
//


import Foundation

struct QuizAttempt: Codable, Identifiable {
    let id: UUID
    let quizId: String
    let quizTitle: String
    let attemptNumber: Int
    let date: Date
    let result: ResultType
    let chosenAnswerTexts: [String]

    var displayTitle: String {
        "\(quizTitle) #\(attemptNumber)"
    }
}

