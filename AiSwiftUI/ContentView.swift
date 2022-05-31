//
//  ContentView.swift
//  AiSwiftUI
//
//  Created by Aiewing on 2022/5/31.
//

import SwiftUI

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

///
struct ContentView: View {

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
