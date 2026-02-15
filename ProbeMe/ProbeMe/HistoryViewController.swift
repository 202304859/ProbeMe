//
//  HistoryViewController.swift
//  ProbeMe
//
//  Created by hyacinth on 15/02/2026.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none
        tableView.rowHeight = 105
        tableView.backgroundColor = .systemBackground
    }
    
   

        private var attempts: [QuizAttempt] = []


        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            attempts = QuizHistoryStore.shared.load()
            tableView.reloadData()
        }

        private func presentDetail(for attempt: QuizAttempt) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard
                let nav = sb.instantiateViewController(withIdentifier: "HistoryDetailNav") as? UINavigationController,
                let detail = nav.topViewController as? HistoryDetailViewController
            else { return }

            detail.attempt = attempt
            nav.modalPresentationStyle = .pageSheet
            present(nav, animated: true)
        }
    }

    extension HistoryViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            attempts.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
            cell.configure(title: attempts[indexPath.row].displayTitle)
            return cell
        }
    }

    extension HistoryViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            presentDetail(for: attempts[indexPath.row])
        }
    }



