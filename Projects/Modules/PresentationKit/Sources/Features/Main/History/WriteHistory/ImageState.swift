//
//  ImageState.swift
//  PresentationKit
//
//  Created by 고병학 on 12/21/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}
