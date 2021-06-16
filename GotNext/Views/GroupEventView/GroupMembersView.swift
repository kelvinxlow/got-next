//
//  GroupMembersView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-16.
//

import SwiftUI

struct GroupMembersView: View {
    enum Sizes: CGFloat {
        case imageSideLength = 40
    }
    
    var body: some View {
        Image(systemName: "person.crop.circle")
            .resizable()
            .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)    }
}

struct GroupMembersView_Previews: PreviewProvider {
    static var previews: some View {
        GroupMembersView()
    }
}
