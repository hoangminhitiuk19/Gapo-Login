//
//  Extensions.swift
//  Gapo-Login
//
//  Created by Dung on 10/24/22.
//

import Foundation
import RxCocoa
import RxSwift


extension Reactive where Base: UIImageView {
    public var imageURL: Binder<String?> {
        return Binder(base) { imageView, imageURL in
            imageView.sd_cancelCurrentImageLoad()
            imageView.sd_setImage(with: URL(string: imageURL ?? ""), placeholderImage: nil, options: .continueInBackground, completed: nil)
        }
    }
}
