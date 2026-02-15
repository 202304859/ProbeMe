import UIKit

final class HistoryDetailViewController: UIViewController {

    var attempt: QuizAttempt!

    @IBOutlet private weak var resultAnswerLabel: UILabel!
    @IBOutlet private weak var resultDefinitionLabel: UILabel!
    @IBOutlet private weak var answersTextView: UITextView!
    @IBOutlet private weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = attempt.displayTitle
        navigationItem.hidesBackButton = true

        styleCloseButton()

        closeButton.removeTarget(nil, action: nil, for: .allEvents)
        closeButton.addAction(UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }, for: .touchUpInside)

        resultAnswerLabel.textColor = .systemBlue
        resultDefinitionLabel.textColor = .systemBlue
        resultDefinitionLabel.numberOfLines = 0

        answersTextView.isEditable = false
        answersTextView.isSelectable = false
        answersTextView.backgroundColor = .clear
        answersTextView.textColor = .systemBlue
        answersTextView.font = .systemFont(ofSize: 18, weight: .regular)

        if attempt.quizId == "animal" {
            resultAnswerLabel.text = "You are a \(attempt.result.emoji)!"
        } else {
            resultAnswerLabel.text = attempt.result.displayName
        }

        resultDefinitionLabel.text = attempt.result.definition

        let list = attempt.chosenAnswerTexts.enumerated()
            .map { "\($0.offset + 1). \($0.element)" }
            .joined(separator: "\n")

        answersTextView.text = "Your answers:\n\n\(list)"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
        closeButton.clipsToBounds = true
        view.bringSubviewToFront(closeButton)
    }

    private func styleCloseButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .systemGray
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "xmark")
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        closeButton.configuration = config
        closeButton.isEnabled = true
        closeButton.isUserInteractionEnabled = true
    }
}
