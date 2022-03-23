//
//  main.swift
//  Zajecia-5
//
//  Created by Szymon Kaszuba-Gałka on 23/03/2022.
//

import Foundation

var documentsInfo: Dictionary<String, Dictionary<String, Any>> = [
    "document_1" : [
        "title": "\"Universe in a nutshell\" by Stephen Hawking",
        "topics": ["universe", "science", "maths", "phisics"],
        "formats": ["doc", "docx", "pdf", "e_book", "hard_copy"]
    ],
    "document_2": [
        "title": "\"Short story of time\" by Stephen Hawking",
        "topics": ["time", "science", "maths", "phisics"],
        "formats": ["e_book", "hard_copy"]
    ]
]

var documents: [Document] = []
var tags: Set<Tag> = Set()

for documentInfo in documentsInfo {
    let topics: Array<String> = documentInfo.value["topics"] as! Array<String>
    let formats: Array<String> = documentInfo.value["formats"] as! Array<String>
    for topic in topics {
        let tag: Tag = Tag(short: topic, long: nil, des: nil)
        tags.insert(tag)
    }
    for format in formats {
        let tag: Tag = Tag(short: format, long: nil, des: nil)
        tags.insert(tag)
    }
    let document: Document = Document(p: "memeBoi", t: tags, m: Meta(desc: documentInfo.value["title"] as! String))
    documents.append(document)
    tags = Set()
}

print(documents)
