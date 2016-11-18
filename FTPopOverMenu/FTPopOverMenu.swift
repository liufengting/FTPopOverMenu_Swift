//
//  FTPopOverMenu.swift
//  FTPopOverMenuDemo
//
//  Created by liufengting on 16/11/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit

fileprivate let FTDefaultMargin : CGFloat = 4
fileprivate let FTDefaultMenuCornerRadius : CGFloat = 4
fileprivate let FTDefaultMenuArrowWidth : CGFloat = 8





extension FTPopOverMenu {
    
    public static func showForSender(sender : UIView, with menuArray: [String], done: @escaping (NSInteger)->(), cancel:@escaping ()->()) {
        self.sharedMenu.showForSender(sender: sender, or: nil, with: menuArray, menuImageArray: [], done: done, cancel: cancel)
    }
    public static func showForSender(sender : UIView, with menuArray: [String], menuImageArray: [String], done: @escaping (NSInteger)->(), cancel:@escaping ()->()) {
        
    }
    
    public static func showForEvent(event : UIEvent, with menuArray: [String], done: @escaping (NSInteger)->(), cancel:@escaping ()->()) {
        
    }
    public static func showForEvent(event : UIEvent, with menuArray: [String], menuImageArray: [String], done: @escaping (NSInteger)->(), cancel:@escaping ()->()) {
        
    }
    
    public static func showFromSenderFrame(senderFrame : CGRect, with menuArray: [String], done: @escaping (NSInteger)->(), cancel:@escaping ()->()) {
        
    }
    public static func showFromSenderFrame(senderFrame : CGRect, with menuArray: [String], menuImageArray: [String], done: @escaping (NSInteger)->(), cancel:@escaping ()->()) {
        
    }
    
    public static func dismiss() {
        self.sharedMenu.dismiss()
    }
}



public class FTPopOverMenu : NSObject {

    var sender : UIView?
    var senderFrame : CGRect?
    var menuNameArray : [String]!
    var menuImageArray : [String]!
    var done : ((_ selectedIndex : NSInteger)->())!
    var cancel : (()->())!

    enum FTPopOverMenuArrowDirection {
        case Up
        case Down
    }
    
    
    fileprivate static var sharedMenu : FTPopOverMenu {
        struct Static {
            static let instance : FTPopOverMenu = FTPopOverMenu()
        }
        return Static.instance
    }

    
    
    
    fileprivate lazy var backgroundView : UIView  = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.clear
        view.addGestureRecognizer(self.tapGesture)
        return view
    }()
    
    private var isOnScreen : Bool = false {
        didSet {
            if isOnScreen {
                self.addOrientationChangeNotification()
            }else{
                self.removeOrientationChangeNotification()
            }
        }
    }
    
    fileprivate lazy var tapGesture : UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onBackgroudViewTapped(gesture:)))
        gesture.delegate = self;
        return gesture;
    }()

    fileprivate func showForSender(sender: UIView?, or senderFrame: CGRect?, with menuNameArray: [String]!, menuImageArray: [String]?, done: @escaping (NSInteger)->(), cancel:@escaping ()->()){
        
        if sender == nil && senderFrame == nil {
            return
        }
        if menuNameArray.count == 0 {
            return
        }
        
        self.sender = sender
        self.senderFrame = senderFrame
        self.menuNameArray = menuNameArray
        self.menuImageArray = menuImageArray
        self.done = done
        self.cancel = cancel
        
        self.adjustPostionForPopOverMenu()
    }
    
    
    
    
    
    fileprivate func adjustPostionForPopOverMenu() {
        
        self.backgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.ft_width(), height: UIScreen.ft_height())

        
        print(popOverMenuFrame)
    }
    
    
    var senderRect : CGRect {
        var senderRect = CGRect.zero
        if self.sender != nil {
            senderRect = (sender?.superview?.convert((sender?.frame)!, to: backgroundView))!
        }else if senderFrame != nil {
            senderRect = senderFrame!
        }
        senderRect.origin.y = min(UIScreen.ft_height(), senderRect.origin.y)
        return senderRect
    }
    
    var arrowDirection : FTPopOverMenuArrowDirection {
        if senderRect.origin.y + senderRect.size.height/2 < UIScreen.ft_height()/2 {
            return .Up
        }else{
            return .Down
        }
    }
    
    var shouldEnableScroll : Bool {
        
        
        // error
        
        if (arrowDirection == .Up && popOverMenuFrame.origin.y + popOverMenuFrame.size.height > UIScreen.ft_height()) {
            return true
        }
        if (arrowDirection == .Down && popOverMenuFrame.origin.y < 0) {
            return true
        }
        return false
    }
    
    var popMenuHeight : CGFloat {
        return FTConfiguration.shared.menuRowHeight * CGFloat(self.menuNameArray.count) + 10
    }
    
    var popMenuOriginX : CGFloat {
        var senderXCenter : CGPoint = CGPoint(x: senderRect.origin.x + (senderRect.size.width)/2, y: 0)
        let menuCenterX : CGFloat = FTConfiguration.shared.menuWidth/2 + FTDefaultMargin
        var menuX : CGFloat = 0
        if (senderXCenter.x + menuCenterX > UIScreen.ft_width()) {
            senderXCenter.x = min(senderXCenter.x - (UIScreen.ft_width() - FTConfiguration.shared.menuWidth - FTDefaultMargin), FTConfiguration.shared.menuWidth - FTDefaultMenuArrowWidth - FTDefaultMargin);
            menuX = UIScreen.ft_width() - FTConfiguration.shared.menuWidth - FTDefaultMargin;
        }else if (senderXCenter.x - menuCenterX < 0){
            senderXCenter.x = max(FTDefaultMenuCornerRadius + FTDefaultMenuArrowWidth, senderXCenter.x - FTDefaultMargin);
            menuX = FTDefaultMargin;
        }else{
            senderXCenter.x = FTConfiguration.shared.menuWidth/2;
            menuX = senderRect.origin.x + (senderRect.size.width)/2 - FTConfiguration.shared.menuWidth/2;
        }
        return menuX
    }
    

    
    var menuArrowPoint : CGPoint {
        var point : CGPoint = CGPoint(x: senderRect.origin.x + (senderRect.size.width)/2, y: 0)
        let menuCenterX : CGFloat = FTConfiguration.shared.menuWidth/2 + FTDefaultMargin
        if senderRect.origin.y + senderRect.size.height/2 < UIScreen.ft_height()/2 {
            point.y = 0;
        }else{
            point.y = popMenuHeight;
        }
        if (point.x + menuCenterX > UIScreen.ft_width()) {
            point.x = min(point.x - (UIScreen.ft_width() - FTConfiguration.shared.menuWidth - FTDefaultMargin), FTConfiguration.shared.menuWidth - FTDefaultMenuArrowWidth - FTDefaultMargin);
        }else if (point.x - menuCenterX < 0){
            point.x = max(FTDefaultMenuCornerRadius + FTDefaultMenuArrowWidth, point.x - FTDefaultMargin);
        }else{
            point.x = FTConfiguration.shared.menuWidth/2;
        }
        return point
        
    }

    fileprivate var popOverMenuFrame : CGRect {
        var popOverMenuFrame = CGRect.zero
        if (arrowDirection == .Up) {
            popOverMenuFrame = CGRect(x: popMenuOriginX, y: (senderRect.origin.y + senderRect.size.height), width: FTConfiguration.shared.menuWidth, height: popMenuHeight)
            if (popOverMenuFrame.origin.y + popOverMenuFrame.size.height > UIScreen.ft_height()) {
                popOverMenuFrame = CGRect(x: popMenuOriginX, y: (senderRect.origin.y + senderRect.size.height), width: FTConfiguration.shared.menuWidth, height: UIScreen.ft_height() - popOverMenuFrame.origin.y - FTDefaultMargin);
            }
        }else{
            popOverMenuFrame = CGRect(x: popMenuOriginX, y: (senderRect.origin.y - popMenuHeight), width: FTConfiguration.shared.menuWidth, height: popMenuHeight)
            if (popOverMenuFrame.origin.y  < 0) {
                popOverMenuFrame = CGRect(x: popMenuOriginX, y: FTDefaultMargin, width: FTConfiguration.shared.menuWidth, height: senderRect.origin.y - FTDefaultMargin);
            }
        }
        return popOverMenuFrame
    }
    


    
    
    
    

    @objc fileprivate func onBackgroudViewTapped(gesture : UIGestureRecognizer) {

    }
    
    fileprivate func show(){

    }
    
    
    fileprivate func dismiss() {

    }
    
    fileprivate func doneActionWithSelectedIndex(selectedIndex: NSInteger) {

    }

}


extension FTPopOverMenu {
    
    fileprivate func addOrientationChangeNotification() {
        NotificationCenter.default.addObserver(self,selector: #selector(onChangeStatusBarOrientationNotification(notification:)),
                                               name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation,
                                               object: nil)
        
    }
    
    fileprivate func removeOrientationChangeNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func onChangeStatusBarOrientationNotification(notification : Notification) {
        
    }
    
}

extension FTPopOverMenu: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }

}


public class FTConfiguration : NSObject {

    var menuRowHeight : CGFloat = 40
    var menuWidth : CGFloat = 120
    var textColor : UIColor = UIColor.black
    var textFont : UIFont = UIFont.systemFont(ofSize: 14)
    var borderColor : UIColor = UIColor.gray
    var borderWidth : CGFloat = 0.5
    var backgoundColor : UIColor = UIColor.white
    var textAlignment : NSTextAlignment = NSTextAlignment.left
    var ignoreImageOriginalColor : Bool = false

    public static var shared : FTConfiguration {
        struct StaticConfig {
            static let instance : FTConfiguration = FTConfiguration()
        }
        return StaticConfig.instance
    }
}


class FTPopOverMenuView: UIControl {
    
    lazy var menuTableView : UITableView = {
       let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension FTPopOverMenuView : UITableViewDelegate {
    
    
    
    
}

extension FTPopOverMenuView : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
        return cell
    }

}

extension UIScreen {
    
    public static func ft_width() -> CGFloat {
        return self.main.bounds.size.width
    }
    public static func ft_height() -> CGFloat {
        return self.main.bounds.size.height
    }
    
}
