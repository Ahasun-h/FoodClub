//
//  Reachability.swift
//  FoodClub
//
//  Created by Ahasun on 1/27/23.
//

import Network

protocol NetworkCheckObserver: class {
    func statusDidChange(status: NWPath.Status)
}

class Reachability {

    struct NetworkChangeObservation {
        weak var observer: NetworkCheckObserver?
    }

    private var monitor = NWPathMonitor()
    private static let _sharedInstance = Reachability()
    private var observations = [ObjectIdentifier: NetworkChangeObservation]()
    var currentStatus: NWPath.Status {
        get {
            return monitor.currentPath.status
        }
    }

    class func sharedInstance() -> Reachability {
        return _sharedInstance
    }

    init() {
        monitor.pathUpdateHandler = { [unowned self] path in
            for (id, observations) in self.observations {

                //If any observer is nil, remove it from the list of observers
                guard let observer = observations.observer else {
                    self.observations.removeValue(forKey: id)
                    continue
                }

                DispatchQueue.main.async(execute: {
                    observer.statusDidChange(status: path.status)
                })
            }
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }

    func addObserver(observer: NetworkCheckObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = NetworkChangeObservation(observer: observer)
    }

    func removeObserver(observer: NetworkCheckObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }

}
