//
//  FeedUploadDataManager.swift
//  Catstagram
//
//  Created by 김민지 on 5/6/24.
//

import Alamofire

// posts 메소드를 통해 서버에 데이터를 업로드하는 작업
class FeedUploadDataManager {
    func posts(_ viewController : HomeViewController, _ parameter: FeedUploadInput) {
        // Alamofire를 사용해서 서버에 POST 요청을 보냄
        // .responseDecodable : 서버로부터의 응답(JSON 형식)을 디코딩해서 FeedUploadModel 객체로 변환
        AF.request("https://edu-api-ios-test.softsquared.com/posts", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: FeedUploadModel.self) { response in
            // 서버 응답 처리
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    print("성공")
                } else {
                    print(result.message)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
