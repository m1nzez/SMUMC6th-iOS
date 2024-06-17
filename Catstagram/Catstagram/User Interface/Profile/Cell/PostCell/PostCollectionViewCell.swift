//
//  PostCollectionViewCell.swift
//  Catstagram
//
//  Created by 김민지 on 4/8/24.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var postImageView: UIImageView!
    
    static let identifier = "PostCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func setupData(_ imageURLStr: String?) {
        // 이미지뷰의 이미지 업로드
        
        guard let imageURLStr = imageURLStr else { return }
        
        if let url = URL(string: imageURLStr) {
            postImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
    }
}
