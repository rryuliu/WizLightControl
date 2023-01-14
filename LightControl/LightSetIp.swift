//
//  LightSetIp.swift
//  LightControl
//
//  Created by rryu on 2023/1/13.
//

import SwiftUI

struct LightSetIp: View {
    @Binding var settingsOpen: Bool
    @Binding var lightIp: String
    
    var body: some View {
        VStack {
            HStack {
                TextField("输入智能灯泡的IP",text: $lightIp)
                    .padding()
                    .frame(width:300, height: 40.0)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .background {
                        RoundedRectangle(cornerRadius: 5.0)
                            .fill(.tertiary)
                    }

            }
            .padding()
            
        }
        .padding()
        .frame(width: 400)
        
    }
}
