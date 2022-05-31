//
//  ContentView.swift
//  AiSwiftUI
//
//  Created by Aiewing on 2022/5/31.
//

import SwiftUI

/// 标签
struct LabelContentView: View {
    var body: some View {
        VStack {
            Label {
                Text("Progress")
            } icon: {
                Image(systemName: "book.circle")
            }
            
            List {
                Label("fdsfdsfdsfds", systemImage: "hand.point.left")
                Label("fdsfdsfdsgfdsgfdgfdgfdgfdgfdgfdgfdgfdgfdfds", systemImage: "hand.point.right")
                Label("fdsfdsfdsfds", systemImage: "flowchart")
            }

        }
    }
}

/// 日期格式
struct DateContentView: View {
    var now = Date()
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("Time is \(now, formatter: Self.dateFormatter)")
                .padding()
            Text("Time is \(now, formatter: Self.fullDateFormatter)")
                .padding()
        }
    }
}

/// 富文本
struct AttTextContentView: View {
    
    var body: some View {
        Text("fdsfdsa")
            .foregroundColor(.green)
            .fontWeight(.heavy)
        + Text("fdsfds")
            .foregroundColor(.orange)
            .strikethrough()
        + Text("fdsfds")
            .foregroundColor(.red)
            .italic()
        + Text("dfsfds")
            .foregroundColor(.purple)
            .underline()
    }
}

/// 输入框
struct TextFieldContentView: View {
    
    @State var username: String
    @State var nickname: String
    
    var body: some View {
        VStack {
            Text("Your username is \(username)")
            Text("Your nickname is \(nickname)")
            
            TextField("User Name", text: $username) { value in
                print("onEditingChanged: \(username)")
            } onCommit: {
                print("onCommit: \(username)")
            }
            .textFieldStyle(.roundedBorder)

            TextField("Nick Name", text: $nickname)
            .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

/// 密码输入框
struct SecureFieldContentView: View {

    @State var password: String

    var body: some View {
        VStack {
            Text("Your password is \(password)")

            SecureField("Password", text: $password) {
                print("Your password is \(password)")
            }
            .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

/// 多行输入框
struct TextEditorContentView: View {
    
    @State var content = ""
    @State var isAlert = false
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            
            TextEditor(text: $content)
                .background(.gray.opacity(0.3))
                .frame(height: 200)
            
            Button("Submit") {
                self.isAlert = true
            }
            .alert(isPresented: $isAlert) {
                Alert(title: Text("Content"), message: Text(content))
            }
        }
        .padding()
    }
}

/// 按钮
struct ButtonContentView: View {

    var body: some View {
        VStack {
            Button("First Button") {
                print("first button click")
            }
            
            Button {
                print("second button click")
            } label: {
                Text("Second Button")
            }
            
            Button {
                print("third button click")
            } label: {
                Image(systemName: "clock")
                Text("Third Button")
            }
            .foregroundColor(.white)
            .background(.orange)
            
            Button {
                print("padding button click")
            } label: {
                Text("Padding Button")
            }
            .padding(30)
            .background(.yellow)
            
            Button {
                print("padding button click")
            } label: {
                Text("Padding Button")
                    .padding(30)
                    .background(.orange)
            }
            
            Button {
                print("image button click")
            } label: {
                HStack {
                    Image(systemName: "star")
                    Text("Image Button ")
                }
                .padding()
                .background(.red)
            }
            
            Button {
                print("image button click")
            } label: {
                VStack {
                    Image(systemName: "star")
                    Text("Image Button ")
                }
                .padding()
                .background(.green)
            }

        }
        .padding()
    }
}

/// Button点击打开模态窗口
struct ButtonShowModalViewContentView: View {

    @State var isPresented = false

    var body: some View {
        VStack {
            Button("Show Modal") {
                isPresented = true
            }.sheet(isPresented: $isPresented) {
                MyDetailView(message: "Modal View")
            }
        }
    }
}

struct MyDetailView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
        }
    }
}

/// 图像
struct ImageContentView: View {

    var body: some View {
        VStack {
            Image("test_image")
            
            Image(systemName: "arkit")
                .foregroundColor(.orange)
                .font(.system(size: 48))
            
            Image("test_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Image("test_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .border(.orange, width: 10)
            
            Image("test_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 10)
            
            Image("test_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: .green, radius: 20, x: 20, y: 20)
            
//            Image("test_image")
//                .blur(radius: 2.0) // 高斯模糊
//                .blur(radius: 2.0, opaque: true) // 高斯模糊 透明像素是否模糊
//                .brightness(0.5) // 亮度
//                .colorInvert() // 颜色翻转
//                .colorMultiply(.green) // 颜色乘法效果
//                .contrast(1.5) // 对比度
//                .grayscale(0.9) // 灰度效果
        }
    }
}

/// 遮罩图像
struct ImageMaskContentView: View {

    var body: some View {
        VStack {
            Image("test_image")
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
            
            Image("test_image")
                .frame(width: 100, height: 100, alignment: .center)
                .mask(Circle())
            
            Image("test_image")
                .mask {
                    Text("Swift UI")
                        .font(.system(size: 60))
                        .bold()
                }
            
        }
    }
}

/// 网络图片
struct NetworkImageContentView: View {

    @State private var remoteImage: UIImage?
    let placeholderImage = UIImage(named: "test_image")!

    var body: some View {
        VStack {
            Image(uiImage: remoteImage ?? placeholderImage)
                .onAppear(perform: fetchRemoteImage)

        }
    }
    
    func fetchRemoteImage() {
        guard let url = URL(string: "https://tenfei02.cfp.cn/creative/vcg/veer/1600water/veer-316247836.jpg") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let image = UIImage(data: data!) {
                self.remoteImage = image
            }
        }
        .resume()
    }
}

/// 选择器
struct PickerContentView: View {

    var fruits = ["Apple", "Banner", "Orange"]
    var colors: [Color] = [.red, .yellow, .orange]
    
    @State private var selectedItem = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedItem, label: Text("Fruits")) {
                ForEach(0..<fruits.count) {
                    Text(self.fruits[$0])
                        .foregroundColor(self.colors[$0])
                }
            }
            Text("Your choice: ")
            + Text("\(fruits[selectedItem])")
                .foregroundColor(self.colors[selectedItem])
        }
    }
}

/// 时间选择器
struct DatePickerContentView: View {

    var myDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker(selection: $selectedDate,in: Date()...Date().advanced(by: 7 * 24 * 3600), displayedComponents: [.date, .hourAndMinute]) {
                Text("Date")
            }
            
            Text("Your choice: \(selectedDate, formatter: myDateFormatter)")
        }
    }
}

///  分段选择器
struct SegmentedContentView: View {

    private let animals = ["🐶Dog", "🐅Tiger", "🐷Pig"]
    @State var selectedAnimal = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedAnimal, label: Text("Animals")) {
                ForEach(0..<animals.count) {
                    Text(self.animals[$0])
                }
            }
            .pickerStyle(.segmented)
            
            Text("Your choice: ")
            + Text("\(animals[selectedAnimal])")
        }
    }
}

/// 滑杆
struct SliderContentView: View {

    @State var temperature: Double = 0
    
    var body: some View {
        VStack {
            Slider(value: $temperature)
            
            Slider(value: $temperature, in: -20...40) { item in
                print(item)
            }
            
            HStack {
                Image(systemName: "sun.max")
                
                Slider(value: $temperature, in: -20...40, step: 2)
                    .accentColor(.green).colorInvert()
                
                Image(systemName: "sun.max.fill")
            }
            
            Text("The temperature is \(temperature)")
        }
        .padding()
    }
}

/// 步进器
struct StepperContentView: View {

    @State var temperature: Int = 0
    
    var body: some View {
        VStack {
            Stepper {
                self.temperature += 1
            } onDecrement: {
                self.temperature -= 1
            } label: {
                Text("The temperature is \(temperature)")
            }
        }
        .padding()
    }
}

/// 开关控件
struct ToggleContentView: View {

    @State var showNotifucation = true
    
    var body: some View {
        VStack {
            Text("Show Notifucation: ")
            + Text("\(self.showNotifucation ? "True" : "Flase")")
                .foregroundColor(.green)
                .bold()
            
            Toggle(isOn: $showNotifucation) {
                Text("Show Notifucation")
            }
            .padding()
        }
    }
}

/// TabView
struct TabViewContentView: View {
    
    var body: some View {
        VStack {
            TabView {
                Text("The home page")
                    .font(.system(size: 36))
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                Text("The setting page")
                    .font(.system(size: 36))
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setting")
                    }
            }
        }
    }
}

/// WKWebView
import WebKit
struct WKWebViewContentView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<WKWebViewContentView>) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WKWebViewContentView>) {
        let request = URLRequest(url: URL(string: "http://www.baidu.com")!)
        uiView.load(request)
    }
}

/// 地图
import MapKit
struct MKMapViewContentView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<MKMapViewContentView>) -> MKMapView {
        return MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MKMapViewContentView>) {
        uiView.showsUserLocation = true
        uiView.mapType = .satellite

        let coor = CLLocationCoordinate2D(latitude: 19, longitude: 116)
        let region = MKCoordinateRegion(center: coor, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

        uiView.setRegion(uiView.regionThatFits(region), animated: true)
    }
}

/// ActivityIndicator
struct ActivityIndicatorContentView: View {
    
    @State var isActive = true
    
    var body: some View {
        VStack {
            LoadingView(isActive: $isActive)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                        self.isActive.toggle()
                        timer.invalidate()
                    }
                }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isActive: Bool
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isActive ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView: View {
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Text("Waiting...")
            ActivityIndicator(isActive: $isActive)
        }
        .frame(width: UIScreen.main.bounds.width / 2,
               height: UIScreen.main.bounds.height / 5)
        .background(.orange)
        .foregroundColor(.primary)
        .cornerRadius(20)
        .opacity(isActive ? 1 : 0)
    }
}

import Combine
class GlobalData: ObservableObject {
    @Published var isActive = false
    var cancelableSubscriber: AnyCancellable?
    
    init() {
        cancelableSubscriber = $isActive
            .delay(for: 3, scheduler: RunLoop.main)
            .map { _ in false }
            .assign(to: \.isActive, on: self)
    }
}

/// ActivityIndicator2
struct ActivityIndicator2ContentView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        LoadingView(isActive: $globalData.isActive)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let globalData = GlobalData()
        globalData.isActive = true
        
        return ContentView().environmentObject(globalData)
    }
}
