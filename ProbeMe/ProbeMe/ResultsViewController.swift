import UIKit

final class ResultsViewController: UIViewController {

    var quiz: Quiz!
    var responses: [Answer] = []

    @IBOutlet private weak var resultAnswerLabel: UILabel!
    @IBOutlet private weak var resultDefinitionLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true

        styleCloseButton()

        closeButton.removeTarget(nil, action: nil, for: .allEvents)
        closeButton.addTarget(self, action: #selector(closeNow), for: .touchUpInside)

        showResultAndSave()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // if something is overlaying, this helps
        view.bringSubviewToFront(closeButton)
        closeButton.isUserInteractionEnabled = true
        closeButton.isEnabled = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
        closeButton.clipsToBounds = true
    }

    private func styleCloseButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .systemGray
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "xmark")
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        closeButton.configuration = config
    }

    @objc private func closeNow() {
    
        presentingViewController?.presentingViewController?.dismiss(animated: true)
    }

    private func showResultAndSave() {
        resultAnswerLabel.textColor = .systemBlue
        resultDefinitionLabel.textColor = .systemBlue
        resultDefinitionLabel.numberOfLines = 0
        resultDefinitionLabel.textAlignment = .center
        resultAnswerLabel.textAlignment = .center

        guard !responses.isEmpty else {
            resultAnswerLabel.text = "Time’s up!"
            resultDefinitionLabel.text = "You didn’t select any answers."
            return
        }

        let counts = responses.reduce(into: [ResultType: Int]()) { dict, ans in
            dict[ans.result, default: 0] += 1
        }

        let winner = counts.max(by: { $0.value < $1.value })!.key

        if quiz.id == "animal" {
            resultAnswerLabel.text = "You are a \(winner.emoji) \(winner.displayName)!"
        } else {
            resultAnswerLabel.text = winner.displayName
        }

        resultDefinitionLabel.text = winner.definition

        QuizHistoryStore.shared.addAttempt(quiz: quiz, chosenAnswers: responses, result: winner)
    }
}
