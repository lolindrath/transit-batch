import Foundation
import GTFS

print("GTFS to JSON Converter starting...")

// these should be inputs eventually and check them first
let path = "file:///Users/awilli232/personal/transit-batch/input"
let dest = "file:///Users/awilli232/personal/transit-batch/output"

do {
    // TODO: Write out config
    print("  Writing configs...")
    print("  Done writing configs.")

    print("  Reading gtfs...")
    let gtfs = try GTFS(path: path)
    print("  Done reading gtfs.")

    print("  Writing json...")

    let enc = JSONEncoder()

    // eh, this won't change much and I'm only dealing with one agency
    let agencies = try enc.encode(gtfs.agencies)
    try agencies.write(to: URL(string: dest + "/" + "agencies.json")!)

    // trips are trains and the trip_id maps into stop times for the times along the routes
    let trips = try enc.encode(gtfs.trips)
    try trips.write(to: URL(string: dest + "/" + "trips.json")!)

    // all the stops along the route, sequence looks useful and inbound/ outbound
    let stopTimes = try enc.encode(gtfs.stopTimes)
    try stopTimes.write(to: URL(string: dest + "/" + "stop_times.json")!)

    // stops are the individual stations and their ids and locations
    let stops = try enc.encode(gtfs.stops)
    try stops.write(to: URL(string: dest + "/" + "stops.json")!)

    // describes the path of the vehicle
    let shapes = try enc.encode(gtfs.shapes)
    try shapes.write(to: URL(string: dest + "/" + "shapes.json")!)

    // lists all the train lines
    let routes = try enc.encode(gtfs.routes)
    try routes.write(to: URL(string: dest + "/" + "routes.json")!)

    // has start and expire data times which could be useful
    let feedInfo = try enc.encode(gtfs.feedInformation)
    try feedInfo.write(to: URL(string: dest + "/" + "feed_info.json")!)

    // defines what days the service is available and dates shows exceptions - either added service or removed service
    let calendar = try enc.encode(gtfs.calendar)
    try calendar.write(to: URL(string: dest + "/" + "calendar.json")!)
    let calendarDates = try enc.encode(gtfs.calendarDates)
    try calendarDates.write(to: URL(string: dest + "/" + "calendar_dates.json")!)

    print("  Done writing json.")
} catch {
    print("ERR: \(error)")
}

print("GTFSRT----------\n")
//gtfsRT()

print("Done!")


func gtfsRT() {
    do {
        let gtfsRt = try TransitRealtime_FeedMessage(serializedData: Data(contentsOf: URL(string: "file:///Users/awilli232/Downloads/rtServiceAlerts-2023-12-05-trainview-issue.pb")!))
        print(gtfsRt)
    } catch {
        print("ERR: \(error)")
    }
}
