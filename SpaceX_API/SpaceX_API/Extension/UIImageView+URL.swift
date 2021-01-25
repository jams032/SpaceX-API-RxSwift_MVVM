//
//  UIImageView+URL.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//


import UIKit

extension UIImageView {
    func load(url: URL, completion: ((Bool) -> Void)?) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self, let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
                completion?(true)
            }
        }
    }
}
