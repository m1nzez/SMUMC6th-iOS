//
//  ProfileCollectionViewCell.swift
//  Catstagram
//
//  Created by 김민지 on 4/8/24.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProfileCollectionViewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var addProfileImageView: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    @IBOutlet weak var postingCountLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAttribute()
        // Initialization code
    }
    
    private func setupAttribute() {
        profileImageView.layer.cornerRadius = 88/2
        addProfileImageView.layer.cornerRadius = 24/2 // 반절을 줘야 원이 됨
        
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.borderWidth = 1
        
        
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = UIColor.lightGray.cgColor
        editButton.layer.borderWidth = 1  // 경계선 추가하는 UI
        
        addFriendButton.layer.cornerRadius = 3
        addFriendButton.layer.borderColor = UIColor.lightGray.cgColor // bordercoler 줄 떄 cgColor 줘야함 !!
        addFriendButton.layer.borderWidth = 1
        
        [postingCountLabel, followerCountLabel, followingCountLabel]
            .forEach { $0.text = "\(Int.random(in: 0...10))" }
    }

}
