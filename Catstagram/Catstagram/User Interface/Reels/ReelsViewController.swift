//
//  ReelsViewController.swift
//  Catstagram
//
//  Created by 김민지 on 5/7/24.
//

import UIKit

class ReelsViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var nowPage = 0
    
    private let videoURLStrArr = ["kitty01", "kitty02"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast     // 스크롤 속도 설정
        collectionView.register(
            UINib(nibName: "ReelsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReelsCollectionViewCell.identifier) // 셀 등록
        
        starLoop()                                 // collectionView가 셋팅이 다 된 후에 실행
    }
    
    // timer를 설정 해 다음 화면으로 넘어감 
    private func starLoop() {
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.moveNextPage()
        }
    }
    
    private func moveNextPage() {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        nowPage += 1
        // 마지막 페이지인 경우
        if (nowPage >= itemCount) {
            nowPage = 0
        }
        
        collectionView.scrollToItem(at: IndexPath(item: nowPage, section: 0), at: .centeredVertically, animated: true)
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    // dataSource 메소드로 셀을 생성하고 반환하는 역할
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReelsCell.identifier,
            for: indexPath) as? ReelsCell else { return UICollectionViewCell() }
        cell.setupURL(videoURLStrArr.randomElement()!)
        return cell
    }
    
    // delegate 메소드로 메모리 관리를 위해 display end 시킴
    // 셀이 화면에서 사라질 떄 호출됨
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCell {
            cell.videoView?.cleanup()
        }
    }
    
}

// collectionView 안에 있는 셀간의 layout을 조정하기 위해 DelgateFlowLayout 사용
extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
