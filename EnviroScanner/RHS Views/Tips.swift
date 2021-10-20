//
//  Tips.swift
//  EnviroScanner
//
//  Created by Sam on 20/10/21.
//

import SwiftUI

struct Tips: View {
    var body: some View {
        SmallTip(title: "Tip example",
				 message: "You can create tips like this",
				 cta: "+ lots of features")
    }
}

struct SmallTip: View {
	
	var title: String = ""
	var message: String = ""
	var cta: String = ""
	
	var body: some View {
		
		StandardSection {
			
			if(title != "") {
				
				Text(title)
					.font(.headline)
				
			}
				
			if(message != "") {
				
				Text(message)
					.padding(.vertical, 2)
				
			}
			
			if(cta != "") {
				
				Text(cta)
					//.foregroundColor(Color("lightGreen"))
					.frame(maxWidth: .infinity, alignment: .trailing)
				
			}
			
		}
		
	}
	
}

struct Tips_Previews: PreviewProvider {
    static var previews: some View {
        Tips()
    }
}
