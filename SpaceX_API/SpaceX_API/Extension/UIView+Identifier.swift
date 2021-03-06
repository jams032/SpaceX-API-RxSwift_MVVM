//
//  UIView+Identifier.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import UIKit

extension UIView {
    static var classIdentifier: String {
        return String(describing: Self.self)
    }
}
