//
//  TextCell.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/21.
//

import UIKit

class TextCell: UITableViewCell {

    lazy var centerText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.sySong(size: 20)
        label.textColor = .red
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(centerText)
        centerText.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
