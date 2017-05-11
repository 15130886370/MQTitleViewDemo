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
    var buttonClickedBolck : ((_ index : Int)->())? //按钮的点击回调
    
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
    convenience init(count: Int,size: CGSize,titleArray: [AnyObject],btnSelected: @escaping ((_ index : Int)->())) {
        self.init(frame: (CGRect(x: 0, y: 0, width: size.width, height: size.height)))
        //按钮的点击回调
        buttonClickedBolck = btnSelected
        Width = size.width / CGFloat(count)
        Height = size.height
        
        for index in 0...count-1 {
            button = UIButton(type: .custom)
            button!.frame = CGRect(x: CGFloat(index) * Width, y: 0, width: Width, height: Height)
            button!.tag = index + 100
            button!.setTitle(titleArray[index] as? String, for: UIControlState())
            button?.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            if index == 0 {
                button!.isSelected = true
            }
            
            button!.addTarget(self, action: #selector(MQTitleView.buttonClicked(_:)), for: .touchUpInside)
            buttons.append(button!)
            self.addSubview(button!)
        }
        //导航栏下面的线
        line.frame = CGRect(x: 0, y: Height - 3, width: Width, height: 3)
        
        self.addSubview(line)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitleButton()
    }
    
    fileprivate func setTitleButton()
    {
        let defaultNormalColor = UIColor.black
        let defaultSelectedColor = UIColor.orange
        for subButton in buttons
        {
            if let normal = normalColor{
                subButton.setTitleColor(normal, for: UIControlState())
            }else{
                subButton.setTitleColor(defaultNormalColor, for: UIControlState())
            }
            if let selected = selectedColor{
                subButton.setTitleColor(selected, for: .selected)
                line.backgroundColor = selected
            }else{
                subButton.setTitleColor(defaultSelectedColor, for: .selected)
                line.backgroundColor = defaultSelectedColor
            }
            if let font = fontSize{
                subButton.titleLabel?.font = UIFont.systemFont(ofSize: font)
            }
        }
    }
    
    /**
     按钮的点击事件,已处理按钮的选中状态,以及底部线条的offset,其它
     切换控制器控制scrollView的操作在
     */
    func buttonClicked(_ sender: UIButton){
        if sender.isSelected {
            return
        }
        let tag = sender.tag
        UIView .animate(withDuration: duration, animations: { () -> Void in
            self.line.frame = CGRect(x: CGFloat(self.Width * CGFloat(tag-100)), y: 41, width: self.Width, height: 3)
            if self.buttonClickedBolck != nil {
                self.buttonClickedBolck!(tag - 100)
            }
            for btn in (self.subviews) {
                    if btn.tag > 0 {
                        let newBtn = btn as! UIButton
                        newBtn.isSelected = false
                    }
            }
        }) 
        sender.isSelected = true

    }
    /**
     外界scrollView控制titleView,如果需要实现scrollView滚动拖动
     titleView滚动的话,需在外界调用这个方法
     */
    func scrollTitle(_ index: Int)
    {
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.line.frame = CGRect(x: self.Width * CGFloat(index), y: 41, width: self.Width, height: 3)
            for btn in (self.subviews) {
                if btn.tag > 0 {
                    let newBtn = btn as! UIButton
                    newBtn.isSelected = false
                }
            }
        }) 
        buttons[index].isSelected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
