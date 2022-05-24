//
//  Poem.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/22.
//

import Foundation
import UIKit

struct IPPoem {
    var title: String
    var name: String
    var fileName: String
    var type: IPPoemType

    var isFav: Bool {
        get {
            IPPoemFavManager.shared.isFav(self)
        }
    }
    init(title: String, name: String, fileName: String, type: IPPoemType) {
        self.title = title
        self.name = name
        self.fileName = fileName
        self.type = type
    }
    
    func toDict() -> Dictionary<String, String> {
        return ["title":title, "name":name, "fileName":fileName, "type":type.rawValue]
    }
    
}

enum IPPoemType: String {
    case tang = "唐"
    case song = "宋"
}

struct IPPoemCate {
    var image: UIImage?
    var title: String
    var fileName: String
    var type: IPPoemType
    var conetnt = [IPPoem]()
    
    init(title: String, image: String, fileName: String, type: IPPoemType = .tang) {
        self.title = title
//        self.image = UIImage(named: image)
        self.fileName = fileName
        self.type = type
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
            guard let array = NSArray(contentsOfFile: path) as? [Dictionary<String, String>] else { return }
            for dict in array {
                let poem = IPPoem(title: dict["title"] ?? "", name: dict["name"] ?? "", fileName: dict["WYHtml"] ?? "", type: type)
                self.conetnt.append(poem)
            }
        }
    }
}

let kFavPoemDidChange = "kFavPoemDidChange"

class IPPoemFavManager {
    static let shared = IPPoemFavManager()
    var favPoems: [IPPoem]!

    private init() {
        favPoems = [IPPoem]()

        if let array = UserDefaults.standard.array(forKey: "fav") as? [[String:String]]  {
            for dict in array {
                let poem = IPPoem(title: dict["title"]!, name: dict["name"]!, fileName: dict["fileName"]!, type: IPPoemType(rawValue: dict["type"]!)!)
                favPoems.append(poem)
            }
        }
    }
    
    func addFav(_ poem: IPPoem) {
        for p in favPoems {
            if p.fileName == poem.fileName {
                return
            }
        }
        favPoems.append(poem)
        save()
    }
    
    func removeFav(_ poem: IPPoem) {
        favPoems.removeAll(where: {$0.fileName == poem.fileName})
        save()
    }
    
    func isFav(_ poem: IPPoem) -> Bool {
        for p in favPoems {
            if p.fileName == poem.fileName {
                return true
            }
        }
        return false
    }
    
    func save() {
        NotificationCenter.default.post(name: .init(rawValue: kFavPoemDidChange), object: nil)
        var array = [[String:String]]()
        for poem in favPoems {
            array.append(poem.toDict())
        }
        UserDefaults.standard.set(array, forKey: "fav")
        UserDefaults.standard.synchronize()
    }
}
