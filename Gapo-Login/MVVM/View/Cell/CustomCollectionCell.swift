//
//  CollectionViewCell.swift
//  Gapo-Login
//
//  Created by Dung on 10/28/22.
//

import UIKit
import RxCocoa
import Alamofire
import SDWebImage
import RxSwift

class CustomCollectionCell: CollectionCell<CustomCellVM> {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    //----------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 2
        avatarImage.makeRounded()
        iconImage.makeRounded()
    }
    //----------------------------------------
    override func bindViewAndViewModel() {
        guard let viewModel = viewModel else { return }
        viewModel.rxDescriptionLabel ~> descriptionLabel.rx.attributedText => disposeBag
        viewModel.rxDateLabel ~> dateLabel.rx.text => disposeBag
        viewModel.rxAvatarImage ~> avatarImage.rx.imageURL => disposeBag
        viewModel.rxIconImage ~> iconImage.rx.imageURL => disposeBag
        viewModel.rxBackgroundColor ~> self.rx.backgroundColor => disposeBag
    }
}

class CustomCollectionCellVM: CellViewModel<DataItem> {
    
    var rxDescriptionLabel = BehaviorRelay<NSAttributedString?>(value: nil)
    var rxDateLabel = BehaviorRelay<String?>(value: nil)
    var rxAvatarImage = BehaviorRelay<String?>(value: nil)
    var rxIconImage = BehaviorRelay<String?>(value: nil)
    var rxBackgroundColor = BehaviorRelay<UIColor?>(value: nil)
    //----------------------------------------
    override func react() {
        rxDescriptionLabel.accept(configureAttributedString(boldText: model?.subjectName ?? "",
                                                            normalText: model?.message.text ?? ""))
        rxDateLabel.accept(createDate(date: String(model?.createdAt ?? 0)))
        rxAvatarImage.accept(model?.image)
        rxIconImage.accept(model?.icon)
        rxBackgroundColor.accept(checkState(state: model?.status.rawValue ?? ""))
    }
    //----------------------------------------
    func checkState(state: String) -> UIColor {
        if state == "seen_and_read" {
            return UIColor(rgb: 0xFFFFFF)
        } else {
            return UIColor(rgb: 0xECF7E7)
        }
    }
    //----------------------------------------
    func createDate(date: String) -> String {
        let createdDateString = date
        let createdDate = createdDateString.createDateTime(format: "dd/MM/yyyy HH:mm")
        return createdDate
    }
    //----------------------------------------
    public func configureAttributedString(boldText: String,
                                          normalText: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.appNormalFont,
        ]
        let boldAttributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.appSemiFont,
        ]
        let attributedText = NSMutableAttributedString(string: normalText,
                                                       attributes: attributes)
        let range = (normalText as NSString).range(of: boldText)
        attributedText.setAttributes(boldAttributes,
                                     range: range)
        return attributedText
    }
    
    func updateState() {
        var state = model?.status.rawValue
        if state == "seen_but_unread" {
            state = "seen_and_read"
            rxBackgroundColor.accept(checkState(state: state ?? ""))
        } else {
            rxBackgroundColor.accept(checkState(state: state ?? ""))
        }
    }
}
