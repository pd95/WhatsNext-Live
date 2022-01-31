//
//  EventRow.swift
//  WhatsNext
//
//  Created by Philipp on 31.01.22.
//

import SwiftUI
import EventKit

struct EventRow: View {
    let event: EKEvent

    var body: some View {
        HStack(spacing: 4) {
            Color(event.calendar.color).frame(maxWidth: 10)
            Text(event.title)
            Spacer()
            Text(eventDate)
        }
    }

    var eventDate: String {
        let isTodayOrTomorrow = Calendar.current.isDateInToday(event.startDate) || Calendar.current.isDateInTomorrow(event.startDate)
        if event.isAllDay {
            if isTodayOrTomorrow {
                return "all day"
            } else {
                return event.startDate.formatted(.dateTime.weekday(.wide))
            }
        } else {
            if isTodayOrTomorrow {
                return event.startDate.formatted(date: .omitted, time: .shortened)
            } else {
                return event.startDate.formatted(.dateTime.weekday(.wide).hour().minute())
            }
        }
    }
}
