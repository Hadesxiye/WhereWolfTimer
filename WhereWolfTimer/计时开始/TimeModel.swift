//
//  TimeModel.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/21.
//

import UIKit

let shareTime = TimeModel()

class TimeModel: NSObject {

    var personSum: CGFloat = 10
    var personTime: CGFloat = 60
    var campaignTime: CGFloat = 60
    var voteTime: CGFloat = 10
    var deadTime: CGFloat = 12
    var nightTime: CGFloat = 60
    var reservedTime: CGFloat = 300
    var expectedTime: CGFloat = 45
    
    //零碎操作时间
    var fragmentTime: CGFloat = 0
    
    var day1: CGFloat{
        get{
            return (personSum/2*campaignTime + personSum*personTime + voteTime*2 + deadTime + nightTime)
        }
    }
    
    var day2: CGFloat{
        get{
            return ((personSum - 1)*personTime + voteTime + deadTime + nightTime)
        }
    }
    
    var day3: CGFloat{
        get{
            return ((personSum - 2)*personTime + voteTime + deadTime + nightTime)
        }
    }
    
    var day4: CGFloat{
        get{
            return ((personSum - 3)*personTime + voteTime + deadTime + nightTime)
        }
    }
    
    var day5: CGFloat{
        get{
            return ((personSum - 4)*personTime + voteTime + deadTime + nightTime)
        }
    }
    
    var day6: CGFloat{
        get{
            return ((personSum - 5)*personTime + voteTime + deadTime + nightTime)
        }
    }
    
    var totalTime: CGFloat{
        get{
            if personSum > 10.0 {
                return (day1 + day2 + day3 + day4 + day5 + day6 + reservedTime)
            }
            else{
                return (day1 + day2 + day3 + day4 + reservedTime)
            }
        }
    }
    
    override init() {
        super.init()
    }
}
