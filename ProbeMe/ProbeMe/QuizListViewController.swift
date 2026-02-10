//
//  QuizListViewController.swift
//  ProbeMe
//
//  Created by hyacinth on 10/02/2026.
//

import UIKit

class QuizListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //for titles and images in the tableview !!!!!
    struct Quiz {
            let title: String
            let imageName: String
        }

        private let quizzes: [Quiz] = [
            Quiz(title: "What Animal are you?", imageName: "animal"),
            Quiz(title: "What Major is for you?", imageName: "major"),
            Quiz(title: "Which Hero are you?", imageName: "hero")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
                tableView.delegate = self

                tableView.separatorStyle = .none
                tableView.rowHeight = 140
                tableView.backgroundColor = .systemBackground
                /*tableView.sectionHeaderTopPadding = 0
                tableView.contentInsetAdjustmentBehavior = .never*/
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension QuizListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quizzes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as? QuizTableViewCell else {
            return UITableViewCell()
        }

        let quiz = quizzes[indexPath.row]
        cell.configure(title: quiz.title, image: UIImage(named: quiz.imageName))
        return cell
    }
    
}



extension QuizListViewController: UITableViewDelegate { }
