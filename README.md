# WhereWolfTimer
狼人杀计时器，发言计时，狼人杀游戏时间预估。


## 功能

- 预估游戏消耗时间
- 显示游戏各阶段倒计时（目前包括：夜晚、警上发言、个人发言、遗言）

## 界面预览
![遗言倒计时](https://github.com/Hadesxiye/WhereWolfTimer/blob/main/image/review0.gif)

![参数配置](https://github.com/Hadesxiye/WhereWolfTimer/blob/main/image/review1.gif)

![夜晚](https://github.com/Hadesxiye/WhereWolfTimer/blob/main/image/review2.png)

## 使用场景

### 把控游戏时间&进度
在工作日有限的休息时间内，控制每个人发言时间，把控游戏进度，从而在休息时间结束时结束游戏。

### 提升氛围感
将手机投影在大屏幕上，倒计时会有 滴答 滴答 滴答的声音。
有需要还可以在夜晚播放背景音乐。

## 实现逻辑

1个每秒执行1次的计时器 + 一个单例数据模型

- 计时器用GCD的`DispatchSourceTimer`创建
- 数据模型属性在参数配置页面赋值
- 计时器触发时修改数据模型的相关属性，同时刷新UI控件。
- 各个控件显示的数据也是从单例数据模型中读取计算得出，需要在计时器触发时调用刷新。

最后10秒的滴答音效
因为每秒播放一次一个不足1秒的 m4a 文件
用 `AudioServicesCreateSystemSoundID` 播放再合适不过（最开始用AVPlayer和AVAudioPlayer没放出来。。。推测是内存消耗比较大，每秒执行就会出现一些问题）








