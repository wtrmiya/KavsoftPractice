//
//  YouTubeWay.swift
//  Issue_1_ButtonWithBadgeinSwiftUI
//
//  Created by Wataru Miyakoshi on 2024/07/21.
//

import SwiftUI

struct YouTubeWay: View {
  @State private var count:Int = 0
  var body: some View {
    VStack {
      CustomButton(count: $count)
      Button(action: {
        count = 0
      }, label: {
        Text("Reset count")
      })
    }
  }
}

#Preview {
  YouTubeWay()
}

struct CustomButton: View {
  @Binding var count: Int
  var body: some View {
    ZStack {
      Button(action: {
        count += 1
      }, label: {
        Image(systemName: "bell")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 32, height: 32)
          .padding()
          .background(.gray)
          .foregroundStyle(.black)
          .clipShape(Circle())
      })
      if count != 0 {
        Text(count.description)
          .padding(5)
          .font(.caption)
          .background(.red)
          .foregroundColor(.white)
          .clipShape(Circle())
          .offset(x: 10, y: -15)
      }
    }
  }
}
