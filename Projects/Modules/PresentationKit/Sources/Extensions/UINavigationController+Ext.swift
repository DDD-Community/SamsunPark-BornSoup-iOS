//
//  UINavigationController+Ext.swift
//  PresentationKit
//
//  Created by 고병학 on 10/2/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
