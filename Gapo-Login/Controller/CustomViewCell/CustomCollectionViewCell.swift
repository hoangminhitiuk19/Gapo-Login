//
//  CustomCollectionCollectionViewCell.swift
//  Gapo-Login
//
//  Created by Dung on 9/23/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    //------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.makeRounded()
        iconImage.makeRounded()
    }
    //------------------------------------------
    public func configureCollectionViewCell(semiboldText: String,
                          normalText: String,
                          date: String,
                          avatarURL: String,
                          iconURL: String ) {
        let attributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.appNormalFont,
        ]
        let boldAttributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.appSemiFont,
        ]
        let attributedText = NSMutableAttributedString(string: normalText,
                                                       attributes: attributes)
        let range = (normalText as NSString).range(of: semiboldText)
        attributedText.setAttributes(boldAttributes, range: range)
        textField.attributedText = attributedText
        dateField.text = date
        avatarImage.sd_setImage(with: URL(string: avatarURL),
                                placeholderImage: nil,
                                options: .continueInBackground,
                                completed: nil)
        iconImage.sd_setImage(with: URL(string: iconURL),
                              placeholderImage: nil,
                              options: .continueInBackground,
                              completed: nil)
    }
    //------------------------------------------
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        dateField.text = nil
    }
    //------------------------------------------
    @IBAction func tapSettingsButton(_ sender: UIButton) {
        print("ok settings button")
    }
}
