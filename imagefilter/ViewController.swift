//
//  ViewController.swift
//  image filter
//
//  Created by 김민지 on 3/29/24.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let context = CIContext() // 이미지를 생성하고 필터를 적용하며 결과 이미지 출력을 위함
    var original: UIImage? // 선택한 원본 이미지 저장, 뒤에 물음표가 있는 이유: 이미지가 할당이 안됐을 때도 가정하기 위함 //
    
    @IBOutlet var imageView: UIImageView! // 해당 imageview에 excess하기 위함
    @IBAction func choosePhoto()  {  // 버튼을 눌러주기 위한 함수
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) { // 사용자 사진 갤러리를 사용할 수 있는지 확인용
            let picker = UIImagePickerController() //UIImagePickerController = iOS에서 사진 및 비디오 촬영, 미디어 라이브러리에서 사진 및 비디오선택 등의 작업을 수행하는 컨트롤러
            picker.delegate = self
            // delegate : 다른 클래스에 동작을 위임하는 방법 (이미지를 선택했을 때 이벤트를 알려주기 위함),  해당 이벤트에 응답하는데 사용하려는 개체 = view controller
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil) // 실제로 표시하기 위함 Completion: nill 은 이 작업이 완료 된 후 아무일 도 안일어나기 때문에 nil 작성
        }
    }
    
    @IBAction func applySepia() {
        if original == nil {
            return
        } // 만약 사진이 없다면 버튼 실행이 안되도록 하기 위함
        let filter = CIFilter(name: "CISepiaTone")
        display(filter: filter!)
        
    }
    
    
    @IBAction func applyNoir() {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
    }
    
    @IBAction func applyVintage() {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
    }
    
    
    func display (filter: CIFilter) {
        filter.setValue(CIImage(image: original!), forKey: kCIInputIntensityKey)//필터링할 이미지 설정
        let output = filter.outputImage // 현재 이미지는 CIImage로 제공됨
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!) //CIImage를 UIImage로 전환
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil) //dismiss()는 현재 view Controller를 닫고 이 전의 상태로 돌아가게 됨
        if let image =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage { // 사용자가 선택한 이미지는 image 변수에 할당됨, 이미지를 선택 후 이에 해당 이미지에 대한 작업 수행 가능해짐
            imageView.image = image
            original = image
            
            }
        }
}



// 사용자의 사진 목록을 여는 코드
// 하나를 선택해서 imageview에 표시
// 해당 이미지에 필터를 적용
// 사용자 사진 갤러리를 표시하는 코드
