//
//  FeedDataManager.swift
//  Catstagram
//
//  Created by 김민지 on 5/5/24.
//

// client와 server를 연결해주는 역할
// 데이터를 넣기 위한 외부 URL과 연결하기 위한 코드

import Alamofire

class FeedDataManager {
    // 네트워크 요청
    func feedDataManager(_ parameters : FeedAPIInput, _ viewController : HomeViewController) {
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters)
            .validate()     // 서버 응답에 대한 유효성 검사
            .responseDecodable(of: [FeedModel].self) { response in      // 서버 응답 디코딩
            switch response.result {
            // response.result가 success일 때
            case .success(let result):
                viewController.successAPI(result)
            // response.result가 failure일 때
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
