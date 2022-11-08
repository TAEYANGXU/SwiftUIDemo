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
//        File Name:       SwiftUI20220708.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/7/8 2:51 PM
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import SwiftUI

struct SwiftUI20220708: View {
    @EnvironmentObject var vm: LandmarkViewModel
    var body: some View {
        List{
            vm.features[0].image
                .resizable()
                .scaledToFill()
                .frame(height:200)
                .clipped().cornerRadius(8)
            ForEach(vm.categories.keys.sorted(), id: \.self ){ key in
                CategoryRow(categoryName: key, items: vm.categories[key]!).environmentObject(vm).background(.white)
            }
        }.navigationTitle("Featured").navigationBarTitleDisplayMode(.large)
    }
}

struct CategoryRow: View {
    
    @EnvironmentObject var vm: LandmarkViewModel
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading,15)
                .padding(.top,5)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark  in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark).environmentObject(vm)
                        } label: {
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
            }.frame(height:185)
        }
    }
}

struct CategoryItem: View {
    
    var landmark: Landmark
    
    var body: some View {
        VStack(alignment:.leading) {
            landmark.image
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmark.name)
                .font(.caption)
        }.padding(.leading,15)
    }
}

struct SwiftUI20220708_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI20220708()
    }
}
