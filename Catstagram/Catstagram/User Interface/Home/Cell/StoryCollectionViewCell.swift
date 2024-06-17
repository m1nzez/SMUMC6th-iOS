//
//  StoryCollectionViewCell.swift
//  Catstagram
//
//  Created by 김민지 on 4/8/24.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewImageViewBackground: UIView!
    @IBOutlet weak var viewUserProfileBackground: UIView!
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    
    // awakeFromNib = 인스턴스를 초기화할 때 호출되는 메소드
    override func awakeFromNib() {
        // cell 초기화 후
        super.awakeFromNib()
        
        // 모서리를 둥글게 만듦 => cell에 대한 view
        viewImageViewBackground.layer.cornerRadius = 24
        viewUserProfileBackground.layer.cornerRadius = 23
        imageViewUserProfile.layer.cornerRadius = 22.5
        imageViewUserProfile.clipsToBounds = true
    }

}
