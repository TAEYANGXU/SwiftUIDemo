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
//        File Name:       SwiftUIView0705.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/7/5 3:39 PM
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import SwiftUI
import Combine

struct PassthroughSubjectView: View
{
    @StateObject var vm = ViewModel()
    @State var isSheet: Bool  = false
    @State var newFruit: String = ""
    
    var body: some View {
        VStack {
            List(vm.listText,id:\.self) { t in
                Text(t)
            }
        }.navigationTitle("Combine 水果").navigationBarItems(trailing: Button(action: {
            self.isSheet.toggle()
            print("isSheet",self.isSheet)
        }, label: {
            Image(systemName: "plus.circle")
        })).sheet(isPresented: $isSheet, content: {
            SheetView()
        })
    }
    
}


extension PassthroughSubjectView
{
    class ViewModel: ObservableObject
    {
        var addFruit = PassthroughSubject<String, Never>()
        @Published var searchText: String = ""
        @Published var listText: [String] = [
            "Banana", "Apple", "Cherry", "Watermelon"
        ]
        var cancelable:AnyCancellable?
        init() {
            cancelable = addFruit.sink(receiveValue: { fruit in
                self.listText.append(fruit)
            })
        }
    }
}

extension PassthroughSubjectView
{
    func SheetView() -> some View
    {
        VStack{
            TextField("Add fruit...", text: $newFruit).padding().background(Color.gray.opacity(0.2)).padding()
            Button(action: {
                vm.addFruit.send(newFruit)
                vm.searchText = newFruit
                isSheet.toggle()
            }, label: {
                Text("Add")
            })
        }
    }
}


struct ContentView1: View {
    var body: some View {
        VStack() {
            Text("Hello, world1!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.yellow)
//            Spacer(minLength: 10)
            Text("这是小标题").font(.subheadline).foregroundColor(.green)
            HStack(alignment: .top){
                Text("Hello, world1!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
//                Spacer()
                Text("这是小标题").font(.subheadline).foregroundColor(.green)
            }
            VStack(alignment:.trailing) {
                Image("new_home_group_icon").clipShape(Circle()).overlay{
                    Circle().stroke(.gray,lineWidth: 4)
                }
                Image("image1").resizable().scaledToFit().frame(width: 80, height: 80, alignment: .center).shadow(color: .gray, radius: 4, x: 1, y: 1)
//                HStack(alignment:.center) {
//                    Image("new_home_group_icon")
//                    Image("new_home_group_icon")
//                }
                NavigationLink {
                    ContentView2()
                } label: {
                    Image("new_home_group_icon")
                }

            }
        }.padding(10)
    }
}

struct ContentView2: View {
    var body: some View {
        Text("子页面").font(.title2)
    }
}
