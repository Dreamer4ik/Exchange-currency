//
//  CustomTabBarController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 19.09.2021.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private lazy var viewUnderTabBar: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
        view.layer.shadowRadius = 32.0
        view.layer.shadowOpacity = 1.0
        view.layer.cornerRadius = 8.0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(viewUnderTabBar)
        view.bringSubviewToFront(tabBar)
        configureTabBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewUnderTabBar.frame = tabBar.frame
        switch traitCollection.horizontalSizeClass {
        case .compact:
            let verticalOffset: CGFloat = traitCollection.verticalSizeClass == .compact ? -12 : -6
            tabBar.items!.forEach { (item) in
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalOffset)
            }
        default:
            tabBar.items!.forEach { (item) in
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
            }
        }
    }

    
    func hideTabBar() {
        self.tabBar.isHidden = true
                self.viewUnderTabBar.isHidden = true
    }
    
    func showTabBar() {
        self.tabBar.isHidden = false
                self.viewUnderTabBar.isHidden = false
    }

    private func configureTabBar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .red
//        tabBar.tintColor = UIColor(red: 1, green: 0, blue: 0.62, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.212, green: 0.212, blue: 0.212, alpha: 1)
        
        tabBar.layer.cornerRadius = 8
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true
        
        
        configureTabBarItems()
    }
    
    private func configureTabBarItems() {
        if let items = tabBar.items {
            items[0].title = "Currency"
            items[1].title = "Convert"
            items[2].title = "Profile"
            items.forEach { (item) in
                item.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], for: .normal)
                item.imageInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
            }
        }
    }
    
    
    
}

//
extension CustomTabBarController  {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let title = item.title {
            switch title {
            case "Currency":
                tabBar.barTintColor = .white
            case "Convert":
                tabBar.barTintColor = .white
            default:
                tabBar.barTintColor = .white
            }
        }
    }
    
    
    
    
}
