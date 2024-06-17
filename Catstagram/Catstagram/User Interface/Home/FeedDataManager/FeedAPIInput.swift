//
//  FeedAPIInput.swift
//  Catstagram
//
//  Created by 김민지 on 5/5/24.
//

// 서버 연결 시 보내 줄 것 
struct FeedAPIInput : Encodable {
    var limit : Int?
    var page : Int?
}
