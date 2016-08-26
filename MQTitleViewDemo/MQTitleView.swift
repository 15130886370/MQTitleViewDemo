//
//  favoriteVCtitleVIew.swift
//  Swift_ttmamaApp
//
//  Created by ittmomWang on 16/2/29.
//  Copyright © 2016年 Dennis Wang. All rights reserved.
//

import UIKit

class MQTitleView: UIView {
    
        //MARK: Properties
    
    //按钮普通状态下title的颜色
    var normalColor: UIColor?
    var selectedColor: UIColor?//按钮选中时候title的颜色,同时作为底部线条的颜色
    var fontSize: CGFloat?//button字体大小
    
    let duration = 0.3 //动画时长
    var line = UIView() //底部的线条
    var button : UIButton? //标题按钮
    var buttons = [UIButton]() //存放按钮的数组
    var buttonClickedBolck : ((index : Int)->())? //按钮的点击回调
    
    var Width: CGFloat! //titleView的宽度
    var Height: CGFloat! //titleView的高度
    
    
        //MARK: Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /**
     titleView的便利构造方法
     
     - parameter count:       titleView切换器的button个数
     - parameter frame:       titleView的frame,x = 0,y = 0,width自定义,height一般为44
     - parameter titleArray:  存放按钮title的string数组
     - parameter btnSelected: 处理按钮点击事件的尾随闭包,indexTag传人按钮的tag值,以区分按钮
     
     */
    convenience init(count: Int,size: CGSize,titleArray: [AnyObject],btnSelected: ((index : Int)->())) {
        self.init(frame: (CGRectMake(0, 0, size.width, size.height)))
        //按钮的点击回调
        buttonClickedBolck = btnSelected
        Width = size.width / CGFloat(count)
        Height = size.height
        
        for index in 0...count-1 {
            button = UIButton(type: .Custom)
            button!.frame = CGRectMake(CGFloat(index) * Width, 0, Width, Height)
            button!.tag = index + 100
            button!.setTitle(titleArray[index] as? String, forState: .Normal)
            button?.titleLabel?.font = UIFont.systemFontOfSize(17)
            if index == 0 {
                button!.selected = true
            }
            
            button!.addTarget(self, action: #selector(MQTitleView.buttonClicked(_:)), forControlEvents: .TouchUpInside)
            buttons.append(button!)
            self.addSubview(button!)
        }
        //导航栏下面的线
        line.frame = CGRectMake(0, Height - 3, Width, 3)
        
        self.addSubview(line)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitleButton()
    }
    
    private func setTitleButton()
    {
        let defaultNormalColor = UIColor.blackColor()
        let defaultSelectedColor = UIColor.orangeColor()
        for subButton in buttons
        {
            if let normal = normalColor{
                subButton.setTitleColor(normal, forState: .Normal)
            }else{
                subButton.setTitleColor(defaultNormalColor, forState: .Normal)
            }
            if let selected = selectedColor{
                subButton.setTitleColor(selected, forState: .Selected)
                line.backgroundColor = selected
            }else{
                subButton.setTitleColor(defaultSelectedColor, forState: .Selected)
                line.backgroundColor = defaultSelectedColor
            }
            if let font = fontSize{
                subButton.titleLabel?.font = UIFont.systemFontOfSize(font)
            }
        }
    }
    
    /**
     按钮的点击事件,已处理按钮的选中状态,以及底部线条的offset,其它
     切换控制器控制scrollView的操作在
     */
    func buttonClicked(sender: UIButton){
        if sender.selected {
            return
        }
        let tag = sender.tag
        UIView .animateWithDuration(duration) { () -> Void in
            self.line.frame = CGRectMake(CGFloat(self.Width * CGFloat(tag-100)), 41, self.Width, 3)
            if self.buttonClickedBolck != nil {
                self.buttonClickedBolck!(index: tag - 100)
            }
            for btn in (self.subviews) {
                    if btn.tag > 0 {
                        let newBtn = btn as! UIButton
                        newBtn.selected = false
                    }
            }
        }
        sender.selected = true

    }
    /**
     外界scrollView控制titleView,如果需要实现scrollView滚动拖动
     titleView滚动的话,需在外界调用这个方法
     */
    func scrollTitle(index: Int)
    {
        UIView.animateWithDuration(duration) { () -> Void in
            self.line.frame = CGRectMake(self.Width * CGFloat(index), 41, self.Width, 3)
            for btn in (self.subviews) {
                if btn.tag > 0 {
                    let newBtn = btn as! UIButton
                    newBtn.selected = false
                }
            }
        }
        buttons[index].selected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
