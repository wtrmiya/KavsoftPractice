//
//  Alt1View.swift
//  Issue_1_ButtonWithBadgeinSwiftUI
//
//  Created by Wataru Miyakoshi on 2024/07/21.
//

import SwiftUI

struct Alt1View: View {
  @State private var value:Int = 0
  var body: some View {
    VStack {
      Button(action: {
        value += 1
      }, label: {
        Image(systemName: "bell")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 32, height: 32)
          .padding()
          .background(.gray)
          .foregroundStyle(.black)
          .clipShape(Circle())
          .overlay {
            NotificationCountView(value: $value)
          }
      })
      Button(action: {
        value = 0
      }, label: {
        Text("Reset count")
      })
    }
  }
}

#Preview {
  Alt1View()
}

struct NotificationCountView: View {
  @Binding var value: Int
  @State private var foreground: Color = .white
  @State private var background: Color = .red
  
  private let size = 16.0
  private let x = 40.0
  private let y = 20.0
  
  var body: some View {
    ZStack {
      Capsule()
        .fill(background)
        .frame(width: size * widthMultiplier(), height: size, alignment: .topTrailing)
        .position(x: x, y: y)
      if hasTwoOrLessDigits() {
        Text("\(value)")
          .foregroundStyle(foreground)
          .font(.caption)
          .position(x: x, y: y)
      } else {
        Text("99+")
          .foregroundStyle(foreground)
          .font(.caption)
          .frame(width: size * widthMultiplier(), height: size, alignment: .center)
          .position(x: x, y: y)
      }
    }
    .opacity(value == 0 ? 0 : 1)
  }
  
  private func hasTwoOrLessDigits() -> Bool {
    return value < 100
  }
  
  private func widthMultiplier() -> Double {
    if value < 10 {
      return 1.0
    } else if value < 100 {
      return 1.5
    } else {
      return 2.0
    }
  }
}
