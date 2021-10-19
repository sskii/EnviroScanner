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
    
	@State private var itemAreaExpanded = false
    
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
					Spacer()
				}
				
				BottomSheetView(
					isOpen: self.$itemAreaExpanded,
					maxHeight: geo.size.height
				) {
					Text("This is where we will provide tips at the app's first launch. Then when our user goes ahead and starts scanning, we'll switch over to showing a preview of the last scan and a specific tip to follow. User can swipe up for more info at any point.")
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
