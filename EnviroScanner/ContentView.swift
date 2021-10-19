//
//  ContentView.swift
//  EnviroScanner
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentScene: Int = 1;
    
    var body: some View {
        
        VStack {
            
            NavBar()
            
            Spacer()
            
            if (currentScene == 1) {
                ScannerScene()
            }
            
            Spacer()
            
        }
        
    }
}

struct NavBar: View {
    // Pradyun to supply
    
    var body: some View {
        
        HStack {
            
            Text("Navbar Goes Here")
                .foregroundColor(.black)
            
        }
        .frame(maxWidth: .infinity)
        
        
    }
    
}

struct ScannerScene: View {
    
	@State private var itemAreaExpanded: Bool = false
	@State private var hasStartedScanning: Bool = false
    
	var body: some View {
		
		GeometryReader { geo in
			ZStack {
				
				VStack {
					Text("Competitive progress bar goes here")
					Text("Scan preview goes here and fills up remaining space")
					Text("View size:  (\(geo.size.width), \(geo.size.height))")
					
					Image("scanPreview")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(maxWidth: geo.size.width)
						.onTapGesture(perform: {
							self.hasStartedScanning.toggle()
						})
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
							
						} else {
							
							SmallTip(title: "Today's tip",
									 message: "Bring a 2L container to your shop this afternoon to buy your oats from the bulk bins. Avoid them plastic bags!",
									 cta: "+ 1 point to your sustainability score")
							
						}
						
					}.frame(alignment: .top)
						.padding()
					
				}
				
			}.frame(maxWidth: .infinity)
			
		}
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
