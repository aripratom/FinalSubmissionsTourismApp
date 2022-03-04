//
//  AboutView.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack {
                image
                VStack{
                    content
                    spacer
                }.padding()
            }.navigationBarTitle(Text("About"), displayMode: .large)
        }
    }

}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

extension AboutView {
    var spacer: some View {
      Spacer()
    }
    
    var image: some View {
        Image("aria")
            .resizable()
            .scaledToFit()
    }

    func headerTitle(_ title: String) -> some View {
      return Text(title)
        .font(.headline)
    }

    var description: some View {
        Text(Strings.aboutMe())
        .font(.system(size: 15))
    }
    
    var content: some View {
      VStack(alignment: .leading, spacing: 0) {
        headerTitle("Aria Pratomo")
          .padding([.top, .bottom])
        description
      }
    }
}

