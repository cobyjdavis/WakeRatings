//
//  UnderlineTab.swift
//  WakeRatings
//
//  Created by CJ Davis on 11/2/20.
//

import SwiftUI

extension HorizontalAlignment {
    private enum UnderlineLeading: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.leading]
        }
    }

    static let underlineLeading = HorizontalAlignment(UnderlineLeading.self)
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat(0)

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }

    typealias Value = CGFloat
}


struct GridViewHeader : View {

    @Binding var activeIdx: Int
    @State private var w: [CGFloat] = [0, 0]

    var body: some View {
        return VStack(alignment: .underlineLeading) {
            HStack(spacing: 100) {
                Text("Professors")
                    .font(Font.custom("RockoFLF-Bold", size: 20)).foregroundColor(.white).shadow(radius: 1)
                    .modifier(MagicStuff(activeIdx: $activeIdx, idx: 0))
                    .background(TextGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[0] = $0 })

                Text("Courses")
                    .font(Font.custom("RockoFLF-Bold", size: 20)).foregroundColor(.white).shadow(radius: 1)
                    .modifier(MagicStuff(activeIdx: $activeIdx, idx: 1))
                    .background(TextGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[1] = $0 })
                
                }
                .frame(height: 8)
                .padding(.horizontal, 10)
            Rectangle()
                .foregroundColor(.white)
                .alignmentGuide(.underlineLeading) { d in d[.leading]  }
                .frame(width: w[activeIdx],  height: 3, alignment: .center)
                .animation(.linear)
        }
    }
}

struct TextGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            return Rectangle().fill(Color.clear).preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}

struct MagicStuff: ViewModifier {
    @Binding var activeIdx: Int
    let idx: Int

    func body(content: Content) -> some View {
        Group {
            if activeIdx == idx {
                content.alignmentGuide(.underlineLeading) { d in
                    return d[.leading]
                }.onTapGesture { self.activeIdx = self.idx }

            } else {
                content.onTapGesture { self.activeIdx = self.idx }
            }
        }
    }
}

struct UnderlineTab_Previews: PreviewProvider {
    static var previews: some View {
        GridViewHeader(activeIdx: .constant(0))
    }
}
