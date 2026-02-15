//
//  QuizHistoryStore.swift
//  ProbeMe

//

import Foundation

final class QuizHistoryStore {

    static let shared = QuizHistoryStore()

    private let key = "ProbeMe.quizHistory.v1"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }

    func load() -> [QuizAttempt] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? decoder.decode([QuizAttempt].self, from: data)) ?? []
    }

    func save(_ attempts: [QuizAttempt]) {
        guard let data = try? encoder.encode(attempts) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    func addAttempt(quiz: Quiz, chosenAnswers: [Answer], result: ResultType) {
        var all = load()
        let nextNumber = (all.filter { $0.quizId == quiz.id }.map(\.attemptNumber).max() ?? 0) + 1

        let attempt = QuizAttempt(
            id: UUID(),
            quizId: quiz.id,
            quizTitle: quiz.title,
            attemptNumber: nextNumber,
            date: Date(),
            result: result,
            chosenAnswerTexts: chosenAnswers.map { $0.text }
        )

        all.insert(attempt, at: 0)
        save(all)
    }
}
