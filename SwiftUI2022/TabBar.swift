//
//                         __   _,--="=--,_   __
//                        /  \."    .-.    "./  \
//                       /  ,/  _   : :   _  \/` \
//                       \  `| /o\  :_:  /o\ |\__/
//                        `-'| :="~` _ `~"=: |
//                           \`     (_)     `/
//                    .-"-.   \      |      /   .-"-.
//.------------------{     }--|  /,.-'-.,\  |--{     }-----------------.
// )                 (_)_)_)  \_/`~-===-~`\_/  (_(_(_)                (
//
//        File Name:       TabBar.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/7/7 10:06 AM
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import SwiftUI
import Combine

final class TabBarIndexObserver: ObservableObject
{
    @Published var tabSelected: TabBarItem = .Home
}


enum TabBarItem: Int {
    case Home
    case Demo
    case Living
    case Message
    case Mine
    
    var title: String {
        switch self {
        case .Home:
            return "首页"
        case .Demo:
            return "例子"
        case .Living:
            return "直播"
        case .Message:
            return "消息"
        case .Mine:
            return "我的"
        }
    }
    
    var normalImage: Image {
        switch self {
        case .Home:
            return Image("tab_home_normal_icon")
        case .Demo:
            return Image("tab_hs_vp_normal")
        case .Living:
            return Image("tab_market_normal_icon")
        case .Message:
            return Image("tab_hy_normal_icon")
        case .Mine:
            return Image("tab_mine_normal_icon")
        }
    }
    
    var selectImage: Image {
        switch self {
        case .Home:
            return Image("tab_home_select_icon")
        case .Demo:
            return Image("tab_hs_vp_select")
        case .Living:
            return Image("tab_market_select_icon")
        case .Message:
            return Image("tab_hy_select_icon")
        case .Mine:
            return Image("tab_mine_select_icon")
        }
    }
}


extension Color
{
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
//
//
//extension UIApplication {
//    var key: UIWindow? {
//        self.connectedScenes
//            .map({$0 as? UIWindowScene})
//            .compactMap({$0})
//            .first?
//            .windows
//            .filter({$0.isKeyWindow})
//            .first
//    }
//}
//
//
//extension UIView {
//    func allSubviews() -> [UIView] {
//        var subs = self.subviews
//        for subview in self.subviews {
//            let rec = subview.allSubviews()
//            subs.append(contentsOf: rec)
//        }
//        return subs
//    }
//}
//    
//
//struct TabBarModifier {
//    static func showTabBar() {
//        UIApplication.shared.key?.allSubviews().forEach({ subView in
//            if let view = subView as? UITabBar {
//                view.isHidden = false
//            }
//        })
//    }
//    
//    static func hideTabBar() {
//        UIApplication.shared.key?.allSubviews().forEach({ subView in
//            if let view = subView as? UITabBar {
//                view.isHidden = true
//            }
//        })
//    }
//}
//
//struct ShowTabBar: ViewModifier {
//    func body(content: Content) -> some View {
//        return content.padding(.zero).onAppear {
//            TabBarModifier.showTabBar()
//        }
//    }
//}
//struct HiddenTabBar: ViewModifier {
//    func body(content: Content) -> some View {
//        return content.padding(.zero).onAppear {
//            TabBarModifier.hideTabBar()
//        }
//    }
//}
//
//extension View {
//    
//    func showTabBar() -> some View {
//        return self.modifier(ShowTabBar())
//    }
//
//    func hiddenTabBar() -> some View {
//        return self.modifier(HiddenTabBar())
//    }
//}
