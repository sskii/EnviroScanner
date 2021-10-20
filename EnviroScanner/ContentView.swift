//
//  ContentView.swift
//  EnviroScanner
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentScene: Int = 1;
	@State var pageTitle: String = "No title"
    
    var body: some View {
        
        VStack {
            
			NavBar(currentScene: $currentScene, title: $pageTitle)
            
            if (currentScene == 1) {
				ScannerScene(title: $pageTitle)
			} else if (currentScene == 2) {
				ReviewScene()
			} else if (currentScene == 3) {
				PreferencesView()
			}
            
		}.frame(alignment: .top)
		.accentColor(Color("themeMed"))
        
    }
}

struct NavBar: View {
    // Pradyun to supply
	
	@Binding var currentScene: Int
	@Binding var title: String
    
    var body: some View {
        
        HStack {
			Image(systemName: icons[currentScene])
			Text(showsDynamicTitle[currentScene] ? title : defaultTitles[currentScene])
                .foregroundColor(.black)
				.font(.system(size: 22, weight: .bold))
			
			Spacer()
			
			switch currentScene {
			case 1:
				Button(action: { currentScene = 2 }) {
					Image(systemName: "clock.arrow.circlepath")
				}
				Button(action: {currentScene = 3}) {
					Image(systemName: "gearshape")
				}
			case 2:
				Button(action: { currentScene = 1 }) {
					Image(systemName: "barcode.viewfinder")
				}
				Button(action: { currentScene = 3 }) {
					Image(systemName: "gearshape")
				}
			case 3:
				Button(action: { currentScene = 1 }) {
					Image(systemName: "barcode.viewfinder")
				}
				Button(action: {currentScene = 2}) {
					Image(systemName: "clock.arrow.circlepath")
				}
			default:
				Text("shrug")
			}
			
			
//			Button {
//				currentScene = nextScene[currentScene + 1]
//			} label: {
//				Image(systemName: icons[currentScene + 1])
//			}
//
//			Button {
//				currentScene = nextScene[currentScene + 2]
//			} label: {
//				Image(systemName: icons[currentScene + 2])
//			}
            
        }.font(.system(size: 22, weight: .bold))
		.padding()
        .frame(maxWidth: .infinity)
        
        
	}
	
	private let defaultTitles = [
		"No scene",
		"Scan to start",
		"Review",
		"Preferences"
	]
	
	private let showsDynamicTitle = [
		false,
		true,
		false,
		false
	]
	
	private let icons = [
		"exclamationmark.triangle",
		"barcode.viewfinder",
		"clock.arrow.circlepath",
		"gearshape",
		"barcode.viewfinder",		// I don't know how to handle rolling the index around in Swift
		"clock.arrow.circlepath"	// so I'll do it by including repeated definitions. Sorry.
	]
	
	// this corresponds to the scene represented by the above icons
	private let nextScene = [
		1,
		1,
		2,
		3,
		1,
		2
	]
    
}

struct ScannerScene: View {
    
	@State private var itemAreaExpanded: Bool = false
	@State private var hasStartedScanning: Bool = false
	@State private var isLoading: Bool = false
	
	@Binding var title: String
    
	var body: some View {
		
		GeometryReader { geo in
			ZStack {
				
				Image("scanPreview")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
					.onTapGesture(perform: {
						self.hasStartedScanning.toggle()
						title = (hasStartedScanning ? "Scanner" : "Scan to start")
					})
				
				VStack(spacing: -16) {
					
					ZStack(alignment: .bottom) {
						
						Rectangle()
							.foregroundColor(.white)
							.cornerRadius(16)
						
						CompetitiveVisualisation()
						
					}.frame(maxWidth: .infinity, maxHeight: 70)
						.zIndex(2)
					
					Spacer()
					
					
				}
				
				BottomSheetView(
					isOpen: self.$itemAreaExpanded,
					maxHeight: geo.size.height
				) {
					//Text("This is where we will provide tips at the app's first launch. Then when our user goes ahead and starts scanning, we'll switch over to showing a preview of the last scan and a specific tip to follow. User can swipe up for more info at any point.")
					//	.padding()
						
					VStack(spacing: 24) {
								
						if(hasStartedScanning) {
							
							ScanPreview()
							SmallTip(title: "Stock up!",
									 message: "If you can stand the taste, Watties Spaghetti is excellent compared to what you normally buy.")
							ScanDetails()
							
						} else {
							
							SmallTip(title: "Today's tip",
									 message: "Bring a 2L container to your shop this afternoon to buy your oats from the bulk bins. Avoid them plastic bags!",
									 cta: "+ 1 point to your sustainability score")
							
							HStack {
								if(isLoading) {
									ActivityIndicator(isAnimating: .constant(true), style: .medium)
									Text("Pondering more tips")
									Spacer()
								} else {
									Button {
										itemAreaExpanded = true
										isLoading.toggle()
									} label: {
										Text("Load more tips…")
										Spacer()
									}
								}
							}
							
						}
						
					}.frame(alignment: .top)
						.padding()
					
				}
				
			}
			.ignoresSafeArea()
			.frame(maxWidth: .infinity)
			.onAppear { title = (hasStartedScanning ? "Scanner" : "Scan to start") }
			
		}
    }
    
}

// spinner thingy
// https://www.codegrepper.com/code-examples/swift/swiftui+spinner
struct ActivityIndicator: UIViewRepresentable {

	@Binding var isAnimating: Bool
	let style: UIActivityIndicatorView.Style

	func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
		return UIActivityIndicatorView(style: style)
	}

	func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
		isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
