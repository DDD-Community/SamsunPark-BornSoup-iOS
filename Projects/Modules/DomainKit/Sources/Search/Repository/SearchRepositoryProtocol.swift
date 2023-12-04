//
//  SearchRepositoryProtocol.swift
//  DomainKit
//
//  Created by 고병학 on 12/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public protocol SearchRepositoryProtocol {
    func searchWithTitle(_ title: String) async -> (ContentsListResponse?, Error?)
}
