//
//  RegisterViewController.swift
//  Catstagram
//
//  Created by 김민지 on 4/6/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    // 회원가입시 전달할 정보를 담기 위한 변수 선언 
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    var userInfo: ((UserInfo) -> Void)?  // 데이터를 input했을 떄 return은 할 필요 없음
    
    
    
    // 유효성검사를 위한 property
    var isValidEmail = false {
        didSet {  // 프로포티 옵저버
            self.validateUserInfo()
        }
    } // isVaildEmail에서 값을 입력받을 때마다 validateUserInfo 함수 호출
    
    var isValidName = false {
        didSet {
            self.validateUserInfo()
        }
    }
    
    var isValidNickname = false {
        didSet {
            self.validateUserInfo()
        }
    }
    
    var isValidPassword = false {
        didSet {
            self.validateUserInfo()
        }
    }
    
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var popToLoginButton: UIButton!
    
    // Textfileds
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var textFields: [UITextField] {
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }  // 한번에 textfiled 접근
    
    // MARK: - Lifecyce
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
        
        // bug fix : 화면을 슬라이드해서 넘기기 위한 코드
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Actions  코드로 IBActions 구현
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text   // 데이터 전달
            
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
            
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            self.nickname = text
            
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
            self.password = text
            
        default:
            fatalError("MissingTextField..")
            
        }
        
    }
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        
        // 뒤로가기
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 가입하기 눌렀을 떄 정보가 로그인페이지로 넘어가기 위한 액션
    @IBAction func registerButtonDidTap(_ sender: UIButton) {        
        
        self.navigationController?.popViewController(animated: true)
        
        // UserInfo (가입했을 때의 정보)가 넘겨받기 위함 => 송신자입장
        let userInfo = UserInfo(email: self.email, name: self.name, nickname: self.nickname, password: self.password)
        self.userInfo?(userInfo)
    }
    
    
    // MARK: - Helpers
    private func setupTextField() { // Textfield와 연결하기 위한 메소드
        
        textFields.forEach { tf in
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }
    
    // 사용자가 입력한 회원정보를 입력하고 -> UI 업데이트
    private func validateUserInfo() {
        
        if isValidEmail
            && isValidName
            && isValidNickname
            && isValidPassword {
            
            self.signupButton.isEnabled = true    // 버튼을 눌리도록 하기 위함
            // 에니메이션 효과 넣음
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor.FacebookColor
            }
        } 
        else {
            // 유효성 검사 => 유효하지 않음
            self.signupButton.isEnabled = false    // 버튼을 눌렀을 때 실행하지 않도록 하기 위함
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = .disableButtonColor
            }
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
        
        let attributes = generateButtonAttribute(self.popToLoginButton,
                                                 texts: text1, text2,
                                                 fonts: font1, font2,
                                                 colors: color1, color2)
        
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
        
    }
  }
    
  // 정규표현식
  extension String {
    // 대문자, 소문자, 특수문자, 숫자 8자 이상일 때, True
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
            
        return passwordValidation.evaluate(with: self)
    }
        
    //@ 2글자
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate.init(format: "SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
 }
