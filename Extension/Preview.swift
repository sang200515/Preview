//
//  Preview.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 16/08/2023.
//

import Foundation
import SwiftUI

public enum PreviewDevices: String {
    case iPhone13
    case iPhoneSE3rdGen
    case iPadPro3rdGen
    case iPhone8Plus
    case iPhoneX
    case iPhone11
    case iPhone13ProMax
    case iPhone14Pro
    case iPhone14ProMax
    case iPadMini5thGen
    case iPadPro2ndGen

    var previewDisplayName: String {
        switch self {
        case .iPhone8Plus:           return "iPhone 8 Plus -> (w:\(size.width), h: \(size.height))"
        case .iPhoneX:               return "iPhone X -> (w:\(size.width), h: \(size.height))"
        case .iPhone11:              return "iPhone 11 -> (w:\(size.width), h: \(size.height))"
        case .iPhone13:              return "iPhone 13 -> (w:\(size.width), h: \(size.height))"
        case .iPhone13ProMax:        return "iPhone 13 Pro Max -> (w:\(size.width), h: \(size.height))"
        case .iPhone14Pro:           return "iPhone 14 Pro -> (w:\(size.width), h: \(size.height))"
        case .iPhone14ProMax:        return "iPhone 14 Pro Max -> (w:\(size.width), h: \(size.height))"
        case .iPhoneSE3rdGen:        return "iPhone SE (3rd Generation) -> (w:\(size.width), h: \(size.height))"
        case .iPadMini5thGen:        return "iPad Mini (5th gen) -> (w:\(size.width), h: \(size.height))"
        case .iPadPro3rdGen:         return "iPad Pro (3rd gen 12.9) -> (w:\(size.width), h: \(size.height))"
        case .iPadPro2ndGen:         return "iPad Pro (2nd gen 10.5) -> (w:\(size.width), h: \(size.height))"
        }
    }

    var previewDevice: String {
        switch self {
        case .iPhone8Plus:           return "iPhone 8 Plus"
        case .iPhoneX:               return "iPhone X"
        case .iPhone11:              return "iPhone 11"
        case .iPhone13:              return "iPhone 13"
        case .iPhone13ProMax:        return "iPhone 13 Pro Max"
        case .iPhone14Pro:           return "iPhone 14 Pro"
        case .iPhone14ProMax:        return "iPhone 14 Pro Max"
        case .iPhoneSE3rdGen:        return "iPhone SE (3rd Generation)"
        case .iPadMini5thGen:        return "iPad Mini (5th gen)"
        case .iPadPro3rdGen:         return "iPad Pro (3rd gen 12.9)"
        case .iPadPro2ndGen:         return "iPad Pro (2nd gen 10.5"
        }
    }

    var size: CGSize {
        switch self {
        case .iPhone8Plus:           return CGSize(width: 414, height: 736)
        case .iPhoneX:               return CGSize(width: 375, height: 812)
        case .iPhone11:              return CGSize(width: 414, height: 896)
        case .iPhone13:              return CGSize(width: 390, height: 844)
        case .iPhone13ProMax:        return CGSize(width: 428, height: 926)
        case .iPhone14Pro:           return CGSize(width: 393, height: 852)
        case .iPhone14ProMax:        return CGSize(width: 430, height: 932)
        case .iPhoneSE3rdGen:        return CGSize(width: 375, height: 667)
        case .iPadMini5thGen:        return CGSize(width: 768, height: 1024)
        case .iPadPro3rdGen:         return CGSize(width: 1024, height: 1366)
        case .iPadPro2ndGen:         return CGSize(width: 834, height: 1112)
        }
    }
}

@available(iOS 13.0, OSX 10.15, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
extension View {
    var idiom: UIUserInterfaceIdiom  { UIDevice.current.userInterfaceIdiom }
    func previewDevice(device: PreviewDevices) -> some View {
        previewDevice(PreviewDevice(rawValue: device.previewDevice))
            .previewDisplayName(device.previewDisplayName)
    }

    func previewIpad(device: PreviewDevices = .iPadPro3rdGen, orientations: [InterfaceOrientation] = [ .portrait, .landscapeLeft]) -> some View {
        ForEach(0..<2, id: \.self) { index2 in
            previewDevice(PreviewDevice(rawValue: device.previewDevice))
                .previewDisplayName(device.previewDisplayName)
                .previewInterfaceOrientation(orientations[index2])
        }

    }

    func previewIPhone(device: PreviewDevices = .iPhone13, orientations: [InterfaceOrientation] = [ .portrait, .landscapeLeft]) -> some View {
        ForEach(0..<2, id: \.self) { index2 in
            previewDevice(PreviewDevice(rawValue: device.previewDevice))
                .previewDisplayName(device.previewDisplayName)
                .previewInterfaceOrientation(orientations[index2])
        }
    }

    @ViewBuilder
    func previewDevicesNecessary(
        devices: [PreviewDevices] = [
            .iPhone13,
            .iPhoneSE3rdGen,
            .iPadPro3rdGen,
            .iPadMini5thGen,
            .iPadPro2ndGen,
            .iPhone8Plus,
            .iPhoneX,
            .iPhone11,
            .iPhone13ProMax,
            .iPhone14Pro,
            .iPhone14ProMax
        ], orientations: [InterfaceOrientation] = [ .portrait, .landscapeLeft]
    ) -> some View {
        ForEach(devices, id: \.self) { device in

            ForEach(0..<2, id: \.self) { index2 in
                if idiom == .phone && index2 == 1 {
                    previewDevice(device: device)
                        .previewDisplayName("null+")
                }else { previewDevice(device: device)
                        .previewInterfaceOrientation(orientations[index2])

                }
            }
        }
    }
}

struct ChildSizeReader<Content: View>: View {
    @Binding var size: CGSize
    let content: () -> Content
    var body: some View {
        ZStack {
            content()
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                )
        }
        .onPreferenceChange(SizePreferenceKey.self) { size in
            self.size = size
        }
    }
}

fileprivate struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}
struct PreviewResizableViewModifier: ViewModifier {
    @StateObject private var sizeObserver = ScreenSize.shared
    @State private var size = CGSize(width: 375, height: 667)
    @State private var contentSize: CGSize = .zero
    @State private var isRunning = false
    @State private var hiddenToolbar = true
    private let handleSize: CGFloat = 30
    private let minSize: CGSize = .init(width: 30, height: 30)
    private var isContentFitting: Bool {
        size.width >= contentSize.width && size.height >= contentSize.height
    }

    private var iphoneSEMinimum: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: sizeObserver.isPortrait ? 100 : 300, height: sizeObserver.isPortrait ? 300 : 100)
            .overlay(alignment: .bottomTrailing) {
                Text("iPhone Minimum")
                    .padding()
            }
    }

    private var iphoneSEFrame: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: sizeObserver.isPortrait ? 375 : 667, height: sizeObserver.isPortrait ? 667 : 375)
            .overlay(alignment: .bottomTrailing) {
                Text(sizeObserver.isPortrait ? "iPhone SE 3rd(w:375, h: 667)" : "iPhone SE 3rd(w:667, h: 375)")
                    .padding()
            }
    }
    private var iphone8PlusFrame: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: 414, height: 736)
            .overlay(alignment: .bottomTrailing) {
                Text("iPhone 8 Plus(w:414, h: 736)")
                    .padding()
            }
    }

    private var iphone13Frame: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: sizeObserver.isPortrait ? 390 : 844, height: sizeObserver.isPortrait ? 844 : 390)
            .overlay(alignment: .bottomTrailing) {
                Text(sizeObserver.isPortrait ? "iPhone SE 3rd(w:375, h: 667)" : "iPhone SE 3rd(w:844, h: 390)")
                    .padding()
            }
    }
    private var iphone14ProMaxFrame: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: sizeObserver.isPortrait ? 430 : 932, height: sizeObserver.isPortrait ? 932 : 430)
            .overlay(alignment: .bottomTrailing) {
                Text("iPhone 14 ProMax(w:430, h:932)")
            }
    }
    private var ipadMini5Frame: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: sizeObserver.isPortrait ? 768 : 1024, height: sizeObserver.isPortrait ? 1024 : 768)
            .overlay(alignment: .bottomTrailing) {
                Text("iPad Mini5 (w:768, h:1024)")
            }
    }
    private var ipad13: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: 455, height:  730)
            .overlay(alignment: .bottomTrailing) {
                Text("iPad 1/3")
                    .padding()
            }
    }
    private var ipad12: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: 680, height:  930)
            .overlay(alignment: .bottomTrailing) {
                Text("iPad 1/2")
                    .padding()
            }
    }
    private var ipad23: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray).opacity(0.3)
            .frame(width: 910, height:  970)
            .overlay(alignment: .bottomTrailing) {
                Text("iPad 2/3")
                    .padding()
            }
    }

    private var ipadPro4th11: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth:1, dash: [5]))
            .foregroundColor(.gray)
            .frame(width: sizeObserver.isPortrait ? 834 : 1194, height: sizeObserver.isPortrait ? 1194 : 834)
            .overlay(alignment: .bottomTrailing) {
                Text("iPad Pro 11inch(w:834, h:1194)")
                    .padding()
            }
    }

    private func reload(type: reloadType){
        switch type {
        case .iphoneSEMinimum:
            size = CGSize(width: sizeObserver.isPortrait ? 100 : 300, height: sizeObserver.isPortrait ? 300 : 100)
        case .iphoneSE:
            size = CGSize(width: sizeObserver.isPortrait ? 375 : 667, height: sizeObserver.isPortrait ? 667 : 375)
        case .iphone8plus:
            size = CGSize(width: 414, height: 736)
        case .iphone13:
            size = CGSize(width: sizeObserver.isPortrait ? 390 : 844, height: sizeObserver.isPortrait ? 844 : 390)
        case .iphone14promax:
            size = CGSize(width: sizeObserver.isPortrait ? 430 : 932, height: sizeObserver.isPortrait ? 932 : 430)
        case .ipadMini5:
            size = CGSize(width: sizeObserver.isPortrait ? 768 : 1024, height: sizeObserver.isPortrait ? 1024 : 768)
        case .ipadPro11:
            size = CGSize(width: sizeObserver.isPortrait ? 834 : 1194, height: sizeObserver.isPortrait ? 1194 : 834)
        case .ipadSplit13:
            size = CGSize(width: 455, height:  730)
        case .ipadSplit12:
            size = CGSize(width: 680, height:  930)
        case .ipadSplit23:
            size = CGSize(width: 910, height:  970)
        case .full:
            size = CGSize(width: sizeObserver.isPortrait ? 1024 : 1366, height: sizeObserver.isPortrait ? 1366 : 1024)
        }
        sizeObserver.isFitting = true
        sizeObserver.updateSize(size)
    }
    enum reloadType {
        case iphoneSEMinimum
        case iphoneSE
        case iphone8plus
        case iphone13
        case iphone14promax
        case ipadMini5
        case ipadPro11
        case ipadSplit13
        case ipadSplit12
        case ipadSplit23
        case full
    }
    private var listSelectionIphone: some View {
        VStack {
            if hiddenToolbar {
                VStack(alignment: .trailing,spacing: 12) {
                    Button {sizeObserver.isDragging.toggle()} label: {Text("Drag = \(sizeObserver.isDragging ? "true" : "false")")}
                        .tint(sizeObserver.isDragging ? .green : .red)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                    Button {reload(type: .iphoneSEMinimum)} label: {Text("Minimum")}
                    if sizeObserver.isPortrait {
                        Button {reload(type: .iphoneSE) } label: { Text("iPhone SE") }
                        Button {reload(type: .iphone8plus)} label: {Text("iPhone 8Plus") }
                        Button {reload(type: .iphone13)} label: {Text("iPhone 13)") }
                        Button {reload(type: .iphone14promax)} label: {Text("14 ProMax)")}
                    }
                    Button {reload(type: .ipadMini5)} label: {Text("iPad Mini5")}
                    Button {reload(type: .ipadPro11)} label: {Text("iPad Pro 11")}
                    if !sizeObserver.isPortrait {
                        Button {reload(type: .ipadSplit13)} label: {Text("iPad 1/3")}
                        Button {reload(type: .ipadSplit12)} label: {Text("iPad 1/2")}
                        Button {reload(type: .ipadSplit23) } label: {Text("iPad 2/3")}
                    }
                    Button {reload(type: .full)} label: {Text("Full") }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 20))
                .controlSize(.large)
            }
            Button { hiddenToolbar.toggle()} label: { Text("Hide Toolbar")
                    .tint(.red)
                    .padding(.top, 10)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .controlSize(.large)
            }
        }
    }
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            if isRunning {toolBarButtons(content: content)} else {content}
        }
        .padding()
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) { isRunning = true }
        }
    }

    private  var ipadButton: some View {
        Text(sizeObserver.isPortrait ? "Portrait(isPad = \(!sizeObserver.isPortrait ? "true" : "false"))" : "Landscape(isPad = \(!sizeObserver.isPortrait ? "true" : "false"))")
            .font(.system(size: 18))
            .foregroundColor(.white)
            .padding(10)
            .padding(.horizontal, 20)
            .background(sizeObserver.isPortrait ? .green : .red)
            .clipShape(Capsule())
            .onTapGesture { sizeObserver.isPortrait.toggle() }
            .offset(x:sizeObserver.isPortrait ? 750 : 800,y: sizeObserver.isPortrait ? 100 : 0)
    }

    private func toolBarButtons(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .bottomTrailing) {
                listSelectionIphone
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
            ipadButton
            iphoneSEMinimum
            if sizeObserver.isPortrait {
                iphoneSEFrame
                iphone8PlusFrame
                iphone13Frame
                iphone14ProMaxFrame
            }
            ipadMini5Frame
            ipadPro4th11
            if !sizeObserver.isPortrait {
                ipad13
                ipad12
                ipad23
            }
            GeometryReader { proxy in
                let maxSize = CGSize(width: proxy.size.width, height: proxy.size.height + proxy.safeAreaInsets.bottom)
                ZStack(alignment: .crossAlignment) {
                    contentWrapper(content)
                        .frame(width: min(maxSize.width, size.width), height: min(maxSize.height, size.height))
                        .overlay(rectangleHint)
                        .frame(width: size.width, height: size.height, alignment: .topLeading)
                        .background(.white)
                        .overlay {
                            Color.clear
                                .frame(width: contentSize.width + 2 , height: contentSize.height + 2)
                                .border(Color.green, width: sizeObserver.isDragging ? 1 : 0)
                        }

                    sizeDisplay
                        .alignmentGuide(.crossHorizontalAlignment, computeValue: { d in
                            size.width < 120 ? d[HorizontalAlignment.leading] - 10 : 120 })

                    dragHandle(maxSize: maxSize)
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

        }
    }

    private var rectangleHint: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [sizeObserver.isFitting ? 3 : 10]))
            .padding(-2)
            .foregroundColor(sizeObserver.isFitting ? .green : .red)
    }

    private func dragHandle(maxSize: CGSize) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "arrow.up.backward.and.arrow.down.forward")
                .frame(width: handleSize, height: handleSize)
                .dynamicTypeSize(.large)
                .background(sizeObserver.isDragging ? Color.green : Color.red.opacity(0.2))
                .frame(width: handleSize, height: handleSize)
                .cornerRadius(5)
                .gesture(DragGesture(minimumDistance: 0.0)
                    .onChanged { value in
                        sizeObserver.isDragging = true
                        sizeObserver.isFitting = false
                        size = CGSize(
                            width: min(maxSize.width, max(minSize.width, size.width + value.translation.width)),
                            height: min(maxSize.height, max(minSize.height, size.height + value.translation.height))
                        )
                        sizeObserver.updateSize(size)
                    }
                    .onEnded { _ in
                        sizeObserver.isDragging = false
                    }
                )
        }
        .simultaneousGesture(
            TapGesture(count: 2).onEnded { _ in
                size = CGSize(width: min(maxSize.width, contentSize.width), height: min(maxSize.height, contentSize.height))
                sizeObserver.updateSize(size)
            }
        )
    }

    private var sizeDisplay: some View {
        Text("\(text(for: size))")
            .padding(.bottom, 100)
            .offset(x: -50,y: 30)
            .font(.system(size: 25,weight: .bold))
            .foregroundColor(.green)
            .dynamicTypeSize(.large)
            .opacity(sizeObserver.isDragging ? 1 : 0)
            .transition(.opacity)
            .animation(.interactiveSpring(), value: sizeObserver.isDragging)
    }

    private func contentWrapper(_ content: Content) -> some View {
        ChildSizeReader(size: $contentSize) {
            content
        }
    }

    private func text(for size: CGSize) -> String { "w:\(Int(size.width)), h:\(Int(size.height))"}
}

fileprivate extension Alignment {
    static let crossAlignment = Alignment(horizontal: .crossHorizontalAlignment, vertical: .bottom)
}
fileprivate extension HorizontalAlignment {
    private enum CrossHorizontalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat { return d[.trailing]  }
    }
    static let crossHorizontalAlignment = HorizontalAlignment(CrossHorizontalAlignment.self)
}

struct DebugOverlayModifier: ViewModifier {
    @StateObject private var sizeObserver = ScreenSize.shared
    @State private var contentSize: CGSize = .zero
    func body(content: Content) -> some View {
        content
            .overlay{
                if sizeObserver.isDragging {
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(Color.random)
                        .padding(-1)
                }
            }
            .overlay(content: {
                if sizeObserver.isDragging {
                    HStack(spacing: 0){
                        Text("w: \(Int(contentSize.width)),")
                            .background(contentSize.width == sizeObserver.viewSize.width ? Color.green.opacity(0.7) : Color.black.opacity(0.4))
                        Text(" h:\(Int(contentSize.height))")
                            .background(contentSize.height == sizeObserver.viewSize.height ? Color.green.opacity(0.7) : Color.black.opacity(0.4))
                    }
                    .padding(4)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .frame(width: 250)
                    .offset(x: contentSize.width / 2 + 100)
                }
            })
            .readSize { size in
                contentSize = size
            }
    }
}

class ScreenSize: ObservableObject {
    static let shared = ScreenSize()
    @Published var isDragging: Bool = false
    @Published var isPortrait: Bool = true
    @Published var isFitting: Bool = false
    @Published var viewSize: CGSize = UIScreen.main.bounds.size

    func updateSize(_ size: CGSize) { viewSize = size }
}
struct RandomColor: ViewModifier {
    func body(content: Content) -> some View {
        content.background(Color.random)
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
class DebugDataSource {
    static let shared = DebugDataSource()
    struct ImageDataSample { //MARK: Image ✅
        private let randomeSize: [Int] = [20,50,100,150,200,300,400,500,650,800,1000,1200,1200]
        private let randomImageID: String = "\((1...1000).randomElement() ?? 1)"
        private var randomWidth: String { "\(randomeSize.randomElement() ?? 1)" }
        private var randomHeight: String { "\(randomeSize.randomElement() ?? 1)" }
        var randomURL: URL {
            let url: URL = URL(string: "https://picsum.photos/id/\(randomImageID)/\(randomWidth)/\(randomHeight)")!
            print(url.absoluteString)
            return url
        }
        var imageURL200x200: URL { URL(string: "https://picsum.photos/id/\(randomImageID)/200/200")! }
        var imageURL400x200: URL { URL(string: "https://picsum.photos/id/\(randomImageID)/200/200")! }
        var imageURL200x400: URL { URL(string: "https://picsum.photos/id/\(randomImageID)/200/200")! }
        var asyncImageDebug : some View {
            AsyncImage(url: randomURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
        }
    }
    struct StringDataSample { //MARK: string ✅
        private let paragraph = "これは例文です。この例文をテスト用に、より意味のある別の文にこれは例文です。この例文をテスト用に、より意味のある別の文にこれは例文です。この例文をテスト用に、より意味のある別の文にこれは例文です。この例文をテスト用に、より意味のある別の文にこれは例文です。この例文をテスト用に、より意味のある別の文にこれは例文です。この例文をテスト用に、より意味のある別の文に"
        func random(_ length: Int = 20) -> String {
            let randomCount: Int = (1...length).randomElement() ?? 1
            return String((0..<randomCount).map { _ in paragraph.randomElement() ?? String.Element("test")})
        }

        func randomOptional(_ length: Int = 20) -> String? {
            let randomCount: Int = (1...length).randomElement() ?? 1
            let listValue:[String?] = [nil, String((0..<randomCount).map { _ in paragraph.randomElement() ?? String.Element("sai logic roi")})]
            return listValue.randomElement() ?? nil
        }
    }

    struct BoolDataSample {
        private let listRandom: [Bool] = [true, false]
        private let listRandomOptional: [Bool?] = [nil,true, false]
        func random() -> Bool {  listRandom.randomElement() ?? false }
        func randomOptional() -> Bool? {  listRandomOptional.randomElement() ?? nil }
    }
}

extension View {
    func debugOverlay() -> some View {
        self.modifier(DebugOverlayModifier())
    }
    func debugBackground() -> some View {
        self.modifier(RandomColor())
    }
    func previewResizable() -> some View {
        modifier(PreviewResizableViewModifier())
            .previewIpad()
    }
}
