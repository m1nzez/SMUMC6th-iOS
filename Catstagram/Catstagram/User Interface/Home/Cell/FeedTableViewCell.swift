//
//  FeedTableViewCell.swift
//  Catstagram
//
//  Created by 김민지 on 4/7/24.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var labelUserName: NSLayoutConstraint!
    @IBOutlet weak var imageViewFeed: UIImageView!
    @IBOutlet weak var buttonIsHeart: UIButton!
    @IBOutlet weak var buttonIsBookMark: UIButton!
   // @IBOutlet weak var buttonIsBookMark: NSLayoutConstraint!
    @IBOutlet weak var labelHowManyLike: UILabel!
    @IBOutlet weak var labelFeed: UILabel!
    
    @IBOutlet weak var imageViewMyProfile: UIImageView!
    
    
    @IBAction func actionIsHeart(_ sender: Any) {
        if buttonIsHeart.isSelected {
            buttonIsHeart.isSelected = false
        } else {
            buttonIsHeart.isSelected = true
        }
    }
    
    
    @IBAction func actionBookMark(_ sender: Any) {
        if buttonIsBookMark.isSelected {
            buttonIsBookMark.isSelected = false
        } else {
            buttonIsBookMark.isSelected = true
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 프로필이 동그랗기 보이기 위함
        imageViewUserProfile.layer.cornerRadius = 12.5
        imageViewUserProfile.clipsToBounds = true
        imageViewMyProfile.layer.cornerRadius = 12.5
        imageViewMyProfile.clipsToBounds = true
        
        
        // 아이디와 글의 폰트굵기 차이가 나기 위함
        let fontSize = UIFont.boldSystemFont(ofSize: 9)
        let attributedStr = NSMutableAttributedString(string: labelFeed.text ?? "")
        attributedStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: 3)) // location에서 부터 length의 길이까지 볼드처리 할건지 설정
        
        labelFeed.attributedText = attributedStr
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
