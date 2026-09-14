//
//  OIlSheetView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 06/09/2026.
//

import SwiftUI

struct OIlSheetView: View {
    var body: some View {
        VStack{
            Text("hello oil  sheet")
        }
        .onAppear{
            print("[VIEW] OilSheet Appear")
        }
    }
}

#Preview {
    OIlSheetView()
}
