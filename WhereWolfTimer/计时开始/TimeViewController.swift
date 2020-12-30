//
//  TimeViewController.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/21.
//

import UIKit

class TimeViewController: UIViewController, UICollectionViewDataSource {

    lazy var centerClock: HadesSecondTimer = {
        let view = HadesSecondTimer()
        return view
    }()
    
    let timeDetailHeight: CGFloat = 100
    let timeDetailSpace: CGFloat = 50
    
    var clockTime: Int = 20
    var historyTime: Int = 0
    var reservedTime: Int = 0
    var expectedMinute: Int = 0
    
    let buttonSpace: CGFloat = 30
    let buttonHei: CGFloat = 30
    
    lazy var back: UIButton = {
        let btn = UIButton()
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.sySong(size: 15)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        btn.titleLabel?.textAlignment = .left
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 15
        btn.alpha = 0.8
        return btn
    }()
    
    @objc func backAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var presentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.sySong(size: 60)
        label.textColor = .black
        label.alpha = 0.8
        return label
    }()
    
    lazy var person: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("发言", for: .normal)
        button.titleLabel?.font = UIFont.sySong(size: 15)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonHei/2
        button.addTarget(self, action: #selector(personTime), for: .touchUpInside)
        button.alpha = 0.7
        return button
    }()
    
    lazy var dead: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("遗言", for: .normal)
        button.titleLabel?.font = UIFont.sySong(size: 15)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonHei/2
        button.addTarget(self, action: #selector(deadTime), for: .touchUpInside)
        button.alpha = 0.7
        return button
    }()
    
    lazy var night: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("入夜", for: .normal)
        button.titleLabel?.font = UIFont.sySong(size: 15)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonHei/2
        button.addTarget(self, action: #selector(nightTime), for: .touchUpInside)
        button.alpha = 0.7
        return button
    }()
    
    lazy var campaign: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("警上", for: .normal)
        button.titleLabel?.font = UIFont.sySong(size: 15)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonHei/2
        button.addTarget(self, action: #selector(campaignTime), for: .touchUpInside)
        button.alpha = 0.7
        return button
    }()
    
    //预留时间  剩余时间  时间进度
    lazy var timeDetail: TimeDetailView = {
        let scwid = UIApplication.shared.keyWindow?.bounds.width
        let layout = UICollectionViewFlowLayout()
        let itemWid = (scwid! - timeDetailSpace*2)/3
        layout.itemSize = CGSize(width: itemWid, height: timeDetailHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: timeDetailSpace, bottom: 0, right: timeDetailSpace)
        let view = TimeDetailView(frame: CGRect.zero, collectionViewLayout: layout)
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockTime = Int(shareTime.nightTime)
        historyTime = 0
        reservedTime = Int(shareTime.reservedTime)
        expectedMinute = Int(shareTime.expectedTime)
        
        self.view.backgroundColor = .white
        self.view.addSubview(centerClock)
        self.view.addSubview(timeDetail)
        self.view.addSubview(presentLabel)
        timeDetail.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-100)
            make.height.equalTo(timeDetailHeight)
        }
        centerClock.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
            make.bottom.equalTo(timeDetail.snp.top).offset(-10)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        presentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.centerClock.snp.top)
            make.top.equalTo(0)
        }
        
        presentLabel.text = "夜 晚"
        
        self.view.addSubview(person)
        self.view.addSubview(dead)
        self.view.addSubview(campaign)
        self.view.addSubview(night)
        self.view.addSubview(back)
        back.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.height.equalTo(30)
            make.left.equalTo(-15)
            make.top.equalTo(30)
        }
        
        
        let buttonWid = (self.view.bounds.width - 5*buttonSpace)/4
        
        campaign.snp.makeConstraints { (make) in
            make.left.equalTo(buttonSpace)
            make.bottom.equalTo(-buttonSpace)
            make.width.equalTo(buttonWid)
            make.height.equalTo(buttonHei)
        }
        
        dead.snp.makeConstraints { (make) in
            make.left.equalTo(campaign.snp.right).offset(buttonSpace)
            make.bottom.equalTo(-buttonSpace)
            make.width.equalTo(buttonWid)
            make.height.equalTo(buttonHei)
        }
        
        person.snp.makeConstraints { (make) in
            make.left.equalTo(dead.snp.right).offset(buttonSpace)
            make.bottom.equalTo(-buttonSpace)
            make.width.equalTo(buttonWid)
            make.height.equalTo(buttonHei)
        }
        
        night.snp.makeConstraints { (make) in
            make.left.equalTo(person.snp.right).offset(buttonSpace)
            make.bottom.equalTo(-buttonSpace)
            make.width.equalTo(buttonWid)
            make.height.equalTo(buttonHei)
        }
        
        HadesTimer.share.scheduledDispatchTimer(withName: "clock", timeInterval: 1, queue: .main, repeats: true) {
            self.historyTime = self.historyTime + 1
            if self.clockTime > 0 {
                //走正常计时
                self.clockTime = self.clockTime - 1
                self.setClock(seconds: self.clockTime)
            }
            else{
                //走零碎计时
                self.reservedTime = self.reservedTime - 1
            }
            self.timeDetail.reloadData()
            
        }
    }
    
    @objc func personTime() -> Void {
        self.clockTime = Int(shareTime.personTime)
        presentLabel.text = "发 言"
    }
    
    @objc func campaignTime() -> Void {
        self.clockTime = Int(shareTime.campaignTime)
        presentLabel.text = "警 上"
    }
    
    @objc func deadTime() -> Void {
        self.clockTime = Int(shareTime.deadTime)
        presentLabel.text = "遗 言"
    }
    
    @objc func nightTime() -> Void {
        self.clockTime = Int(shareTime.nightTime)
        presentLabel.text = "夜 晚"
    }
    
    func setClock(seconds: Int) -> Void {
        centerClock.setSecond(seconds: seconds)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    let timeNames = ["应急时间", "进度", "剩余时间"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timeCellID, for: indexPath) as! TimeCell
        cell.timeName.text = timeNames[indexPath.row]
        if indexPath.row == 0 {
            cell.time.attributedText = getReserved()
        }
        else if indexPath.row == 1{
            cell.time.attributedText = getProgress()
        }
        else{
            cell.time.attributedText = getRemain()
        }
        
        return cell
    }
    
    func getProgress() -> NSMutableAttributedString {
        let result = Float(historyTime)/(60*Float(expectedMinute))*100
        print("result \(result)" + "history" + "\(historyTime)")
        let str = String(format: "%.1f", result)
        print(str)
        let minStr = NSMutableAttributedString(string: "\(str)", attributes: [.font: UIFont.din(size: 20), .foregroundColor : UIColor.red])
        let fenStr = NSMutableAttributedString(string: "%", attributes: [.font: UIFont.sySong(size: 12), .foregroundColor : UIColor.gray])
        minStr.append(fenStr)
        return minStr
    }
    
    func getRemain() -> NSMutableAttributedString {
        let history: Int = historyTime/60
        let remain: Int = expectedMinute - history
        let minStr = NSMutableAttributedString(string: "\(remain)", attributes: [.font: UIFont.din(size: 20), .foregroundColor : UIColor.red])
        let fenStr = NSMutableAttributedString(string: "分钟", attributes: [.font: UIFont.sySong(size: 12), .foregroundColor : UIColor.gray])
        minStr.append(fenStr)
        return minStr
    }
    
    func getReserved() -> NSMutableAttributedString {
        let reserved: Int = self.reservedTime
        let reservedStr = NSMutableAttributedString(string: "\(reserved)", attributes: [.font: UIFont.din(size: 20), .foregroundColor : UIColor.red])
        let fenStr = NSMutableAttributedString(string: "秒", attributes: [.font: UIFont.sySong(size: 12), .foregroundColor : UIColor.gray])
        reservedStr.append(fenStr)
        return reservedStr
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}
