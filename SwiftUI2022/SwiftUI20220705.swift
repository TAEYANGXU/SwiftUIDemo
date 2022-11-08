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
//        File Name:       SwiftUI20220705.swift
//        Product Name:    SwiftUI2022
//        Author:          yanzhangxu@___ORGANIZATIONNAME___
//        Swift Version:   5.0
//        Created Date:    2022/7/5 3:38 PM
//
//        Copyright © 2022 ___ORGANIZATIONNAME___.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import SwiftUI
import Combine
import SwiftyJSON
import ObjectMapper
//import ObjectMapper

//dict1 Optional(["weatherinfo": {
//    AP = 1002hPa;
//    Radar = "JC_RADAR_AZ9010_JB";
//    SD = "28%";
//    WD = "\U5357\U98ce";
//    WS = "\U5c0f\U4e8e3\U7ea7";
//    WSE = "<3";
//    city = "\U5317\U4eac";
//    cityid = 101010100;
//    isRadar = 1;
//    njd = "\U6682\U65e0\U5b9e\U51b5";
//    sm = "2.1";
//    temp = "27.9";
//    time = "17:55";
//}])

//struct  Weatherinfo : Hashable,Codable
//{
//    var weatherinfo: Weather?
//}
//
//struct  Weather : Hashable,Codable
//{
//    var city: String?
//    var cityid: Int32?
//    var WS:String?
//}


struct Weatherinfo: Mappable, Hashable
{
    var weatherinfo: Weather?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        weatherinfo <- map["weatherinfo"]
    }
}

struct Weather: Mappable, Hashable
{
    var city: String?
    var cityid: Int32?
    var WS: String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        city <- map["city"]
        cityid <- map["cityid"]
        WS <- map["WS"]
    }
}

struct WeatherListView: View
{
    @StateObject var vm = WeatherViewModel()

    var body: some View {
        VStack {
            List(vm.weatherList, id: \.self) { t in
                Text(t.city!)
            }
        }.navigationTitle("天气").navigationBarItems(trailing: Button(action: {
            vm.doRequestWeather()
        }, label: {
                Image(systemName: "plus.circle")
            }))
    }
}

enum MyError: Swift.Error {
    case someError
}

class WeatherViewModel: ObservableObject
{

    var weatherPub = PassthroughSubject<Weather, Never>()
    @Published var weatherList: [Weather] = []
    var cancelable: AnyCancellable?
    var cancellables: [AnyCancellable] = []

    init() {
        print("qingqiu")
        cancelable = weatherPub.sink(receiveValue: { weather in
            print("qingqiu2")
            self.weatherList.append(weather)
        })

        doRequestWeather()
//        loadItems()

    }

    func doRequestWeather()
    {
        print("进入")

//        let datatask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "http://www.weather.com.cn/data/sk/101010100.html")!)) { data, response, error in
//            if let data = data {
//                let json = String(data:data, encoding: .utf8)
////                let json = try? JSON(data: data)
//                let weather = Mapper<Weatherinfo>().map(JSONString: json!)
//                if let weatherinfo = weather?.weatherinfo {
//                    print("weatherinfo",weatherinfo)
////                    self.weatherPub.send(weatherinfo)
//                    self.weatherList.append(weatherinfo)
//                }
//            }
//        }.resume()

        let url = URL(string: "http://www.weather.com.cn/data/sk/101010100.html")!
        URLSession.shared.dataTaskPublisher(for: url).share().map(\.data).sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    return
                }
            }, receiveValue: { data in
                let json = String(data: data, encoding: .utf8)
                let weather = Mapper<Weatherinfo>().map(JSONString: json!)
                if let weatherinfo = weather?.weatherinfo {
                    print("weatherinfo", weatherinfo)
                    self.weatherPub.send(weatherinfo)
                }
            }).store(in: &cancellables)
    }



    func loadItems()
    {
        let url = URL(string: "http://www.weather.com.cn/data/sk/101010100.html")!
        URLSession.shared.dataTaskPublisher(for: url)
            .sink(
            receiveCompletion: {
                completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    return
                } },
            receiveValue: { data, _ in
                print("data ----- ")
                DispatchQueue.main.async {
                    let json = String(data: data, encoding: .utf8)
                    let weather = Mapper<Weatherinfo>().map(JSONString: json!)
                    if let weatherinfo = weather?.weatherinfo {
                        print("weatherinfo", weatherinfo)
                        self.weatherPub.send(weatherinfo)
                    }
                }
            })
            .store(in: &cancellables)
    }

    deinit {
        cancelable?.cancel()
        cancellables.forEach {
            $0.cancel()
        }
    }
}
