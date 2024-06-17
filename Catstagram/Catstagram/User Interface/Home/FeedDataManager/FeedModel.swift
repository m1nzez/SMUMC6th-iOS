//
//  FeedModel.swift
//  Catstagram
//
//  Created by 김민지 on 5/5/24.
//

// 서버 연결 시 받아 올 것
// JSON 데이터를 FeedModel의 배열로 디코딩
struct FeedModel : Decodable {
    var id : String?
    var url : String?
}
