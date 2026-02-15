//
//  QuestionViewController.swift
//  ProbeMe
//

import UIKit

final class QuestionViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var questionLabel: UILabel!

    @IBOutlet private weak var singleStackView: UIStackView!
    @IBOutlet private weak var multipleStackView: UIStackView!

    @IBOutlet private weak var rangedStackView: UIStackView!
    @IBOutlet private weak var rangedLabel1: UILabel!
    @IBOutlet private weak var rangedLabel2: UILabel!
    @IBOutlet private weak var rangedSlider: UISlider!

    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var questionProgressView: UIProgressView!

    @IBOutlet private weak var closeButton: UIButton!

    
    var quiz: Quiz!

    // MARK: - State
    private var workingQuestions: [Question] = []
    private var questionIndex = 0
    private var chosen: [Answer] = []

    private var currentAnswers: [Answer] = []
    private var multiToggles: [(UISwitch, Answer)] = []

    // MARK: - Timer
    private let secondsPerQuestion = 15
    private var remainingSeconds = 0
    private var timer: Timer?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        precondition(quiz != nil, "Quiz not passed. (Storyboard segue is being goofy.)")
        precondition(singleStackView != nil && multipleStackView != nil && rangedStackView != nil,
                     "Some outlets aren't connected. (Storyboard again. Love that.)")

        // shuffle!!!
        workingQuestions = quiz.questions.shuffled().map { q in
            switch q.type {
            case .ranged:
                
                return q
            case .single, .multiple:
               
                return Question(text: q.text, type: q.type, answers: q.answers.shuffled())
            }
        }


        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.minimumScaleFactor = 0.6
        questionLabel.font = .systemFont(ofSize: 24, weight: .bold)
        questionLabel.textColor = .systemBlue

        styleCloseButton()
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    // MARK: - Close button
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
        dismiss(animated: true)
    }

    // MARK: - Update UI
    private func updateUI() {
        navigationItem.title = quiz.title

        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true

        
        singleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        multipleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        multiToggles.removeAll()

        let q = workingQuestions[questionIndex]
        questionLabel.text = q.text
        currentAnswers = q.answers

        counterLabel.text = "\(questionIndex + 1)/\(workingQuestions.count)"
        questionProgressView.setProgress(Float(questionIndex) / Float(workingQuestions.count), animated: true)

        startTimer()

        switch q.type {
        case .single:
            buildSingle(answers: q.answers)
        case .multiple:
            buildMultiple(answers: q.answers)
        case .ranged:
            buildRanged(answers: q.answers)
        }
    }

    // MARK: - Timer
    private func startTimer() {
        timer?.invalidate()
        remainingSeconds = secondsPerQuestion
        timerLabel.text = formatTime(remainingSeconds)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in
            guard let self else { return }
            self.remainingSeconds -= 1
            self.timerLabel.text = self.formatTime(self.remainingSeconds)

            if self.remainingSeconds <= 0 {
                t.invalidate()
                self.nextQuestion()
            }
        }
    }

    private func formatTime(_ seconds: Int) -> String {
        let s = max(0, seconds)
        return String(format: "%02d:%02d", s / 60, s % 60)
    }

    // MARK: - Navigation
    private func nextQuestion() {
        timer?.invalidate()
        questionIndex += 1

        if questionIndex < workingQuestions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ShowResults", sender: nil)
        }
    }

    // MARK: - Single
    private func buildSingle(answers: [Answer]) {
        singleStackView.isHidden = false
        singleStackView.axis = .vertical
        singleStackView.alignment = .fill
        singleStackView.distribution = .fillEqually
        singleStackView.spacing = 8

        singleStackView.isLayoutMarginsRelativeArrangement = true
        singleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)

        let tight = answers.count >= 6
        let insets = tight
            ? NSDirectionalEdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14)
            : NSDirectionalEdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 18)

        for answer in answers {
            let btn = UIButton(type: .system)
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .systemBlue
            config.baseForegroundColor = .white
            config.cornerStyle = .capsule
            config.title = answer.text
            config.titleAlignment = .center
            config.contentInsets = insets
            btn.configuration = config

            btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.textAlignment = .center

            btn.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                self.chosen.append(answer)
                self.nextQuestion()
            }, for: .touchUpInside)

            singleStackView.addArrangedSubview(btn)
        }
    }

    // MARK: - Multiple
    private func buildMultiple(answers: [Answer]) {
        multipleStackView.isHidden = false

        multipleStackView.axis = .vertical
        multipleStackView.alignment = .fill
        multipleStackView.distribution = .fill
        multipleStackView.spacing = 12

        multipleStackView.isLayoutMarginsRelativeArrangement = true
        multipleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)

        
        for answer in answers {
            let rowContainer = UIView()

            let row = UIStackView()
            row.axis = .horizontal
            row.alignment = .center
            row.distribution = .fill
            row.spacing = 10

            let label = UILabel()
            label.text = answer.text
            label.textColor = .systemBlue
            label.font = .systemFont(ofSize: 20, weight: .regular) // same size always??
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.55
            label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

            let toggle = UISwitch()
            toggle.setContentHuggingPriority(.required, for: .horizontal)

            multiToggles.append((toggle, answer))

            row.addArrangedSubview(label)
            row.addArrangedSubview(toggle)

            rowContainer.addSubview(row)
            row.translatesAutoresizingMaskIntoConstraints = false

            
            NSLayoutConstraint.activate([
                row.leadingAnchor.constraint(equalTo: rowContainer.leadingAnchor),
                row.trailingAnchor.constraint(equalTo: rowContainer.trailingAnchor),
                row.topAnchor.constraint(equalTo: rowContainer.topAnchor),
                row.bottomAnchor.constraint(equalTo: rowContainer.bottomAnchor),
                row.heightAnchor.constraint(equalToConstant: 44) // keeps everything aligned
            ])

            multipleStackView.addArrangedSubview(rowContainer)
        }

        let submit = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Submit Answer"
        config.baseForegroundColor = .systemBlue
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        submit.configuration = config
        submit.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)

        submit.addAction(UIAction { [weak self] _ in
            guard let self else { return }

            
            for (toggle, ans) in self.multiToggles where toggle.isOn {
                self.chosen.append(ans)
            }
            self.nextQuestion()
        }, for: .touchUpInside)

        multipleStackView.addArrangedSubview(submit)
    }

    // MARK: - Ranged
    private func buildRanged(answers: [Answer]) {
        rangedStackView.isHidden = false

        rangedLabel1.text = answers.first?.text ?? ""
        rangedLabel2.text = answers.last?.text ?? ""

        rangedSlider.minimumValue = 0
        rangedSlider.maximumValue = 1
        rangedSlider.value = 0.5
    }


    @IBAction private func rangedSubmitPressed(_ sender: UIButton) {
        let answers = currentAnswers
        guard !answers.isEmpty else { nextQuestion(); return }

        let idx = Int(round(rangedSlider.value * Float(answers.count - 1)))
        chosen.append(answers[idx])
        nextQuestion()
    }

    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults",
           let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.quiz = quiz
            resultsVC.responses = chosen
        }
    }
}
