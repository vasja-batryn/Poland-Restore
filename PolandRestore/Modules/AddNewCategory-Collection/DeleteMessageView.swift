//
//  DeleteMessageView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct DeleteMessageView: View {
    @Binding var isPresented: Bool
    let onTapYes: () -> Void
    
    var body: some View {
        VStack {
            Button(action: { isPresented.toggle() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.primaryText)
                    .padding(7)
                    .background(Circle().fill(Color.primaryForeground))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            VStack(alignment: .center, spacing: 16.0) {
                Text("Do you want to Delete this category?")
                    .font(.system(size: 20, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primaryForeground)
                    
                Button(action: onTapYes) {
                    Text("Yes")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                }
                .frame(width: 125)
                .background {
                    Color.primaryForeground
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button(action: { isPresented.toggle() }) {
                    Text("No")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                }
                .frame(width: 125)
                .background {
                    Color.primaryForeground
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
            .padding(.top, -30)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.primaryText)
        )
        .padding(.horizontal, 35)
    }
}

#Preview {
    DeleteMessageView(isPresented: .constant(true), onTapYes: {})
}
