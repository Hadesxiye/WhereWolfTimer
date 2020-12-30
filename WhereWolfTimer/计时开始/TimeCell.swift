//
//  TimeCell.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/21.
//

import UIKit

class TimeCell: UICollectionViewCell {
    
    lazy var time: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.din(size: 20)
        label.textColor = .red
        return label
    }()
    
    lazy var timeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.sySong(size: 15)
        label.textColor = .gray
        return label
    }()
    
    lazy var timeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
//        view.layer.borderWidth = 0.3
//        view.layer.borderColor = UIColor.gray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        view.layer.shadowColor = UIColor.black.cgColor
        
        view.addSubview(timeName)
        view.addSubview(time)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(timeView)
        timeView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        time.snp.makeConstraints { (make) in
            make.center.equalTo(timeView.snp.center)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(50)
        }
        timeName.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(time.snp.top)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
