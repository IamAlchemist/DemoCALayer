//
//  Array+SortUIViewsInPlaceByTag.swift
//  CALayerDemo
//
//  Created by wizard on 12/25/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

extension Array where Element: UIView {
    mutating func sortUIViewsInPlaceByTag() {
        sortInPlace { (left, right) -> Bool in
            left.tag < right.tag
        }
    }
}
