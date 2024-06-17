//
//  UserFeedModel.swift
//  Catstagram
//
//  Created by 김민지 on 5/6/24.
//

// API에서 response data type으로 선언
import Foundation

struct UserFeedModel: Decodable {
       
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: UserFeedModelResult?
}

struct UserFeedModelResult: Decodable {
    let _isMyFeed: Bool?
    let getuserInfo: GetUserInfo?
    let getuserPosts: [GetUserPosts]?
}

struct GetUserInfo: Decodable {

    let userIdx: Int?
    let nickName: String?
    let name: String?
    let profileImgUrl: String?
    let website: String?
    let introduction: String?
    let followerCount: Int?
    let followeeCount: Int?
    let postCount: Int?

}

struct GetUserPosts: Decodable {
    
    let postIdx: Int?
    let postImgUrl: String?
    
}


