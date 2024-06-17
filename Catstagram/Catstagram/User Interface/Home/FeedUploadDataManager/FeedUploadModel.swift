//
//  FeedUploadModel.swift
//  Catstagram
//
//  Created by 김민지 on 5/6/24.
//

struct FeedUploadModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : FeedUploadResult?
}

struct FeedUploadResult : Decodable {
    var postIdx : Int?
}
