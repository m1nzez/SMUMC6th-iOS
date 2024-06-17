//
//  main.swift
//  Swift example
//
//  Created by 김민지 on 3/22/24.
//

import Foundation

class Track {
    let name: String
    let instructor: String
    
    init(name: String, instructor: String) {
        self.name = name
        self.instructor = instructor
    }
}

let tracks: [Track] = [
    Track(name:"Mobile", instructor: "Tommy"),
    Track(name: "Web", instructor: "Brian")
]

let students = ["Harry", "Ron", "Hermione"]

var assignments: [String : Track] = [ : ]
for student in students {
    let track = Int.random(in: 0 ..< tracks.count)
    assignments[student] = tracks[track]
    }

for (student, track) in assignments {
    print("\(student) got \(track.name) with \(track.instructor)")
}
