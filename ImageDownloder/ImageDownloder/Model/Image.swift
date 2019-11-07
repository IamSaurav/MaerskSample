//
//  Image.swift
//  ImageDownloder
//
//  Created by Saurav Satpathy on 11/7/19.
//  Copyright © 2019 bitMountn. All rights reserved.
//

import Foundation
struct Image {
    var imageData: Data?
    var progress: Float!
    var progressPercentage: Int! {
        return Int(progress * 100)
    }
    var url: URL!
    var fileName: String!
}
