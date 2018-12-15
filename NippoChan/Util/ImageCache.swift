//
//  ImageCache.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/16.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

final class ImageCache: NSCache<NSString, UIImage> {
    static let sharedInstance = ImageCache()
    private override init() {
    }
}
