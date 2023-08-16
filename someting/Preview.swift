//
//  Preview.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 16/08/2023.
//

import Foundation


public enum Device: String {
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
    func previewDevice(device: Device) -> some View {
        previewDevice(PreviewDevice(rawValue: device.previewDevice))
            .previewDisplayName(device.previewDisplayName)
    }

    func previewDevices(devices: [Device]) -> some View {
        ForEach(devices, id: \.self) { device in
            previewDevice(device: device)
        }
    }
    @ViewBuilder
    func previewDevicesNecessary(
        devices: [Device] = [
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

@available(iOS 13.0, macOS 11.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
extension View {

    func previewDevice(device: Device, colorScheme: ColorScheme) -> some View {
        previewDevice(device: device)
            .preferredColorScheme(colorScheme)
    }

    func previewDevice(device: Device, colorSchemes: [ColorScheme]) -> some View {
        ForEach(0..<colorSchemes.count, id: \.self) { index in
            previewDevice(device: device)
                .preferredColorScheme(colorSchemes[index])
        }
    }
}

@available(iOS 15.0, OSX 12.00, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
extension View {

    func previewDevice(device: Device, orientation: InterfaceOrientation) -> some View {
        previewDevice(device: device)
            .previewInterfaceOrientation(orientation)
    }

    func previewDevice(device: Device, orientations: [InterfaceOrientation]) -> some View {
        ForEach(0..<orientations.count, id: \.self) { index in
            previewDevice(device: device)
                .previewInterfaceOrientation(orientations[index])
        }
    }

    func previewDevice(device: Device, orientation: InterfaceOrientation, colorSchemes: [ColorScheme]) -> some View {
        ForEach(0..<colorSchemes.count, id: \.self) { index in
            previewDevice(device: device)
                .previewInterfaceOrientation(orientation)
                .preferredColorScheme(colorSchemes[index])
        }
    }

}

import SwiftUI

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
//
//  PreviewResizableViewModifier.swift
//  PreviewResizable
//
//  Created by Joan Duat on 8/11/22.
//

import SwiftUI

struct PreviewResizableViewModifier: ViewModifier {

    @State private var size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
    @State private var isDragging = false
    @State private var contentSize: CGSize = .zero
    @State private var isRunning = false

    private let handleSize: CGFloat = 30
    private let minSize: CGSize = .init(width: 30, height: 30)
    private var isContentFitting: Bool {
        size.width >= contentSize.width && size.height >= contentSize.height
    }

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            if isRunning {
                GeometryReader { proxy in
                    let maxSize = CGSize(width: proxy.size.width, height: proxy.size.height + proxy.safeAreaInsets.bottom)
                    ZStack(alignment: .crossAlignment) {
                        contentWrapper(content)
                            .frame(width: min(maxSize.width, size.width), height: min(maxSize.height, size.height))
                            .overlay(rectangleHint)
                            .frame(width: size.width, height: size.height, alignment: .topLeading)

                        sizeDisplay
                            .alignmentGuide(.crossHorizontalAlignment, computeValue: { d in
                                size.width < 120 ? d[HorizontalAlignment.leading] - 10 : 120 })

                        dragHandle(maxSize: maxSize)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                content
            }
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                isRunning = true
            }
        }
    }

    private var rectangleHint: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(isContentFitting ? .gray : .red)
    }

    private func dragHandle(maxSize: CGSize) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "arrow.up.backward.and.arrow.down.forward")
                .frame(width: handleSize, height: handleSize)
                .dynamicTypeSize(.large)
                .background(Color.gray.opacity(0.2).frame(width: handleSize, height: handleSize))
                .gesture(DragGesture(minimumDistance: 0.0)
                    .onChanged { value in
                        isDragging = true
                        size = CGSize(
                            width: min(maxSize.width, max(minSize.width, size.width + value.translation.width)),
                            height: min(maxSize.height, max(minSize.height, size.height + value.translation.height))
                        )
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
                )
        }
        .simultaneousGesture(
            TapGesture(count: 2).onEnded { _ in
                // Size to fit:
                size = CGSize(width: min(maxSize.width, contentSize.width), height: min(maxSize.height, contentSize.height))
            }
        )
    }

    private var sizeDisplay: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("\(text(for: contentSize))")
                .foregroundColor(.white)
                .background(Color.accentColor)

            Text("\(text(for: size))")
                .foregroundColor(isContentFitting ? .primary : .white)
                .background(isContentFitting ? Color(uiColor: .systemGroupedBackground) : .red)
        }
        .font(.caption)
        .dynamicTypeSize(.large)
        .opacity(isDragging ? 1 : 0)
        .transition(.opacity)
        .animation(.interactiveSpring(), value: isDragging)
    }

    private func contentWrapper(_ content: Content) -> some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                ChildSizeReader(size: $contentSize) {
                    content
                }
                .border(Color.accentColor, width: isDragging ? 1 : 0)
            }
        }
    }

    private func text(for size: CGSize) -> String {
        "w: \(Int(size.width)), h: \(Int(size.height))"
    }
}

// MARK: - Alignment extensions

fileprivate extension Alignment {
    static let crossAlignment = Alignment(horizontal: .crossHorizontalAlignment, vertical: .bottom)
}
fileprivate extension HorizontalAlignment {
    private enum CrossHorizontalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.trailing]
        }
    }
    static let crossHorizontalAlignment = HorizontalAlignment(CrossHorizontalAlignment.self)
}

// MARK: - View extension

public extension View {

    /// Makes the container for the preview resizable.
    ///
    /// During resizing both the size of the content and the container views are displayed so it’s easy to see whether the content view fits in the new area.
    ///
    /// Double-clicking the resize button adapts the container view size to the content size.
    func previewResizable() -> some View {
        modifier(PreviewResizableViewModifier())
    }
}
