//
//  PagerView.swift
//
//  Created by Majid Jabrayilov on 12/5/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

struct PagerView<Content: View>: View {
	let pageCount: Int
	@Binding var currentIndex: Int
	let content: Content

	@GestureState private var translation: CGFloat = 0

	init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
		self.pageCount = pageCount
		self._currentIndex = currentIndex
		self.content = content()
	}

	var body: some View {
		GeometryReader { geometry in
			HStack(spacing: 0) {
				self.content.frame(width: geometry.size.width)
			}
			.frame(width: geometry.size.width, alignment: .leading)
			.offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
			.offset(x: self.translation)
			.animation(.interactiveSpring())
			.gesture(
				DragGesture().updating(self.$translation) { value, state, _ in
					state = value.translation.width
				}.onEnded { value in
					let offset = value.translation.width / geometry.size.width
					let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
					self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
				}
			)
		}
	}
}

struct PagerViewTest: View {
	@State private var currentPage = 0

	var body: some View {
		PagerView(pageCount: 3, currentIndex: $currentPage) {
			Color.blue
			Color.red
			Color.green
		}.frame(height: 400)
	}
}

struct PagerView_Previews: PreviewProvider {
    static var previews: some View {
        PagerViewTest()
    }
}
