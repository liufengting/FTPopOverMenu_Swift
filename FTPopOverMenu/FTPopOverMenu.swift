//
//  FTPopOverMenu.swift
//  FTPopOverMenuDemo
//
//  Created by liufengting on 16/11/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit

fileprivate let FTDefaultMargin : CGFloat = 4
fileprivate let FTDefaultCellMargin : CGFloat = 6
fileprivate let FTDefaultMenuIconSize : CGFloat = 24
fileprivate let FTDefaultMenuCornerRadius : CGFloat = 4
fileprivate let FTDefaultMenuArrowWidth : CGFloat = 8
fileprivate let FTDefaultMenuArrowHeight : CGFloat = 10
fileprivate let FTDefaultAnimationDuration : TimeInterval = 0.3


fileprivate let FTPopOverMenuTableViewCellIndentifier : String = "FTPopOverMenuTableViewCellIndentifier"


public enum FTPopOverMenuArrowDirection {
    case Up
    case Down
}


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

    fileprivate static var sharedMenu : FTPopOverMenu {
        struct Static {
            static let instance : FTPopOverMenu = FTPopOverMenu()
        }
        return Static.instance
    }

    fileprivate lazy var configuration : FTConfiguration = {
        return FTConfiguration.shared
    }()
    
    
    fileprivate lazy var backgroundView : UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.clear
        view.addGestureRecognizer(self.tapGesture)
        return view
    }()
    
    fileprivate lazy var popOverMenu : FTPopOverMenuView = {
        let menu = FTPopOverMenuView(frame: CGRect.zero)
        menu.alpha = 0
        self.backgroundView.addSubview(menu)
        return menu
    }()
    
    fileprivate var isOnScreen : Bool = false {
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
        
        UIApplication.shared.keyWindow?.addSubview(self.backgroundView)
        
        self.adjustPostionForPopOverMenu()
    }

    fileprivate func adjustPostionForPopOverMenu() {
        self.backgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.ft_width(), height: UIScreen.ft_height())

        popOverMenu.showWithAnglePoint(point: menuArrowPoint, frame: popOverMenuFrame, menuNameArray: menuNameArray, menuImageArray: menuImageArray, arrowDirection: arrowDirection, done: done)
        
        self.showIfNeeded()
    }

    
    fileprivate var senderRect : CGRect {
        var senderRect = CGRect.zero
        if self.sender != nil {
            senderRect = (sender?.superview?.convert((sender?.frame)!, to: backgroundView))!
        }else if senderFrame != nil {
            senderRect = senderFrame!
        }
        senderRect.origin.y = min(UIScreen.ft_height(), senderRect.origin.y)
        return senderRect
    }
    
    fileprivate var arrowDirection : FTPopOverMenuArrowDirection {
        if senderRect.origin.y + senderRect.size.height/2 < UIScreen.ft_height()/2 {
            return .Up
        }else{
            return .Down
        }
    }

    fileprivate var popMenuHeight : CGFloat {
        return configuration.menuRowHeight * CGFloat(self.menuNameArray.count) + 10
    }
    
    fileprivate var popMenuOriginX : CGFloat {
        var senderXCenter : CGPoint = CGPoint(x: senderRect.origin.x + (senderRect.size.width)/2, y: 0)
        let menuCenterX : CGFloat = configuration.menuWidth/2 + FTDefaultMargin
        var menuX : CGFloat = 0
        if (senderXCenter.x + menuCenterX > UIScreen.ft_width()) {
            senderXCenter.x = min(senderXCenter.x - (UIScreen.ft_width() - configuration.menuWidth - FTDefaultMargin), configuration.menuWidth - FTDefaultMenuArrowWidth - FTDefaultMargin);
            menuX = UIScreen.ft_width() - configuration.menuWidth - FTDefaultMargin;
        }else if (senderXCenter.x - menuCenterX < 0){
            senderXCenter.x = max(FTDefaultMenuCornerRadius + FTDefaultMenuArrowWidth, senderXCenter.x - FTDefaultMargin);
            menuX = FTDefaultMargin;
        }else{
            senderXCenter.x = configuration.menuWidth/2;
            menuX = senderRect.origin.x + (senderRect.size.width)/2 - configuration.menuWidth/2;
        }
        return menuX
    }

    fileprivate var menuArrowPoint : CGPoint {
        var point : CGPoint = CGPoint(x: senderRect.origin.x + (senderRect.size.width)/2, y: 0)
        let menuCenterX : CGFloat = configuration.menuWidth/2 + FTDefaultMargin
        if senderRect.origin.y + senderRect.size.height/2 < UIScreen.ft_height()/2 {
            point.y = 0;
        }else{
            point.y = popMenuHeight;
        }
        if (point.x + menuCenterX > UIScreen.ft_width()) {
            point.x = min(point.x - (UIScreen.ft_width() - configuration.menuWidth - FTDefaultMargin), configuration.menuWidth - FTDefaultMenuArrowWidth - FTDefaultMargin);
        }else if (point.x - menuCenterX < 0){
            point.x = max(FTDefaultMenuCornerRadius + FTDefaultMenuArrowWidth, point.x - FTDefaultMargin);
        }else{
            point.x = configuration.menuWidth/2;
        }
        return point
    }

    fileprivate var popOverMenuFrame : CGRect {
        var popOverMenuFrame = CGRect.zero
        if (arrowDirection == .Up) {
            popOverMenuFrame = CGRect(x: popMenuOriginX, y: (senderRect.origin.y + senderRect.size.height), width: configuration.menuWidth, height: popMenuHeight)
            if (popOverMenuFrame.origin.y + popOverMenuFrame.size.height > UIScreen.ft_height()) {
                popOverMenuFrame = CGRect(x: popMenuOriginX, y: (senderRect.origin.y + senderRect.size.height), width: configuration.menuWidth, height: UIScreen.ft_height() - popOverMenuFrame.origin.y - FTDefaultMargin);
            }
        }else{
            popOverMenuFrame = CGRect(x: popMenuOriginX, y: (senderRect.origin.y - popMenuHeight), width: configuration.menuWidth, height: popMenuHeight)
            if (popOverMenuFrame.origin.y  < 0) {
                popOverMenuFrame = CGRect(x: popMenuOriginX, y: FTDefaultMargin, width: configuration.menuWidth, height: senderRect.origin.y - FTDefaultMargin);
            }
        }
        return popOverMenuFrame
    }

    @objc fileprivate func onBackgroudViewTapped(gesture : UIGestureRecognizer) {
        self.dismiss()
    }
    
    fileprivate func showIfNeeded() {
        if self.isOnScreen == false {
            self.isOnScreen = true
            UIView.animate(withDuration: FTDefaultAnimationDuration, animations: {
                self.popOverMenu.alpha = 1
            })
        }
    }
    
    
    fileprivate func dismiss() {
        self.isOnScreen = false
        self.doneActionWithSelectedIndex(selectedIndex: -1)
    }
    
    fileprivate func doneActionWithSelectedIndex(selectedIndex: NSInteger) {
        UIView.animate(withDuration: FTDefaultAnimationDuration,
                       animations: {
                        self.popOverMenu.alpha = 0
        }) { (isFinished) in
            if isFinished {
                self.backgroundView.removeFromSuperview()
                if selectedIndex < 0 {
                    if (self.cancel != nil) {
                        self.cancel()
                    }
                }else{
                    if (self.done != nil) {
                        self.done(selectedIndex)
                    }
                }
                
            }
        }
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.adjustPostionForPopOverMenu()
        })
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
    var textColor : UIColor = UIColor.white
    var textFont : UIFont = UIFont.systemFont(ofSize: 14)
    var tintColor : UIColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
    var borderColor : UIColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
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
    
    fileprivate var menuNameArray : [String]!
    fileprivate var menuImageArray : [String]?
    fileprivate var arrowDirection : FTPopOverMenuArrowDirection = .Up
    fileprivate var done : ((NSInteger)->())!
    
    fileprivate lazy var configuration : FTConfiguration = {
        return FTConfiguration.shared
    }()
    
    lazy var menuTableView : UITableView = {
       let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate func showWithAnglePoint(point: CGPoint, frame: CGRect, menuNameArray: [String]!, menuImageArray: [String]!, arrowDirection: FTPopOverMenuArrowDirection, done: @escaping ((NSInteger)->())) {
        
        self.frame = frame
        
        
        // Fix this
        self.backgroundColor = configuration.tintColor
        
        
        self.menuNameArray = menuNameArray
        self.menuImageArray = menuImageArray
        self.arrowDirection = arrowDirection
        self.done = done
        
        self.repositionMenuTableView()
        
        self.drawBackgroundLayerWithAnglePoint(anglePoint: point)
    }
    
    fileprivate func repositionMenuTableView() {
        var menuRect : CGRect = CGRect(x: 0, y: FTDefaultMenuArrowHeight, width: self.frame.size.width, height: self.frame.size.height - FTDefaultMenuArrowHeight)
        if (arrowDirection == .Down) {
            menuRect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height - FTDefaultMenuArrowHeight)
        }
        self.menuTableView.frame = menuRect
        self.menuTableView.reloadData()
        if menuTableView.frame.height < configuration.menuRowHeight * CGFloat(menuNameArray.count) {
            self.menuTableView.isScrollEnabled = true
        }else{
            self.menuTableView.isScrollEnabled = false
        }
        self.addSubview(self.menuTableView)
    }

    fileprivate func drawBackgroundLayerWithAnglePoint(anglePoint : CGPoint) {
        
        
        
    }

}

extension FTPopOverMenuView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return configuration.menuRowHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension FTPopOverMenuView : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FTPopOverMenuCell = FTPopOverMenuCell(style: .default, reuseIdentifier: FTPopOverMenuTableViewCellIndentifier)
        var imageName = ""
        if menuImageArray != nil {
            if (menuImageArray?.count)! >= indexPath.row + 1 {
                imageName = (menuImageArray?[indexPath.row])!
            }
        }
        cell.setupCellWith(menuName: menuNameArray[indexPath.row], menuImage: imageName)
        if (indexPath.row == menuNameArray.count-1) {
            cell.separatorInset = UIEdgeInsetsMake(0, self.bounds.size.width, 0, 0);
        }else{
            cell.separatorInset = UIEdgeInsetsMake(0, FTDefaultCellMargin, 0, FTDefaultCellMargin);
        }
        return cell
    }

}

class FTPopOverMenuCell: UITableViewCell {
    
    fileprivate lazy var configuration : FTConfiguration = {
        return FTConfiguration.shared
    }()

    fileprivate lazy var iconImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.tintColor = FTConfiguration.shared.textColor
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    fileprivate lazy var nameLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = UIColor.clear
        label.font = FTConfiguration.shared.textFont
        label.textColor = FTConfiguration.shared.textColor
        label.textAlignment = FTConfiguration.shared.textAlignment
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate func setupCellWith(menuName: String, menuImage: String?) {
        self.backgroundColor = UIColor.clear
        if menuImage != nil {
            if var iconImage : UIImage = UIImage(named: menuImage!) {
                if  configuration.ignoreImageOriginalColor {
                    iconImage = iconImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                }
                iconImageView.frame =  CGRect(x: FTDefaultCellMargin, y: (configuration.menuRowHeight - FTDefaultMenuIconSize)/2, width: FTDefaultMenuIconSize, height: FTDefaultMenuIconSize);
                iconImageView.image = iconImage;
                nameLabel.frame = CGRect(x: FTDefaultCellMargin*2 + FTDefaultMenuIconSize, y: 0, width: (configuration.menuRowHeight - FTDefaultMenuIconSize - FTDefaultCellMargin*3), height: configuration.menuRowHeight)
            }else{
                nameLabel.frame = CGRect(x: FTDefaultCellMargin, y: 0, width: configuration.menuWidth - FTDefaultCellMargin*2, height: configuration.menuRowHeight)
            }
        }
        nameLabel.text = menuName
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
