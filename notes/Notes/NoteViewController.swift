//
//  NoteViewController.swift
//  Notes
//
//  Created by 김민지 on 4/1/24.
//

import UIKit

class NoteViewController: UIViewController {
    var note: Note!
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = note.contents
    } // 뷰가 로드될 때마다 내용 설정
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note.contents = textView.text
        NoteManager.main.save(note: note)
    } // 뷰를 종료할 때 메모 저장
}
