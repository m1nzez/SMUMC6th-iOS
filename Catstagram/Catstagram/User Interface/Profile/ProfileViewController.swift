//
//  ProfileViewController.swift
//  Catstagram
//
//  Created by 김민지 on 4/8/24.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var userPosts: [GetUserPosts]?  {
        didSet { self.profileCollectionView.reloadData() }
    }
    
    var deletedIndex: Int?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupData()             // 화면 나타나자마자 네트워크 통신
    }
    
    // MARK: Actions
    @objc
    func didLongPressCell(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != .began { return }
        
        let position = gestureRecognizer.location(in: profileCollectionView)
        
        if let indexPath = profileCollectionView?.indexPathForItem(at: position) {
            print("DEBUG: ", indexPath.item)
            
            guard let userPosts = self.userPosts else { return }
            let cellData = userPosts[indexPath.item]
            self.deletedIndex = indexPath.item
            if let postIdx = cellData.postIdx {
                // 삭제 API 호출
                UserFeedDataManager().getUserFeed(self, postIdx)
            }
        }
    }
    
    
    
    // MARK: - Helpers
    private func setupCollectionView() {
        
        // delegate 연결
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        // profile cell 등록
        profileCollectionView.register(
            UINib(
                nibName: "ProfileCollectionViewCell",
                bundle: nil),
            forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
        // post cell 등록
        profileCollectionView.register(
            UINib(
                nibName: "PostCollectionViewCell",
                bundle: nil),
            forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell(gestureRecognizer: )))
        
        gesture.minimumPressDuration = 0.66
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        profileCollectionView.addGestureRecognizer(gesture)
        
        
    }
    
    private func setupData() {
        UserFeedDataManager().getUserFeed(self)
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // section의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2   // 하나는 profile 나머지 하나는 profile 아래
    }
    
    
    // cell의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:  // 0 번째 section
            return 1
        default: // 1 번째 section
            return userPosts?.count ?? 0
        }
    }
    
    // cell 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0: // 0 번째 section = Profile section에 있는 cell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else {
                fatalError("셀 타입 캐스팅 실패 .. ")
            }
            return cell
        default: // 1 번째 section = Post section에 있는 cell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else {
                fatalError("셀 타입 캐스팅 실패 .. ")
                }
            
            // 데이터 전달 (데이터가 있는 경우, cell 데이터 전달) 
            let itemIndex = indexPath.item
            
            if let cellData = self.userPosts {
                cell.setupData(cellData[itemIndex].postImgUrl)
            }
            
            return cell
        }
    }
}

        
        
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        switch section {
        case 0:
            return CGSize(
                width: collectionView.frame.width,
                height: CGFloat(159))
        default:
            let side = CGFloat((collectionView.frame.width / 3) - (4/3))
            return CGSize(width: side, height: side)
        }
        
    } // collectionview custom 
    
    // item 간의 spacing (열 간 간격)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    
    // line 간의 spacing (행 간 간격)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    
}

// MARK: - API 통신 메소드
extension ProfileViewController {
    func successFeedAPI(_ result: UserFeedModel) {
        self.userPosts = result.result?.getuserPosts
    }
    
    func successDeletePostAPI(_ isSuccess: Bool)  {
        guard isSuccess else { return }
        
        // long press를 했을 때 데이터를 받음
        if let deletedIndex = self.deletedIndex {
            self.userPosts?.remove(at: deletedIndex)
        }
    }
}
