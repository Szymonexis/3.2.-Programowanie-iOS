//
//  Document.swift
//  Zajecia-5
//
//  Created by Szymon Kaszuba-Gałka on 23/03/2022.
//

import Foundation
import CommonCrypto


private func md5Hash (str: String) -> String {
    if let strData = str.data(using: String.Encoding.utf8) {
        var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
 
        strData.withUnsafeBytes {
            CC_MD5($0.baseAddress, UInt32(strData.count), &digest)
        }
 
        var md5String = ""
        for byte in digest {
            md5String += String(format:"%02x", UInt8(byte))
        }
 
        if md5String.uppercased() == "8D84E6C45CE9044CAE90C064997ACFF1" {
            print("Matching MD5 hash: 8D84E6C45CE9044CAE90C064997ACFF1")
        } else {
            print("MD5 hash does not match: \(md5String)")
        }
        return md5String
 
    }
    return ""
}

private func sha256(str: String) -> String {
    if let strData = str.data(using: String.Encoding.utf8) {
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))

        strData.withUnsafeBytes {
            CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
        }
 
        var sha256String = ""
        for byte in digest {
            sha256String += String(format:"%02x", UInt8(byte))
        }
 
        if sha256String.uppercased() == "E8721A6EBEA3B23768D943D075035C7819662B581E487456FDB1A7129C769188" {
            print("Matching sha256 hash: E8721A6EBEA3B23768D943D075035C7819662B581E487456FDB1A7129C769188")
        } else {
            print("sha256 hash does not match: \(sha256String)")
        }
        return sha256String
    }
    return ""
}


class Document: CustomStringConvertible {
    let uuid: UUID
    var path: String
    let checkSums: Dictionary<String, String>
    var tags: Set<Tag>
    var meta: Meta
    
    init (p: String, t: Set<Tag>, m: Meta) {
        let uuidVal = UUID()
        uuid = uuidVal
        path = p
        checkSums = [
            "md5": md5Hash(str: uuidVal.uuidString),
            "sha256": sha256(str: uuidVal.uuidString)
        ]
        tags = t
        meta = m
    }
    
    public var description: String {
        return "{\n\t uuid: \(uuid.uuidString) \n\t path: \(path) \n\t checkSums: \(checkSums) \n\t tags: \(tags) \n\t meta: \(meta.toString()) \n}"
    }
}

class Tag: Hashable {
    let uuid: UUID
    var shortName: String
    var longName: String?
    var desc: String?
    
    init(short: String, long: String?, des: String?) {
        uuid = UUID()
        shortName = short
        longName = long
        desc = des
    }
    
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.shortName == rhs.shortName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.shortName)
    }
    
    public var description: String {
        return "{\n\tuuid: \(uuid.uuidString)\n\tshortName: \(shortName)\n\tlongName: \(String(describing: longName))\n\tdescription: \(String(describing: desc))\n}"
    }
    
    public func toString() -> String {
        return "{\n\t uuid: \(uuid.uuidString) \n\t shortName: \(String(describing: shortName)) \n\t longName: \(String(describing: longName)) \n\t description: \(desc) \n}"
    }
}

class Meta {
    var description: String
    
    init(desc: String) {
        description = desc;
    }
    
    public func toString() -> String {
        return "description: \(description)"
    }
}
