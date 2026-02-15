//
//  HistoryTableViewCell.swift
//  ProbeMe

//

import UIKit

final class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.layer.cornerRadius = 18
        cardView.layer.borderWidth = 2
        cardView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.55).cgColor
        cardView.clipsToBounds = true

        titleLabel.textColor = .systemBlue
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)

        selectionStyle = .none
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}

