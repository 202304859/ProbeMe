import Foundation

struct Quiz {
    let id: String
    let title: String
    let imageName: String
    let questions: [Question]
}

struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
}

struct Answer {
    let text: String
    let result: ResultType
}

enum ResponseType {
    case single, multiple, ranged
}

enum ResultType: String, Hashable, Codable {
    case dog, cat, rabbit, turtle
    case programming, art, business, medicine, communications, dropout
    case spiderman, batman, superman, wonderwoman

    var emoji: String {
        switch self {
        case .dog: return "🐶"
        case .cat: return "🐱"
        case .rabbit: return "🐰"
        case .turtle: return "🐢"
        default: return ""
        }
    }

    var displayName: String {
        switch self {
        case .dog: return "Dog"
        case .cat: return "Cat"
        case .rabbit: return "Rabbit"
        case .turtle: return "Turtle"
        case .programming: return "Programming"
        case .art: return "Art"
        case .business: return "Business"
        case .medicine: return "Medicine"
        case .communications: return "Communications"
        case .dropout: return "College Dropout"
        case .spiderman: return "Spider-Man"
        case .batman: return "Batman"
        case .superman: return "Superman"
        case .wonderwoman: return "Wonder Woman"
        }
    }

    var definition: String {
        switch self {
        case .dog:
            return "You’re incredibly outgoing. You surround yourself with people you love and enjoy activities with your friends."
        case .cat:
            return "Independent and cozy. You like doing things your own way and you value comfort."
        case .rabbit:
            return "Gentle and thoughtful. You enjoy calm spaces and people who make you feel safe."
        case .turtle:
            return "Grounded and steady. You take your time, stay calm, and don’t rush decisions."
        case .programming:
            return "You love problem solving and innovation! you strive to learn and improve while creating functional useful works to share with the world"
        case .art:
            return "You are a true creative looking to share your ideas and emotions into the world, your vision and mind carry beautiful whimsy that can't wait to be expressed by you"
        case .business:
            return "You are risk taker hoping to help or cause change in the world but most importantly in yourself, but honestly money spoke to you more than anything else did"
        case .medicine:
            return "You are a empathetic person who wishes to help people and the community, using your brains and heart to do the most for those around you"
        case .communications:
            return "Just say you don't know what you want to do buddy"
        case .dropout:
            return "Honestly I don't think anything will ever work out for you unless you look within yourself and actually try to get to know yourself for once"
        case .spiderman:
            return "you are very passionate, nerdy about what you love and can never stop talking once someone asks you about it. You try to help whoever you can and handle your great power with great responsibility ;)"
        case .batman:
            return "You might have a big ego but are very discipline and hardworking, you always strive towards success and becoming better in whatever you can do to achieve your goal and the cause you have in mind."
        case .superman:
            return "Kindness, love and peace! you believe in what's right and always look for the good in people while trying to improve yourself daily. You value family and friends while being grateful for even the smallest things in your life."
        case .wonderwoman:
            return "You're very confident and outspoken and always speak up about what you think is wrong! you might be a little clueless sometimes but a lot of people look up to you because of your honest and pure heart!"
        }
    }
}
