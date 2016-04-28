//
//  Task.swift
//  Task
//
//  Created by Pralea Danut on 26/04/16.
//  Copyright © 2016 Parhelion Software. All rights reserved.
//

import Foundation



class Task {
    
    private var _date: String!
    private var _taskDescription: String?
    private var _priority: String!
    
    
    var date: String!{
        return _date
    }
    
    var taskDescription: String? {
        return _taskDescription
    }
    
    var taskPriority: String! {
        return _priority
    }
    
    init(date: String!, taskDescription: String!, priority: String!) {
        self._date = date
        self._taskDescription = taskDescription
        self._priority = priority
    }
    
    //var tasks = [Task]()
    
}