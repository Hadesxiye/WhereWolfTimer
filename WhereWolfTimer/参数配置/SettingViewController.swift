//
//  SettingViewController.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/21.
//

import UIKit
import AYPopupPickerView

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellID = "cellID"
    let textID = "textCell"
    /*
     人数
     个人发言时间 10人 45s; 12人 60s
     警上发言时间 60s
     遗言时间 30s
     夜晚时间 60s
     应急时间 300s
     期望时长
     
     预计时间：
     
     完成配置
     */
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        view.tableFooterView = UIView()
        view.register(TextCell.self, forCellReuseIdentifier: textID)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.title = "参数配置"
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    let setNames = ["总人数", "发言", "警上发言", "投票", "遗言", "夜晚时间", "应急预留", "期望总时长"]
    var setValues = [shareTime.personSum, shareTime.personTime, shareTime.campaignTime, shareTime.voteTime, shareTime.deadTime, shareTime.nightTime, shareTime.reservedTime, shareTime.expectedTime]
    
    let timeNames = ["第1天", "第2天", "第3天", "第4天", "第5天", "第6天", "整场游戏预计时间"]
    var timeValues = [shareTime.day1, shareTime.day2, shareTime.day3, shareTime.day4, shareTime.day5, shareTime.day6, shareTime.totalTime]
    
    let nineTimeNames = ["第1天", "第2天", "第3天", "第4天", "整场游戏预计时间"]
    var nineTimeValues = [shareTime.day1, shareTime.day2, shareTime.day3, shareTime.day4, shareTime.totalTime]
    
    let titles = ["基础设置", "预计时间" , "结束配置"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return setNames.count
        case 1:
            if shareTime.personSum > 10.0 {
                return timeNames.count
            }
            else{
                return nineTimeNames.count
            }
        default:
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 2 {
            let cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellID)
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.detailTextLabel?.text = "\(Int(setValues[indexPath.row])) 人"
                }
                else if indexPath.row == 7{
                    cell.detailTextLabel?.text = "\(Int(setValues[indexPath.row])) 分钟"
                }
                else{
                    cell.detailTextLabel?.text = "\(Int(setValues[indexPath.row])) 秒"
                }
                cell.textLabel?.font = UIFont.sySong(size: 16)
                cell.textLabel?.text = setNames[indexPath.row]
                cell.detailTextLabel?.font = UIFont.sySong(size: 15)
                
                cell.selectionStyle = .none
                return cell
            }
            else{
                cell.textLabel?.font = UIFont.sySong(size: 16)
                cell.detailTextLabel?.font = UIFont.sySong(size: 15)
                
                if shareTime.personSum > 10 {
                    cell.textLabel?.text = timeNames[indexPath.row]
                    cell.detailTextLabel?.text = "\(timeValues[indexPath.row].minStr())"
                }
                else{
                    cell.textLabel?.text = nineTimeNames[indexPath.row]
                    cell.detailTextLabel?.text = "\(nineTimeValues[indexPath.row].minStr())"
                }

                cell.selectionStyle = .none
                return cell
            }
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: textID) as! TextCell
            cell.centerText.text = "开始游戏"
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            //人数
            if indexPath.row == 0 {
                let itemsTitle = ["9", "10", "11", "12", "13", "14"]
                let popupPickerView = AYPopupPickerView()
                popupPickerView.display(itemTitles: itemsTitle, doneHandler: {
                    let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
                    shareTime.personSum = CGFloat(Double(itemsTitle[selectedIndex])!)
                    self.dataReload()
                })
            }
            else{
                //投票
                if indexPath.row == 3 {
                    let itemsTitle = ["10", "15", "20"]
                    let popupPickerView = AYPopupPickerView()
                    popupPickerView.display(itemTitles: itemsTitle, doneHandler: {
                        let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
                        shareTime.voteTime = CGFloat(Double(itemsTitle[selectedIndex])!)
                        self.dataReload()
                    })
                }
                //预留时间
                else if indexPath.row == 6 {
                    let itemsTitle = ["60", "120", "180", "240", "300", "360"]
                    let popupPickerView = AYPopupPickerView()
                    popupPickerView.display(itemTitles: itemsTitle, doneHandler: {
                        let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
                        shareTime.reservedTime = CGFloat(Double(itemsTitle[selectedIndex])!)
                        self.dataReload()
                    })
                }
                //期望时间
                else if indexPath.row == 7 {
                    let itemsTitle = ["30", "40", "50", "60", "70", "80"]
                    let popupPickerView = AYPopupPickerView()
                    popupPickerView.display(itemTitles: itemsTitle, doneHandler: {
                        let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
                        shareTime.expectedTime = CGFloat(Double(itemsTitle[selectedIndex])!)
                        self.dataReload()
                    })
                }
                else{
                    let itemsTitle = ["30", "45", "60", "75", "90", "120"]
                    let popupPickerView = AYPopupPickerView()
                    popupPickerView.display(itemTitles: itemsTitle, doneHandler: {
                        let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
                            print("选择的值 \(CGFloat(Double(itemsTitle[selectedIndex])!))")
                        switch indexPath.row{
                            case 1:
                                shareTime.personTime = CGFloat(Double(itemsTitle[selectedIndex])!)
                            case 2:
                                shareTime.campaignTime = CGFloat(Double(itemsTitle[selectedIndex])!)
                            case 4:
                                shareTime.deadTime = CGFloat(Double(itemsTitle[selectedIndex])!)
                            case 5:
                                shareTime.nightTime = CGFloat(Double(itemsTitle[selectedIndex])!)
                        default:
                            print("other select")
                        }
                        self.dataReload()
                    })
                }
                
            }
            
        case 1:
            print("no thing")
        default:
            setOver()
        }
    }

    func setOver() -> Void {
        let vc = TimeViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func dataReload() -> Void {
   
        setValues = [shareTime.personSum, shareTime.personTime, shareTime.campaignTime, shareTime.voteTime, shareTime.deadTime, shareTime.nightTime, shareTime.reservedTime, shareTime.expectedTime]

        timeValues = [shareTime.day1, shareTime.day2, shareTime.day3, shareTime.day4, shareTime.day5, shareTime.day6, shareTime.totalTime]
        
        nineTimeValues = [shareTime.day1, shareTime.day2, shareTime.day3, shareTime.day4, shareTime.totalTime]
        
        self.tableView.reloadData()
    }
}

extension CGFloat{
    func minStr() -> String {
        let min: Int = Int(ceil(Double(self/60)))
        return "\(min) 分钟"
    }
}
