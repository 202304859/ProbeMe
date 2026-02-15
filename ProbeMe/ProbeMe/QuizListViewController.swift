import UIKit

final class QuizListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let quizzes = QuizBank.all

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 140
        tableView.backgroundColor = .systemBackground
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowQuiz",
           let quiz = sender as? Quiz,
           let nav = segue.destination as? UINavigationController,
           let questionVC = nav.topViewController as? QuestionViewController {
            questionVC.quiz = quiz
        }
    }
}

extension QuizListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quizzes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as! QuizTableViewCell
        let quiz = quizzes[indexPath.row]
        cell.configure(title: quiz.title, image: UIImage(named: quiz.imageName))
        return cell
    }
}

extension QuizListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowQuiz", sender: quizzes[indexPath.row])
    }
}
