//
//  StoryTableViewCell.swift
//  Catstagram
//
//  Created by 김민지 on 4/8/24.
//


import UIKit

class StoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Controller : collectionView 셀이 표시될 때 해당 셀의 데이터를 적절히 표시
    // -> tableview 셀 안에 collectionview를 넣기 위함.
    func setCollectionViewDataSourceDelegate(dataSoureDelegate : UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int ) {
        collectionView.delegate = dataSoureDelegate
        collectionView.dataSource = dataSoureDelegate
        // 여러개의 UICollectionView를 식별하기 위해 tag를 지정
        collectionView.tag = row
        // collectionView에 사용할 cell 등록 -> nib 파일을 이용해서 cell을 넣었기에 UINib 사용됨
        let storyNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        collectionView.register(storyNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
        // View : UICollectionView의 layout 설정
        // 스토리를 세로가 아닌 가로로 스크롤하기 위함
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 12
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.reloadData()
    }
    
    // StoryTableView에 대한 cell 초기화
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // 셀이 선택되었을 때 화면에 어떤 반응을 보여줄지를 결정
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
