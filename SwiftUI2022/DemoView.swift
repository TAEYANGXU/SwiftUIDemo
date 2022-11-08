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
//        File Name:       DemoView.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/7/7 10:37 AM
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import SwiftUI
import Combine

struct MyLink: Identifiable
{
    var id = UUID()
    let linkName: String
    let linkView: AnyView
}

struct DemoView: View {
    
//    @Binding var isTabBarShow: Bool
    
    var linkList: [MyLink] {
        [
            MyLink(linkName: "搜索", linkView: AnyView(DemoSearchView())),
            MyLink(linkName: "轮播图", linkView: AnyView(ContentView1())),
            MyLink(linkName: "绘制", linkView: AnyView(SwiftUI20220707())),
            MyLink(linkName: "布局", linkView: AnyView(SwiftUI20220708().environmentObject(LandmarkViewModel()))),
            MyLink(linkName: "设置", linkView: AnyView(SettingView())),
        ]
    }
    
    var body: some View {
        List{
            ForEach(linkList.indices,id: \.self) { index in
                NavigationLink() {
                    linkList[index].linkView.navigationTitle( index == 4 ?  "" : linkList[index].linkName).navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text(linkList[index].linkName).font(.title3)
                }
            }
        }.navigationTitle("Demo").navigationBarTitleDisplayMode(.automatic).onAppear{
            //去掉下划线
            UITableView.appearance().separatorStyle = .none
            //恢复分割线
            UITableView.appearance().separatorColor = .systemGray4
        }
    }
}

class SearchTextViewModel: ObservableObject
{
    @Published var searchText: String = ""
    @Published var listText: [String] = ["Banana", "Apple", "Cherry", "Watermelon"]

    var allText: [String] = []
    var cancellable: AnyCancellable?
    
    init() {
        allText = listText
        cancellable = $searchText.debounce(for: 0.2, scheduler: RunLoop.main)
            .sink { completion in
                print("completion",completion)
            } receiveValue: { str in
                print("str",str)
                if str.count > 0 {
                    self.listText = self.allText.filter{
                        $0.lowercased().contains(str.lowercased())
                    }
                }else{
                    self.listText = self.allText
                }
            }
    }
}

struct DemoSearchView: View {
    
    @StateObject var viewModel = SearchTextViewModel()
    var body: some View {
        VStack{
            Spacer()
            TextField("搜索", text: $viewModel.searchText)
                .frame(height:40)
                .background(Color(hex: "999999"))
                .cornerRadius(4)
                .foregroundColor(.black)
                .padding(.top,10)
            List(viewModel.listText,id: \.self){ text in
                Text(text)
            }
        }
    }
}

//struct DemoView_Previews: PreviewProvider {
//    static var previews: some View {
//        DemoView()
//    }
//}
