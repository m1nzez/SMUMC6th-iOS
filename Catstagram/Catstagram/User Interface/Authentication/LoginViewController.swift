//
//  LoginViewController.swift
//  Catstagram
//
//  Created by 김민지 on 4/6/24.
//

import UIKit
import Alamofire    // 서버와 연결 !!

class LoginViewController: UIViewController {
    
    var email = String()
    var password = String()
    var userInfo: UserInfo?
    
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
    }

    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        // optional : 값이 있을 수도 없을 수도 -> 만약 값이 없는 경우에는 "" 을 넣음
        let text = sender.text ?? ""
        
       self.loginButton.backgroundColor
        = text.isValidEmail() ? UIColor.FacebookColor : UIColor.disableButtonColor
            
        self.email = text
    }
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        self.loginButton.backgroundColor
        = text.count > 2 ? .FacebookColor : .disableButtonColor  //비밀번호 2글자 이상만 쳐도 색상이 변경됨
        
        self.password = text
    }
    
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        // 회원가입정보를 전달받아서 그것과 textField 데이터가 일치하면 로그인
        guard let userInfo = self.userInfo else {
            return }  // 데이터가 있으면 userInfo 전달, 없으면 실행 종료
        
        if userInfo.email == self.email
            && userInfo.password == self.password {
            let vc = storyboard? .instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController

              // 아래와 같이 코드를 작성하게 되면 로그인화면이 계속 남겨진 상태로 tab bar controller로 이동되면서 메모리 낭비
//            vc.modalPresentationStyle = .fullScreen  // 화면 전달할 때 꽉차게 전달됨
//            self.present(vc, animated: true, completion: nil)
            
            // 이전에 있던 로그인 화면은 없어지게 되고 tab bar controller로 화면이 대체됨
            // self(login view controller)의 view에 window라는 객체에 windowScene에 가서 keyWindow로 사용되는 viewController로 대체
            self.view.window?.windowScene?.keyWindow?.rootViewController = vc
        } else {   }
    }

    
    
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 화면전환
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       
        // 2. 뷰컨트롤 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
                       
        // 3. 화면전환 메소드를 이용해서 화면 전환
        // self.present(registerViewController, animated: true, completion: nil)
        // 주요 차이점은 모달로 표시되는 경우 이전 화면으로 되돌아가기 위해서는 모달을 닫아야 하고,
        // 내비게이션 스택에서는 이전 화면으로 되돌아가기 위해 내비게이션 컨트롤러가 자동으로 관리하는 스택을 사용합니다.
                       
        self.navigationController?.pushViewController(registerViewController, animated: true)
               
        // ARC (메모리 관리 방법) -> 강한참조 / 약한참조 -> ARC 낮춰줌
        // weak = 객체의 메모리 관리를 책임지지 않습니다.
        registerViewController.userInfo = { [weak self] (userInfo) in // weak self = 약한참조로 바꿔줌
                   self?.userInfo = userInfo
               }
    }
    
    
    private func setupAttribute() {
        // registerButton
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.FacebookColor
        
        let attributes = generateButtonAttribute(self.registerButton,
                                                 texts: text1, text2,
                                                 fonts: font1, font2,
                                                 colors: color1, color2)
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
        
    }
}


