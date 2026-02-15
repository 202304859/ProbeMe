import Foundation

enum QuizBank {
    static let all: [Quiz] = [animal, major, hero]

    static let animal = Quiz(
        id: "animal",
        title: "What Animal are you?",
        imageName: "animal",
        questions: [
            Question(
                text: "Which food do you like the most?",
                type: .single,
                answers: [
                    Answer(text: "Steak", result: .dog),
                    Answer(text: "Fish", result: .cat),
                    Answer(text: "Carrot", result: .rabbit),
                    Answer(text: "Corn", result: .turtle),
                    Answer(text: "Apple", result: .rabbit),
                    Answer(text: "Chicken", result: .dog)
                ]
            ),
            Question(
                text: "Which activities do you enjoy?",
                type: .multiple,
                answers: [
                    Answer(text: "Self Care", result: .cat),
                    Answer(text: "Swimming", result: .turtle),
                    Answer(text: "Sleeping", result: .cat),
                    Answer(text: "Cuddling", result: .rabbit),
                    Answer(text: "Eating", result: .dog)
                ]
            ),
            Question(
                text: "How much do you enjoy car rides?",
                type: .ranged,
                answers: [
                    Answer(text: "I dislike them", result: .cat),
                    Answer(text: "I get a little nervous", result: .rabbit),
                    Answer(text: "I barely notice them", result: .turtle),
                    Answer(text: "I love them", result: .dog)
                ]
            )
        ]
    )

    static let major = Quiz(
        id: "major",
        title: "What Major is for you?",
        imageName: "major",
        questions: [
            Question(
                text: "What do you enjoy doing in your free time?",
                type: .single,
                answers: [
                    Answer(text: "Help parents", result: .medicine),
                    Answer(text: "Pass time with friends", result: .communications),
                    Answer(text: "Doom scroll", result: .dropout),
                    Answer(text: "Draw or DIY", result: .art),
                    Answer(text: "Legos or puzzles", result: .programming),
                    Answer(text: "Find work", result: .business)
                ]
            ),
            Question(
                text: "How do people describe you?",
                type: .single,
                answers: [
                    Answer(text: "Outgoing", result: .communications),
                    Answer(text: "Spontaneous", result: .business),
                    Answer(text: "Kind", result: .medicine),
                    Answer(text: "Inspiring", result: .art),
                    Answer(text: "Logical", result: .programming),
                    Answer(text: "Lazy", result: .dropout),
                    Answer(text: "Indecisive", result: .communications)
                ]
            ),
            Question(
                text: "What’s your favourite show/Movie?",
                type: .multiple,
                answers: [
                    Answer(text: "House MD", result: .medicine),
                    Answer(text: "Lord of the rings", result: .art),
                    Answer(text: "Friends", result: .communications),
                    Answer(text: "Mr. Robot", result: .programming),
                    Answer(text: "Wolf of wall street", result: .business),
                    Answer(text: "Big mouth", result: .dropout)
                ]
            ),
            Question(
                text: "What’s your style?",
                type: .single,
                answers: [
                    Answer(text: "Casual", result: .programming),
                    Answer(text: "Comfortable", result: .dropout),
                    Answer(text: "Classy", result: .business),
                    Answer(text: "Trendy", result: .communications),
                    Answer(text: "Proper", result: .medicine),
                    Answer(text: "Expressive", result: .art)
                ]
            ),
            Question(
                text: "How much do you enjoy working?",
                type: .ranged,
                answers: [
                    Answer(text: "I hate it", result: .dropout),
                    Answer(text: "I don't really like it..", result: .communications),
                    Answer(text: "I'll do it if I have to", result: .business),
                    Answer(text: "I don't mind", result: .programming),
                    Answer(text: "I like it", result: .medicine),
                    Answer(text: "I love it!", result: .art)
                ]
            )
        ]
    )

    static let hero = Quiz(
        id: "hero",
        title: "Which Hero are you?",
        imageName: "hero",
        questions: [
            Question(
                text: "Have you had a partner?",
                type: .single,
                answers: [
                    Answer(text: "No, they left me", result: .spiderman),
                    Answer(text: "No, I left them", result: .batman),
                    Answer(text: "Yes, I'm in a happy relationship", result: .superman),
                    Answer(text: "No", result: .wonderwoman)
                ]
            ),
            Question(
                text: "What food do you like?",
                type: .multiple,
                answers: [
                    Answer(text: "Pizza", result: .spiderman),
                    Answer(text: "Steak", result: .batman),
                    Answer(text: "Beef bourguignon with ketchup", result: .superman),
                    Answer(text: "Soup", result: .batman),
                    Answer(text: "Ice cream", result: .wonderwoman),
                    Answer(text: "Wheatcakes", result: .spiderman)
                ]
            ),
            Question(
                text: "What do you like doing?",
                type: .multiple,
                answers: [
                    Answer(text: "Photography", result: .spiderman),
                    Answer(text: "Playing chess", result: .batman),
                    Answer(text: "Visit a museum", result: .wonderwoman),
                    Answer(text: "Admire the sky", result: .superman),
                    Answer(text: "Take a walk", result: .superman),
                    Answer(text: "Skateboard", result: .spiderman)
                ]
            ),
            Question(
                text: "What’s most important to you?",
                type: .single,
                answers: [
                    Answer(text: "Family", result: .superman),
                    Answer(text: "Responsibility", result: .spiderman),
                    Answer(text: "Justice", result: .batman),
                    Answer(text: "Truth", result: .wonderwoman)
                ]
            ),
            Question(
                text: "Would you kill someone?",
                type: .ranged,
                answers: [
                    Answer(text: "Yes", result: .wonderwoman),
                    Answer(text: "Only if I have to", result: .superman),
                    Answer(text: "If I'm driven to the edge", result: .spiderman),
                    Answer(text: "Never", result: .batman)
                ]
            )
        ]
    )
}
