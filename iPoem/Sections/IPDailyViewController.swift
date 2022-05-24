//
//  IPDailyViewController.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/21.
//

import UIKit

class IPDailyViewController: UIViewController {
    
    var token: String? {
        didSet {
            getSentence()
        }
    }
    var response: SentenceResponse?
    var sentences: [String]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(IPDailyCell.self, forCellWithReuseIdentifier: "IPDailyCell")
        collectionView.register(IPDailyHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "IPDailyHeader")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reload")?.withTintColor(.theme), for: .normal)
        button.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        return button
    }()
    
    lazy var backgroundView: UIView = {
        let bgView = UIImageView()
        bgView.image = UIImage(named: "background_daliy")
        bgView.clipsToBounds = true
        bgView.contentMode = .scaleAspectFill
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "今日推荐"
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        view.addSubview(collectionView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(reloadButton)
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        reloadButton.snp.makeConstraints { make in
            make.width.equalTo((reloadButton.currentImage?.size.width)! + 40)
            make.height.equalTo((reloadButton.currentImage?.size.height)! + 40)

            make.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-bottom - 49)
        }
        
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        loadLocalData()
        getToken()
        
        let barItem =  UIBarButtonItem(image: UIImage(named: "detail_more"), style: .plain, target: self, action: #selector(moreEvent))
        barItem.tintColor = .white
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc func moreEvent() {
        let vc = IPMoreViewController()
        let nav = IPNavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, keyPath == "contentSize", let object = object as? UICollectionView, object == collectionView  {
            if let contentSize = change?[.newKey] as? CGSize {
                if contentSize.height < collectionView.bounds.height - 120 {
                    let top = (collectionView.bounds.height - 120 - contentSize.height) / 2
                    collectionView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: 20, right: 0)
                } else {
                    collectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0)

                }
            }
        }

    }
     
    @objc func reloadData() {
        getSentence()
    }
    

    func getToken() {
        if let token = UserDefaults.standard.object(forKey: "token") as? String {
            self.token = token
            
            return
        }
        IPNetWorking<TokenResponse>().request("https://v2.jinrishici.com/token") { data, error in
            if let _ = error {
                self.getSentence()
                return
            }
            self.token = data?.data
            UserDefaults.standard.setValue(self.token, forKey: "token")
            UserDefaults.standard.synchronize()
        }
    }

    func getSentence() {
        var header = [String:String]()
        if let token = token {
            header["X-User-Token"] = token
        }
        IPNetWorking<SentenceResponse>().request("https://v2.jinrishici.com/sentence", method:"GET", header: header.count > 0 ? header : nil) { data, error in
            if let _ = error {
                DispatchQueue.main.async {
                    ToastHelepr.show("获取诗词失败，请稍后再试")
                }
                return
            }
            self.onDataDidLoad(data)
        }
    }
        
    func onDataDidLoad(_ data: SentenceResponse?) {
        self.response = data
        if let content = data?.data.origin.content {
            
            let sentences = content.map { string in
                string.trimmingCharacters(in: .whitespaces)
            }.flatMap({ string in
                string.components(separatedBy: "。")
            }).filter({ string in
                return string.count != 0
            }).map({ string in
                appendDot(string)
            })
            
            self.sentences = sentences
            if let tags = data?.data.matchTags {
                let text = "< \(tags.joined(separator: " · ")) >"
                self.sentences?.append(text)
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        saveData()
    }
    
    func appendDot(_ string: String) -> String {
        let index = string.index(before: string.endIndex)
        if string[index] == "？" || string[index] == "！" {
            return string
        }
        return string.appending("。")
    }
    
    func saveData() {
        guard let response = response else {
            return
        }
        let encoder = JSONEncoder.init()
        do {
            let da = try encoder.encode(response)
            let filePath = NSHomeDirectory() + "/Library/Caches/daliy.data"
            let url = URL(fileURLWithPath: filePath)
            try da.write(to: url)
        } catch let error {
            print(error)
        }
    }
    
    func loadLocalData() {
        let filePath = NSHomeDirectory() + "/Library/Caches/daliy.data"
        let url = URL(fileURLWithPath: filePath)
        guard let data = NSData(contentsOf: url) as? Data else { return }
        let decoder = JSONDecoder()
        do {
            let resp = try decoder.decode(SentenceResponse.self, from: data)
            onDataDidLoad(resp)
        } catch let error {
            print(error)
        }
    }
    
}

extension IPDailyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sentences?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IPDailyCell", for: indexPath) as! IPDailyCell
        cell.text = sentences?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: IPDailyCell.height(sentences![indexPath.item], collectionView.bounds.width))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "IPDailyHeader", for: indexPath) as! IPDailyHeader
        view.origin = response?.data.origin
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: IPDailyHeader.height(response?.data.origin.title, collectionView.bounds.width))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
