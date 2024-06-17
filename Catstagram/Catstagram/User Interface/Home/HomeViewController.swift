//
//  HomeViewController.swift
//  Catstagram
//
//  Created by 김민지 on 4/7/24.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrayCat : [FeedModel] = []
    
    // 이미지를 선택할 수 있는 뷰컨트롤러 설정
    let imagePickerViewController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self = 현재의 뷰 컨트롤러를 가르킴
        // 현재의 뷰 컨트롤러가 테이블뷰의 delegate와 dataSoure로 동작
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        // 테이블 뷰가 화면에 표시될 때 피드와 스토리를 표시하기 위한 cell 등록
        let feedNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedNib, forCellReuseIdentifier: "FeedTableViewCell")
        let storyNib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: "StoryTableViewCell")
        
        // tableView에 데이터 삽입 (FeedDataManager에서 url과 통신해서 가져온 데이터)
        let input = FeedAPIInput(limit: 10, page: 0)
        FeedDataManager().feedDataManager(input, self)
        
        imagePickerViewController.delegate = self
    }
    
    // 사진 앨범 연동하기
    @IBAction func buttonGoAlbum(_ sender: Any) {
        self.imagePickerViewController.sourceType = .photoLibrary
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    // 테이블 뷰 관리, 각 cell에 대한 설정 및 동작 처리 => View Controller (delegate, datasource)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCat.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell
                else {
                    return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell
            else {
                return UITableViewCell()
            }
            // Kingfisher를 사용하여 이미지를 로드할 때 URL 객체를 사용하여 이미지 위치 지정
            // Kingfisher가 해당 URL에서 이미지를 가져와서 캐시하고 표시
            if let urlString = arrayCat[indexPath.row - 1].url {
                let url = URL(string: urlString)
                cell.imageViewFeed.kf.setImage(with: url)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80               // 첫번째 section의 높이 = 80
        } else {
            return 600              // 두번째 section의 높이 = 600
        }
    }
    
    // StoryTableViewCell일 떄, 해당 셀에 대한 dataSoruce와 delgate 설정
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? StoryTableViewCell else {
            return
        }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSoureDelegate: self, forRow: indexPath.row)
    }
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = UICollectionViewCell()
//        cell.backgroundColor = .black
//        return cell
//    }
//    
    // table view 안에 있는 StoryCollectionViewCell에 대해 degate
    // 셀의 재사용을 관리하기 떄문에 dataSoruce의 역할
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
}

// API 응답을 받았을 때 새로운 데이터가 표시
extension HomeViewController {
    func successAPI(_ result : [FeedModel]) {
        arrayCat = result
        tableView.reloadData()
    }
}

extension HomeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 시용자가 사진 앨번에서 이미지 선택 후 (= didFinishPickingMediawithInfo) 발생하는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageString = "gs://catstagram-d7fbf.appspot.com/Cat"
            let input = FeedUploadInput(content: "우리집 고양이 츄르를 좋아해", postImgUrl: [imageString])
            // 서버에 데이터 업로드
            FeedUploadDataManager().posts(self, input)
            
            // 성공시 dismiss 처리로 이전 화면으로 돌아가게 됨
            self.dismiss(animated: true, completion: nil)
        }
    }
}
