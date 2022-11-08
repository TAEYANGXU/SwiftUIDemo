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
//        File Name:       SwiftUI20220706.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/7/6 10:19 AM
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'

import Foundation
import SwiftUI
import Combine
import CoreLocation
import MapKit

struct Landmark: Hashable, Codable, Identifiable
{
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool

    private var imageName: String
    var image: Image
    {
        return Image(imageName)
    }
    
    var category: Category
    enum Category: String,Codable,CaseIterable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }

    private var coordinates: Coordinates
    struct Coordinates: Hashable, Codable
    {
        var latitude: Double
        var longitude: Double
    }

    var locationCoordinate: CLLocationCoordinate2D
    {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}


struct SwiftUI20220706: View
{
    @EnvironmentObject var vm: LandmarkViewModel
    @State private var showFavoritesOnly = false

    var filteredLandmarks: [Landmark] {
        vm.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }

    var body: some View {
        List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }.onTapGesture {
//                    vm.showFavoritesOnly = !self.showFavoritesOnly
//                    vm.doFilteredLandmarks()
            }
            ForEach(filteredLandmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark).environmentObject(vm)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
            }
        }.navigationTitle("Landmarks").navigationBarTitleDisplayMode(.inline)

//            List(vm.landmarks, id: \.id) { landmark in
//                NavigationLink {
//                    LandmarkDetail(landmark: landmark)
//                } label: {
//                    LandmarkRow(landmark: landmark)
//                }
//            }.navigationTitle("Landmarks")
    }
}

class LandmarkViewModel: ObservableObject
{
    @Published var landmarks: [Landmark] = []
    var categories: [String: [Landmark]] {
        Dictionary(grouping: landmarks, by: { $0.category.rawValue })
    }
    
    var features: [Landmark] {
        landmarks.filter({ $0.isFavorite })
    }
    
    var cancellable: AnyCancellable?
    var cancellables: [AnyCancellable] = []
//    var landmarkSubject = PassthroughSubject<[Landmark],Never>()

    init() {
//        cancellable = landmarkSubject.sink(receiveCompletion: { completion in
//            switch (completion) {
//            case .finished :
//            break
//            }
//        }, receiveValue: { landmarks in
//            print("接收")
//            self.landmarks.append(contentsOf: landmarks)
//        })
        doRequestLandmarks()
    }
    func doRequestLandmarks()
    {
        let list: [Landmark] = load("landmarkData.json")
//        let newList = list.filter { landmark in
//            landmark.isFavorite
//        }
//        landmarkSubject.send(list)
        self.landmarks.append(contentsOf: list)
    }
}

struct LandmarkRow: View
{
    var landmark: Landmark
    var body: some View {
        HStack {
            landmark.image.resizable().frame(width: 50, height: 50).cornerRadius(5, antialiased: true)
            Text(landmark.name)

            Spacer()
            if landmark.isFavorite {
                Image(systemName: "star.fill").imageScale(.medium).foregroundColor(.yellow)
            }
        }
    }
}

struct MapView: View {

    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()

    var body: some View {
        Map(coordinateRegion: $region).onAppear {
            setRegion(coordinate)
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}

struct CircleImage: View {
    var image: Image
    var body: some View {
        image.clipShape(Circle()).overlay {
            Circle().stroke(.white, lineWidth: 4)
        }.shadow(radius: 7)
    }
}

struct FavoriteButton: View {

    @Binding var isFavorite: Bool
    var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isFavorite ? "star.fill" : "star").labelStyle(.iconOnly).foregroundColor(isFavorite ? .yellow : .gray)
        }
    }
}


struct LandmarkDetail: View {

    @EnvironmentObject var vm: LandmarkViewModel
    var landmark: Landmark
    var landmarkIndex: Int {
        vm.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isFavorite: $vm.landmarks[landmarkIndex].isFavorite)
                }
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Divider()
                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }.padding()
//            Spacer()
        }
            .navigationTitle(landmark.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}


var landmarkList: [Landmark] = load("landmarkData.json")
/** Model Data By  Json **/


func load<T: Decodable>(_ filename: String) -> T {

    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
        fatalError("Couldn't find \(filename) in main bundle")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
