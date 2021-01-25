//
//  UIViewController+Instantiate.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import UIKit

extension UIViewController {
    static let mainStoryboard = "Main"

    static var classIdentifier: String {
        return String(describing: Self.self)
    }

    static func instatiate() -> UIViewController {
        if #available(iOS 13.0, *) {
            return UIStoryboard(name: mainStoryboard, bundle: nil).instantiateViewController(identifier: classIdentifier)
        } else {
            return UIStoryboard(name: mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: classIdentifier)
        }
    }
}
