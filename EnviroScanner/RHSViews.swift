//
//  RHSViews.swift
//  EnviroScanner
//
//  Views from the RHS of the Miro board
//  Sam's job
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

// the review scene
struct ReviewScene: View {
	
	@State var preferredVisualisation: Int = 1;
	@State var numUnlinkedScans: Int = 2;
	
	var body: some View {
		
		ScrollView {
			
			VStack(spacing: 16) {
				
				VisualisationContainer(currentVisualisation: $preferredVisualisation)
				
				// prompt to link scans, if there are any outstanding unliked scans
				if(numUnlinkedScans > 0) {
					UnrecognisedScansPrompt(count: $numUnlinkedScans)
				}
				
				SmallTip(title: "Sponsored tip", message: "Beach Road Milk is 10 mins away by bike and offers milk in reusable glass bottles. Tap to learn more.", cta: "+ 2 points—you'd get ahead of Bob!")
				
				HistorySummary()
			
			}.padding(16)
			
		}
		
	}
	
}

// depreciated code
/*
struct RHSViews: View {
    var body: some View {
		VStack {
			
			VStack{
				
				ScanPreview()
					.padding(16)
			
				ScanDetails()
					.padding(16)
				
			}
			.background(Color("lightGreen"))
		
			SmallTip(title: "Today's tip",
					 message: "Consider bringing a 2L plastic container to this afternoon’s Countdown shop to grab your oats from the bulk bin.",
					 cta: "+ 1 point increase to good products")
				.padding(16)
			
		}
    }
}
*/
 
struct RHSViews_Previews: PreviewProvider {
    static var previews: some View {
        ReviewScene()
    }
}
