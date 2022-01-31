//
//  ContentView.swift
//  WhatsNext
//
//  Created by Philipp on 31.01.22.
//

import EventKit
import SwiftUI

struct ContentView: View {
    @State private var eventStore = EKEventStore()
    @State private var storeAccessGranted = false

    @State private var todayEvents = [EKEvent]()
    @State private var tomorrowEvents = [EKEvent]()
    @State private var laterEvents = [EKEvent]()

    var body: some View {
        List {
            EventSection(name: "Today", events: todayEvents)
            EventSection(name: "Tomorrow", events: tomorrowEvents)
            EventSection(name: "Later", events: laterEvents)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            eventStore.requestAccess(to: .event) { granted, error in
                storeAccessGranted = granted

                if granted {
                    // Read events
                    todayEvents = events(from: Date.now, to: Date.endOfToday)
                    tomorrowEvents = events(from: Date.startOfTomorrow, to: Date.endOfTomorrow)
                    laterEvents = events(from: Date.startOfLater, to: Date.endOfLater)
                }
            }
        }
    }

    private func events(from: Date, to: Date) -> [EKEvent] {
        let predicate = eventStore.predicateForEvents(withStart: from, end: to, calendars: nil)
        return eventStore.events(matching: predicate)
    }
}
