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
//        File Name:       SwiftUI20220714.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/7/14 10:17 AM
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import SwiftUI


struct Hike: Codable, Hashable, Identifiable {

    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: [Observation]

    static var formatter = LengthFormatter()

    var distanceText: String {
        Hike.formatter.string(fromValue: distance, unit: .kilometer)
    }

    struct Observation: Codable, Hashable {
        var distanceFromStart: Double
        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}

class HikeViewModel: ObservableObject
{
    @Published var hides: [Hike] = load("hikeData.json")
}

struct SwiftUI20220714: View {

    var hike: Hike
    @State private var showDetail: Bool = false

    var body: some View {
        VStack {
            HStack {

            }
        }
    }
}

//struct HikeGraph: View {
//
//    var hike: Hike
//    var path: KeyPath<Hike.Observation, Range<Double>>
//
//    var color: Color {
//        switch path {
//        case \.elevation:
//            return .gray
//        case \.heartRate:
//            return Color(hue: 0, saturation: 0.5, brightness: 0.7)
//        case \.pace:
//            return Color(hue: 0.7, saturation: 0.4, brightness: 0.7)
//        default:
//            return .black
//        }
//    }
//
//    var body: some View {
//        let data = hike.observations
//        let overallRange = rangeOfRanges(data.lazy.map { $0[keyPath: path] })
//        let maxMagnitude = data.map { magnitude(of: $0[keyPath: path]) }.max()!
//        let heightRatio = 1 - CGFloat(maxMagnitude / magnitude(of: overallRange))
//        return GeometryReader { proxy in
//            HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
//                ForEach(Array(data.enumerated()), id: \.offset) { index, observation in
//                    GraphCapsule(
//                        index: index,
//                        color: color,
//                        height: proxy.size.height,
//                        range: observation[keyPath: path],
//                        overallRange: overallRange
//                    )
//                        .animation(.ripple())
//                }
//                    .offset(x: 0, y: proxy.size.height * heightRatio)
//            }
//        }
//    }
//}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
            .asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .scale.combined(with: .opacity))
    }
}

//struct SwiftUI20220714_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUI20220714()
//    }
//}
