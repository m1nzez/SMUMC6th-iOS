//
//  Note.swift
//  Notes
//
//  Created by 김민지 on 3/29/24.
//

import Foundation
import SQLite3

struct Note {
    let id: Int
    var contents: String
}

class NoteManager { // 데이터베이스 연결, 메모생성, 메모 가져오기 및 메모 업데이트 처리 기능
    var database: OpaquePointer!
    
    static let main = NoteManager() // instance 없이 속성에 excess가능
    
    private init() {

    }
    
    func connect() {
        if database != nil {
            return  // database가 지금 nil이 아닌상태
        }
        
        do {
            let databaseURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("notes.sqlites3") // 사용자의 핸드폰에 있는 파일의 경로를 얻는 방법
            
            if sqlite3_open(databaseURL.path, &database) == SQLITE_OK { // 데이터베이스에 연결하려는 위치 지정
                if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS notes (contents TEXT)", nil, nil , nil) == SQLITE_OK {
                    
                }
                else {
                    print("Could not create table")
                }
            }
            else {
                print ("Could not connect")
            }
        }
        catch let error {
            print("Could not create database")
        }
    }
    
    func create() -> Int {
        connect() // 데이터베이스에 연결
        
        var statement: OpaquePointer!
        if sqlite3_prepare_v2(database, "INSERT INTO notes (contents) VALUES ('New note')", -1, &statement, nil) != SQLITE_OK {
            print("Could not create query")
            return -1
        } // 쿼리를 사용하여 notes table에 새로운 노트를 추가하는 쿼리 준비
        
        if  sqlite3_step(statement) != SQLITE_DONE {
            print("Could not insert note")
            return -1
        } // 준비된 쿼리를 실행해 데이터베이스에 새로운 노트 추가
        
        sqlite3_finalize(statement) // SQL 문 종료
        return Int(sqlite3_last_insert_rowid(database)) // 삽입된 노트의 ID 반환: 각 행에 대한 식별자를 가지는데 나중에 노트를 수정하거나 삭제할 떄 삽입된 노트의 ID를 사용해 데이터베이스에서 해당 노트 식별 가능
    }
    
    func getAllNotes() -> [Note] {
        connect()
        var result: [Note] = []
        
        var statement: OpaquePointer!
        if sqlite3_prepare_v2(database, "SELECT rowid, contents FROM notes", -1, &statement, nil) != SQLITE_OK {
            print("Error creating select")
            return[]
        } //notes 테이블에서 데이터를 선택하기 위한 sql쿼리를 준비
        
        while sqlite3_step(statement)  == SQLITE_ROW {  // 읽을 수 있는 행이 있을 때마다 result에 추가
            result.append(Note(id: Int(sqlite3_column_int(statement, 0)), contents: String(cString: sqlite3_column_text(statement, 1))))
        } // 각 노트의 행에 대한 ID와 contents를 가져와서 추가할 수 있도록 함
          // 첫번째 열 = 노트의 ID , 두번째 열 = 노트의 contents
        
        sqlite3_finalize(statement)
        return result    // 쿼리를 연결했기에 note의 빈 배열이 반환됨
    }
    
    func save(note: Note) {
        connect()
        var statement: OpaquePointer!
        if sqlite3_prepare_v2(database, "UPDATE notes SET contents = ? WHERE rowid = ?", -1, &statement, nil) != SQLITE_OK {
            print ("Error creating update statement")
        }
        
        sqlite3_bind_text(statement, 1, NSString(string: note.contents).utf8String, -1, nil) // 첫번째 매개변수('?'위치에 있는 매개변수) 에 문자열 값을바인딩
        sqlite3_bind_int(statement, 2, Int32(note.id)) // 두번째 매개변수 ('?'위치에 있는 매개변수) 에 정수값을 바인딩
        // ID와 content의 값을 바인딩함으로써 sql 문이 실행할 때마다 해당 값이 쿼리에 적용되고 데이터베이스에 저장됨
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Error running update")
        }
        
        sqlite3_finalize(statement)
    }
}

