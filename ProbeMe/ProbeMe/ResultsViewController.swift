import UIKit

final class ResultsViewController: UIViewController {

    var quiz: Quiz!
    var responses: [Answer] = []

    @IBOutlet private weak var resultAnswerLabel: UILabel!
    @IBOutlet private weak var resultDefinitionLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "results"
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)

        styleCloseButton()
        calculateResult()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
    }

    private func styleCloseButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .systemGray
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "xmark")
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        closeButton.configuration = config
        closeButton.clipsToBounds = true
    }

    @IBAction private func closeTapped(_ sender: UIButton) {
        if let presenting = presentingViewController {
            presenting.dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    private func calculateResult() {
        guard !responses.isEmpty else { return }

        let counts = responses.reduce(into: [:]) { (dict: inout [ResultType:Int], answer) in
            dict[answer.result, default: 0] += 1
        }

        let best = counts.max { $0.value < $1.value }!.key

        if quiz?.id == "animal" {
            resultAnswerLabel.text = "You are a \(best.emoji) \(best.displayName)!"
        } else {
            resultAnswerLabel.text = best.displayName
        }

        resultDefinitionLabel.text = best.definition
    }
}
