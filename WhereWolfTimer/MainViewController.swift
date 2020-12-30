//
//  MainViewController.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/21.
//

import UIKit

class MainViewController: UIViewController {

    lazy var logo: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo_white"))
        view.contentMode = UIView.ContentMode.scaleAspectFit
        return view
    }()
    
    lazy var copyright: UILabel = {
        let label = UILabel()
        label.font = UIFont.din(size: 10)
        label.text = "Copyright © 2020 Hades All rights reserved."
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("开始计时配置", for: .normal)
        btn.titleLabel?.font = UIFont.sySong(size: 20)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(setupTime), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let item = UIBarButtonItem(title: "返回", style: .plain, target: self , action: nil)
        self .navigationItem.backBarButtonItem = item
        self.view.backgroundColor = .white
        self.view.addSubview(logo)
        self.view.addSubview(copyright)
        let temp = UIView()
        self.view.addSubview(temp)
        temp.addSubview(button)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.top.equalTo(150)
        }
        copyright.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(30)
        }
        temp.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom)
            make.bottom.equalTo(copyright.snp.top)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        button.snp.makeConstraints { (make) in
            make.center.equalTo(temp.snp.center)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func setupTime() -> Void {
        let vc = SettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
