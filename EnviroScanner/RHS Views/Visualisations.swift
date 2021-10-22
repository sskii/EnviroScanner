//
//  Visualisations.swift
//  EnviroScanner
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct Visualisations: View {
	
	@State var currentVisualisation: Int = 1
	
    var body: some View {
		VStack{
			VisualisationContainer(currentVisualisation: $currentVisualisation)
			Spacer()
			
			CompetitiveVisualisation()
				.frame(maxWidth: .infinity, maxHeight: 70)
		}
    }
}

struct VisualisationContainer: View {
	
	@Binding var currentVisualisation: Int

	var body: some View {
		PagerView(pageCount: 3, currentIndex: $currentVisualisation) {
			ZStack {
				Color.red
				Text("Area for visualisation 1")
			}
			ZStack {
				GeometryReader { geo in
					Image("vis2")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
				}
			}
			ZStack {
				Color.blue
				Text("Visualisation 3")
			}
		}
		.foregroundColor(.white)
		.frame(height: 250)
	}
	
}

struct CompetitiveVisualisation: View {
	
	
	
	var body: some View {
		
		GeometryReader { geo in
			
			VStack(spacing: 0) {
				
				HStack(spacing: 0) {
					
					Rectangle()
						.foregroundColor(Color("themeMed"))
						.frame(maxWidth: geo.size.width * 0.2)
					
					Rectangle()
						.foregroundColor(Color("averageMed"))
						.frame(maxWidth: geo.size.width * 0.5)
					
					Rectangle()
						.foregroundColor(Color("poorMed"))
						.frame(maxWidth: geo.size.width * 0.3)
					
				}
				
				HStack(spacing: 0) {
					
					Rectangle()
						.foregroundColor(Color("themeMed"))
						.frame(maxWidth: geo.size.width * 0.3)
					
					Rectangle()
						.foregroundColor(Color("averageMed"))
						.frame(maxWidth: geo.size.width * 0.45)
					
					Rectangle()
						.foregroundColor(Color("poorMed"))
						.frame(maxWidth: geo.size.width * 0.25)
					
				}
				
				ZStack {
					
					LeaderboardLabel(name: "You, Bob", percentage: 0.3, geo: geo)
					LeaderboardLabel(name: "Dylan", percentage: 0.6, geo: geo)
					
				}.padding(.bottom, 8)
				
			}
			
		}
		
	}
	
}

struct LeaderboardLabel: View {
	
	let name: String
	let percentage: CGFloat
	var geo: GeometryProxy
	
	var body: some View {
		
		HStack {
			Image(systemName: "arrow.turn.left.up")
			Text(name)
		}
		.background(.white)
		.frame(maxWidth: geo.size.width * (1 - percentage) + 8 /* offset by half of arrow width */, alignment: .leading)
		.frame(maxWidth: .infinity, alignment: .trailing)
		
	}
	
}


struct Visualisations_Previews: PreviewProvider {
    static var previews: some View {
        Visualisations()
    }
}
