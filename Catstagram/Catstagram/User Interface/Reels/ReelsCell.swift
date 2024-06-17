//
//  ReelsCell.swift
//  Catstagram
//
//  Created by 김민지 on 5/7/24.
//

// view 
import UIKit
import SnapKit
import AVKit            // 메모리 관리 필요 !!

class ReelsCell: UICollectionViewCell {
    static let identifier = "ReelsCell"
    
    // 객체 생성
    let cellTitleLabel = UILabel()              // 릴스
    let cameraImageView = UIImageView()         // 카메라
    let commentImageView = UIImageView()        // 댓글
    let likeImageView = UIImageView()           // 좋아요
    let shareImageView = UIImageView()          // 공유하기
    
    
    var videoView: VideoPlayerView?
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupURL(_ urlStr: String) {
        self.videoView = VideoPlayerView(frame: .zero, urlStr: urlStr)
        setupAttribute()
        setupLayout()
    }
    
    // 객체에 대한 attribute 설정
    private func setupAttribute() {
        cellTitleLabel.text = "릴스"
        cellTitleLabel.font = .boldSystemFont(ofSize: 25)
        cellTitleLabel.textAlignment = .left
        cellTitleLabel.textColor = .white
        
        [cameraImageView, shareImageView, likeImageView]
            .forEach {
                $0.contentMode = .scaleAspectFit
                $0.tintColor = .white
            }
        
        cameraImageView.image = UIImage(systemName: "camera")
        shareImageView.image = UIImage(systemName: "paperplane")
        commentImageView.image = UIImage(systemName: "message")
        likeImageView.image = UIImage(systemName: "suit.heart")
        
    }
    
    // 객체에 대한 layout 설정
    private func setupLayout() {
        guard let videoView = videoView else { return }
        contentView.addSubview(videoView)
        
        videoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 배열에 포함된 모든 뷰를 contentView에 추가할 수 있도록 한 번에 작성
        [cellTitleLabel, cameraImageView,
        likeImageView,
        commentImageView,
        shareImageView]
            .forEach { contentView.addSubview($0) }
        
        // constraints
        cellTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)                   // 이미지의 크기 35로 설정

        }
        
        shareImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
        
        let space = CGFloat(-20)
        
        commentImageView.snp.makeConstraints { make in
            make.bottom.equalTo(shareImageView.snp.top).offset(space)
            make.centerX.equalTo(shareImageView)
            make.width.height.equalTo(35)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.bottom.equalTo(commentImageView.snp.top).offset(space)
            make.centerX.equalTo(shareImageView)
            make.width.height.equalTo(35)
        }
        
    }
}
