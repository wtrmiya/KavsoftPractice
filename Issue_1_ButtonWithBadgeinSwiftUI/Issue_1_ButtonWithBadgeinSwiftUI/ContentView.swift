//
//  ContentView.swift
//  Issue_1_ButtonWithBadgeinSwiftUI
//
//  Created by Wataru Miyakoshi on 2024/07/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          YouTubeWay()
        } label: {
          Text("YouTube way")
        }
        
        NavigationLink {
          Alt1View()
        } label: {
          Text("Alt 1: Medium")
        }
      }
      .listStyle(.plain)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
