//
//  BottomSheetView.swift
//
//  Created by Majid Jabrayilov
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 100
    static let snapRatio: CGFloat = 0.25
	static let minHeightRatio: CGFloat = 0.4
}

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
	let minHeight: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) : maxHeight - minHeight
    }

    private var indicator: some View {
		
		RoundedRectangle(cornerRadius: Constants.radius)
			.fill(Color.secondary)
			.frame(
				width: Constants.indicatorWidth,
				height: Constants.indicatorHeight)
			.frame(maxWidth: .infinity, maxHeight: 40)
			.contentShape(Rectangle())
			.onTapGesture {
				self.isOpen.toggle()
			}
		
	}

	init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
			ZStack(alignment: .top) {
				self.content
					.padding(.top, 32)
				self.indicator
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
			.background(VisualEffectView(effect: UIBlurEffect(style: .regular)))
			.background(.white.opacity(0.9))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
			.shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
	
    static var previews: some View {
        BottomSheetTestView()
    }
}

struct BottomSheetTestView: View {
	
	@State var isOpen = false;
	
	var body: some View {
		
		BottomSheetView(isOpen: $isOpen, maxHeight: 600) {
			Text("Hi, I'm a view")
		}.edgesIgnoringSafeArea(.all)

		
	}
	
}
