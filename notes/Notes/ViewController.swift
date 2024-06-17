//
//  ViewController.swift
//  Notes
//
//  Created by 김민지 on 3/29/24.
//

import UIKit

class ViewController: UITableViewController {
    var notes: [Note] = []  // 모든 메모 목록을 메모리에 저장
    
    @IBAction func createNote() {
        let _ = NoteManager.main.create()
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    } // 앱이 처음 실행될 떄 데이터베이스에서 모든 메모를 가져오고 tableview에 업데이트
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count // 테이블 행의 수 = 노트 배열의 크기
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].contents
        return cell
    } // 셀을 가져와서 데이터를 기반으로 셀의 속성을 변경한 후 반환
    
    
    func reload() {
        notes = NoteManager.main.getAllNotes()
        self.tableView.reloadData()
    } // reload the tableview
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteSegue" {
            if let destination = segue.destination as?
                NoteViewController {
                destination.note = notes[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}

