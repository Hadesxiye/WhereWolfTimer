//
//  HadesTimer.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/21.
//

import UIKit
import SnapKit

class HadesSecondTimer: UIView {

    private lazy var secondsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(secondsLabel)
        secondsLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setSecond(seconds: Int) -> Void {
        let secondStr = NSMutableAttributedString(string: "\(seconds)", attributes: [.font: UIFont.din(size: 200)])
        let miaoStr = NSMutableAttributedString(string: "秒", attributes: [.font: UIFont.sySong(size: 20), .foregroundColor : UIColor.black])
        
        if seconds <= 10 {
            let music = MusicManager()
            
            if seconds == 0{
                music.endMusic()
            }
            else{
                music.secondMusic()
            }
            secondStr.addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 0, length: secondStr.length))
        }
        else{
            secondStr.addAttributes([.foregroundColor: UIColor.black], range: NSRange(location: 0, length: secondStr.length))
        }
        secondStr.append(miaoStr)
        self.secondsLabel.attributedText = secondStr;
    }
    
    
}

extension UIFont{
    class func din(size: CGFloat) -> UIFont {
        return UIFont(name: "DIN-Regular", size: size)!
    }
    
    class func sySong(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceHanSerifCN-Light", size: size)!
    }
}
