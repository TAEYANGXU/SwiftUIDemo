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
//        File Name:       SettingView.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/11/8 14:00
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255).edgesIgnoringSafeArea(.all)
                Form{
                    Section{
                        userInfoView
                    }
                    Section {
                        ListItemView(itemImage: "lock", itemName: "账号绑定", itemContent: "已绑定")
                        ListItemView(itemImage: "gear.circle", itemName: "通用设置", itemContent: "")
                        ListItemView(itemImage: "briefcase", itemName: "简历管理", itemContent: "未上传")
                        ListItemView(itemImage: "icloud.and.arrow.down", itemName: "版本更新", itemContent: "Version 6.2.8")
                        ListItemView(itemImage: "leaf", itemName: "清理缓存", itemContent: "0.00MB")
                        ListItemView(itemImage: "person", itemName: "关于掘金", itemContent: "")
                    }
                    Section{
                        logoutView
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline).navigationTitle("设置")
            .navigationBarItems(leading: backToMineView)
            
        }.navigationBarBackButtonHidden(true)
        
        
    }
    
    private var backToMineView: some View{
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
        }

    }
    
    private var userInfoView: some View {
        Button {
            
        } label: {
            HStack (spacing: 15){
                Image("stmarylake").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.systemGray5),lineWidth: 1))
                VStack(alignment: .leading, spacing: 5) {
                    Text("张三李四").font(.system(size: 17)).foregroundColor(.black)
                    Text("iOS开发工程师").font(.system(size: 17)).foregroundColor(.black)
                }
            }.padding(.vertical, 10)
        }
    }
    
    private var logoutView: some View
    {
        Button {
            print("退出")
        } label: {
            Text("退出登录").font(.system(size: 17))
                .frame(minWidth: 0,maxWidth: .infinity,minHeight: 30,maxHeight: 30)
                .foregroundColor(.red)
                .cornerRadius(8)
                .padding(.vertical,5)
        }
    }
}

struct ListItemView: View{
    
    var itemImage: String
    var itemName: String
    var itemContent: String
    
    var body: some View{
        Button {
            print("events")
        } label: {
            HStack{
                Image(systemName: itemImage).font(.system(size: 17))
                    .foregroundColor(.black)
                Text(itemName).foregroundColor(.black)
                    .font(.system(size: 17))
                Spacer()
                Text(itemContent)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }.padding(.vertical,15)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
