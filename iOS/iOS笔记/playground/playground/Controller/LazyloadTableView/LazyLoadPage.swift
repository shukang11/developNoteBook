//
//  LazyLoadPage.swift
//  playground
//
//  Created by tree on 2018/6/1.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class LazyLoadPage: SYViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK:property
    var lazyVM: LazyLoadModel = LazyLoadModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lazyVM.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        }
        guard let c = cell else { return UITableViewCell.init() }
        let item = self.lazyVM.datas[row]
        c.textLabel?.text = item.title
        c.imageView?.kf.setImage(with: URL(string: item.imageURL))
        c.detailTextLabel?.text = item.desc
        return c
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if self.lazyVM.datas.count - row == 3 {
            print("加载下一页")
            self.lazyVM.nextPage(completion: { (error) in
                if error == nil {
                    self.tableView.reloadData()
                }
            })
        }
    }
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createUI()
        
        lazyVM.lazyRequest(page: 1, limit: 20) { [weak self] (error) in
            if error == nil {
                self?.tableView.reloadData()
            }
        }
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        view.backgroundColor = UIColor.gray
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {(make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(
                    self.navigationController?.additionalSafeAreaInsets ?? UIEdgeInsets.zero
                )
            }else {
                make.edges.equalToSuperview()
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

struct LazyItem: Codable {
    var title: String
    var desc: String
    var imageURL: String
    
}

func randomPic(source: [String]) -> String {
    let index = Int(arc4random_uniform(UInt32(source.count)))
    return source[index]
}

func randomData() -> LazyItem {
    let titles = ["贝因美", "一号店铺", "随机获取字符数组", "必须是字符串", "这种方法"]
    let descs: [String] = ["描述一号", "从一个字符数组中随机获取一个元素", "使用泛型范围获取数组或区间中随机元素", "如果我们想生成一个指定范围内的整型随机数", "我们在控制台中通过man arc4random命令，可以查看arc4random的文档，有这么一条："]
    let images: [String] = ["http://cc.cocimg.com/api/uploads/20151009/1444376072325147.jpg", "http://cdn.cocimg.com/cms/templets/images/article_weixin.jpg", "https://image.baidu.com/search/detail?ct=503316480&z=&tn=baiduimagedetail&ipn=d&word=icon&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=-1&cs=3184736237,2436456994&os=1820995391,4269797839&simid=0,0&pn=0&rn=1&di=14028944820&ln=1991&fr=&fmq=1527835855676_R&ic=0&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&is=0,0&istype=2&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=0&objurl=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0106e556514e2c6ac7251c94837b5e.jpg&rpstart=0&rpnum=0&adpicid=0", "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527845956999&di=fd7d97091848025c6c12051e4a4efe80&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01b696554231c10000019ae92c52f6.jpg", "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527845956999&di=567b1f234efade775fcc7c4225e546ae&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F30adcbef76094b366f0189d1a8cc7cd98d109d7f.jpg"]
    
    return LazyItem.init(title: randomPic(source: titles), desc: randomPic(source: descs), imageURL: randomPic(source: images))
}

class LazyLoadModel: NSObject {
    
    var datas: [LazyItem] = []
    
    var page: Int = 1
    
    var limit: Int = 20
    
    var isLoading: Bool = false {
        willSet {
            print("isLoading changed to \(!isLoading)")
        }
    }
    
    func lazyRequest(page: Int, limit: Int, completion: @escaping (_ error: String?) -> ()) -> Void {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            if page > 20 {
                completion("no more data")
                return
            }
            
            for _ in 0..<limit {
                self.datas.append(randomData())
            }
            self.isLoading = false
            completion(nil)
        }
    }
    
    func nextPage(completion: @escaping (_ error: String?) -> ()) -> Void {
        page += 1
        lazyRequest(page: self.page, limit: self.limit, completion: completion)
    }
}

