### MQTitleView
####一个swift版的导航条titleView切换器
只需初始化一个MQTitleView,设置参数即可,可定制title颜色,字体大小

```
        MytitleView = MQTitleView.init(count: Constant.count, size: size, titleArray: Constant.array, btnSelected: { [unowned self](index) in

        })
```

别忘了将titleView添加到navgationItem上哦,具体参见demo
效果是这样的
![demo.png](http://upload-images.jianshu.io/upload_images/1526313-9d730d27bf3e68ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

