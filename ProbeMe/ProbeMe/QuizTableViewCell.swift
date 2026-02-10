//
//  QuizTableViewCell.swift
//  ProbeMe
//
//  Created by hyacinth on 10/02/2026.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

                backgroundColor = .clear
                contentView.backgroundColor = .clear

                // Card styling
                cardView.layer.cornerRadius = 18
                cardView.layer.borderWidth = 2
                cardView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.55).cgColor
                cardView.clipsToBounds = true

                // Image styling
                quizImageView.contentMode = .scaleAspectFill
                quizImageView.clipsToBounds = true

                // Round only the left corners of the image so it matches the card
                quizImageView.layer.cornerRadius = 18
                quizImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func configure(title: String, image: UIImage?) {
            titleLabel.text = title
            quizImageView.image = image
            selectionStyle = .none
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
