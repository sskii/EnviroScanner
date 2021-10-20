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
		VisualisationContainer(currentVisualisation: $currentVisualisation)
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
				Color.green
				Text("Visualisation 2")
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


struct Visualisations_Previews: PreviewProvider {
    static var previews: some View {
        Visualisations()
    }
}
