//
//  ViewController.swift
//  MQTitleViewDemo
//
//  Created by ittmomWang on 16/8/25.
//  Copyright © 2016年 ittmomWang. All rights reserved.
//

import UIKit

public let SCREENW = UIScreen.main.bounds.width
public let SCREENH = UIScreen.main.bounds.height

class ViewController: UIViewController
{

    var MytitleView: MQTitleView!
    
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    struct Constant {
        static let identifier = "TestTableViewController"
        static let count = 3
        static let array = ["北京","天津","河北"]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleView()
        setChildController()
        contentScrollView.contentSize = CGSize(width: SCREENW * CGFloat(Constant.count), height: 0)
        scrollViewDidEndScrollingAnimation(contentScrollView)
        navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //设置标题按钮
    func setTitleView()
    {
        let size = CGSize(width: 180, height: 44)

        //初始化titleView,并在closure里执行按钮的点击事件
        MytitleView = MQTitleView.init(count: Constant.count, size: size, titleArray: Constant.array as [AnyObject], btnSelected: { [unowned self](index) in
            debugPrint(index)
            var offset = self.contentScrollView.contentOffset
            let offsetX = SCREENW * CGFloat(index)
            offset.x = offsetX
            self.contentScrollView.setContentOffset(offset, animated: true)
        })
        MytitleView.normalColor = UIColor.black
        MytitleView.selectedColor = UIColor.green
        MytitleView.fontSize = 17
        navigationItem.titleView = MytitleView
    }
    
    func setChildController()
    {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: Constant.identifier) as! TestTableViewController
        vc1.data = Constant.array[0]
        addChildViewController(vc1)
        
        let vc2 = sb.instantiateViewController(withIdentifier: Constant.identifier) as! TestTableViewController
        vc2.data = Constant.array[1]
        addChildViewController(vc2)
        
        let vc3 = sb.instantiateViewController(withIdentifier: Constant.identifier) as! TestTableViewController
        vc3.data = Constant.array[2]
        addChildViewController(vc3)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIScrollViewDelegate
{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = Int(offsetX / SCREENW)
        //设置titleView滚动
        MytitleView.scrollTitle(index)
        //即将加载的vc
        let willShowVC = childViewControllers[index]
        if willShowVC.isViewLoaded{return}
        willShowVC.view.frame = CGRect(x: offsetX, y: 0, width: scrollView.bounds.size.width, height: scrollView.bounds.size.height)
        scrollView.addSubview(willShowVC.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }

}

