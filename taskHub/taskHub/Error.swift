//
//  File.swift
//  taskHub
//
//  Created by Anton on 19.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

extension UIViewController {
 func alert(message: String, on vc: UIViewController?) {
    let alertView = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction(title: "ОК", style: .default))
    (vc ?? UIApplication.shared.inputViewController)?.present(alertView, animated: true)
    }
}

