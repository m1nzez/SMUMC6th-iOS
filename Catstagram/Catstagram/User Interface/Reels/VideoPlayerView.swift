//
//  VideoPlayerView.swift
//  Catstagram
//
//  Created by 김민지 on 5/12/24.
//

import UIKit
import AVKit

// cell 안에 들어가는 VideoPlayerView를 설정. => View 역할
class VideoPlayerView: UIView {
    
    var playerLayer: AVPlayerLayer?         // 재생될 때 Layer
    var playerLooper: AVPlayerLooper?       // 반복 재생
    var queuePlayer: AVQueuePlayer?         // 영상 순서
    var urlStr: String                     // 비디오의 URL 저장
    
    // 코드로 직접 생성된 뷰를 초기화했기에 overide를 따로 하지 않음 
    init(frame: CGRect, urlStr: String) {
        self.urlStr = urlStr
        super.init(frame: frame)
        
        let videoFileURL = Bundle.main.url(forResource: urlStr, withExtension: "mp4")!
        let playItem = AVPlayerItem(url: videoFileURL)
        
        self.queuePlayer = AVQueuePlayer(playerItem: playItem)
        playerLayer = AVPlayerLayer()                   // 비디오를 화면에 표시하기 위한 layer
        
        playerLayer!.player = queuePlayer               // 큐에 넣은 비디오 재생
        playerLayer!.videoGravity = .resizeAspectFill   // 비디오 사이즈 = fill 상태
        
        self.layer.addSublayer(playerLayer!)
        
        // 반복재생
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playItem)
        queuePlayer!.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 메모리 관리를 위한 clean up 
    public func cleanup() {
        queuePlayer?.pause()
        queuePlayer?.removeAllItems()
        queuePlayer = nil
    }
    
    // SubView(동영상)의 layout 없데이트
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer!.frame = bounds // 현재 뷰의 경게에 맞게 크기 조정으
    }
}
