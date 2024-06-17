//
//  DeleteUserFeed.swift
//  Catstagram
//
//  Created by 김민지 on 5/7/24.
//

import Foundation

struct DeleteUserFeed: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: String?
}
