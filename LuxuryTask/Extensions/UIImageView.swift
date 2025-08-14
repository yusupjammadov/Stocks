//
//  UIImageView.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 30.07.2025.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(urlString: String?, completionHandler: ((UIImage)->Void)? = nil) {
        guard let urlString = urlString else {
            self.image = nil
            return
        }
        let url = URL(string: urlString)
        
        kf.indicatorType = .activity
        kf.setImage(with: url, options: [.transition(.fade(0.2))]) { result in
            switch result {
            case .success(let image):
                completionHandler?(image.image)
                break
            case .failure(let error):
                print("UIImageView.setImage() error: \(error.localizedDescription)")
            }
        }
    }
    
}
