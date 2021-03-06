//
//  StandardViews.swift
//  EnviroScanner
//
//  Standard views used to construct the UI
//  These are things like buttons, titles
//  formatted as per the design language
//
//  Anyone's job
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct StandardViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// standard title element
struct Title: View {
    
    var text: String;
    
    var body: some View {
        Text(text)
            .font(.system(size: 28, weight: .medium))
            //.foregroundColor(Color("mediumGreen"))
    }
    
}

// port in VisualEffectView
// https://stackoverflow.com/questions/56610957/is-there-a-method-to-blur-a-background-in-swiftui
/*
 Useage:
	VisualEffectView(effect: UIBlurEffect(style: .dark))
 */
struct VisualEffectView: UIViewRepresentable {
	var effect: UIVisualEffect?
	func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
	func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct StandardSection<Content: View>: View {
	
	let content: Content
	
	init(@ViewBuilder content: () -> Content) {
		
		self.content = content()
		
	}
	
	var body: some View {
			
		VStack(alignment: .leading, spacing: 8) {
			self.content
		}
		.multilineTextAlignment(.leading)
		.frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
		
	}
	
}

// define theme stuff
struct Theme {
	
	struct c {
		let light = Color("themeLight")
		let med = Color("themeMed")
		let dark = Color("themeDark")
	}
	
}


struct StandardViews_Previews: PreviewProvider {
    static var previews: some View {
        StandardViews()
    }
}
