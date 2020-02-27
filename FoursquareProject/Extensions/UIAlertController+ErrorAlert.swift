//
//  UIAlertController+ErrorAlert.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/14/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

extension UIAlertController {
    public static func errorAlert(_ body: String) -> UIAlertController {
        let alertvc = UIAlertController(title: "Error", message: body, preferredStyle: .alert)
        alertvc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertvc
    }
}
