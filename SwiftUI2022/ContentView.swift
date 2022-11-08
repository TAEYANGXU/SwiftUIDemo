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
//        File Name:       ContentView.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/7/5 3:31 PM
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject private var tabBarIndex: TabBarIndexObserver
    
    private var selectedTab: Binding<Int> {
        Binding (
            get:{
                tabBarIndex.tabSelected.rawValue
            },
            set:{
                tabBarIndex.tabSelected = TabBarItem(rawValue: $0)!
            }
        )
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: selectedTab) {
                SwiftUI20220706().environmentObject(LandmarkViewModel()).tabItem{tabItem(for: .Home)}.tag(TabBarItem.Home.rawValue)
                DemoView().tabItem{tabItem(for: .Demo)}.tag(TabBarItem.Demo.rawValue)
                WeatherListView().tabItem{tabItem(for: .Living)}.tag(TabBarItem.Living.rawValue)
                PassthroughSubjectView().tabItem{tabItem(for: .Message)}.tag(TabBarItem.Message.rawValue)
                ContentView1().tabItem{tabItem(for: .Mine)}.tag(TabBarItem.Mine.rawValue)
            }.font(.headline).accentColor(.red)
        }
    }
    
    
    private func tabItem(for tab:TabBarItem) -> some View {
        print(selectedTab.wrappedValue)
        return VStack {
            tab.rawValue == selectedTab.wrappedValue ? tab.selectImage : tab.normalImage
            Text(tab.title).foregroundColor(tab.rawValue == selectedTab.wrappedValue ? .init(hex: "#5981E5") : .init(hex: "#62666C") )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

