//
//  Operation.swift
//  LBOperation
//
//  Created by boli on 16/11/23.
//  Copyright © 2016年 boli. All rights reserved.
//

import Foundation

/*
 Operation 是基于GCD实现的，封装了一些更为简单实用的功能，
 */

class MyOperationQueue {
    
    var queue = OperationQueue()
    
    /*
     Operation常用操作，创建队列，设置最大并发数
     */
    func queueTest() {
        //设置最大并发数
        queue.maxConcurrentOperationCount = 2
        
        //当operation有多个任务时会自动分配多个线程并发执行
        //如果只有一个任务，会自动在主线程同步执行
        let operation = BlockOperation{
            print("doSomething 1 \(Thread.current)")
        }
        
        // 添加更多操作
        operation.addExecutionBlock {
            print("doSomething 2 \(Thread.current)")
        }
        
//        operation.start()
        
        //添加到队列中的operation将自动异步执行
        queue.addOperation(operation)
        queue.addOperation { 
            print("doSomething 3 \(Thread.current)")
        }
    }
    
    func test10() {
        queue.maxConcurrentOperationCount = 3
        for index in 1...10 {
            let operation = BlockOperation{
                let time = arc4random() % 3
                sleep(time)
                print("doSomething \(index) sleep\(time) \(Thread.current)")
            }
            queue.addOperation(operation)
        }
    }

    /*
     Operation 操作依赖
     */
    func dependencyAction() {
        let operationA = BlockOperation{
            print("A")
        }
        let operationB = BlockOperation{
            print("B")
        }
        //B等待A执行完后才执行
        operationA.addDependency(operationB)
        
        queue.addOperation(operationA)
        queue.addOperation(operationB)
    }
    
    /*
     Operation 监听操作，
     */
    func operationCompletion() {
        let operation = BlockOperation{
            print("operation completion")
        }
        operation.completionBlock = doSomething
        queue.addOperation(operation)
    }
    
    func doSomething() {
        print("任务完成了")
    }
    
    /*
     Operation 线程通信
     */
    func action4() {
        queue.addOperation { 
            print("子线程：\(Thread.current)")
            
            OperationQueue.main.addOperation({ 
                print("主线程：\(Thread.current)")
            })
        }
    }
    
}


/*
 默认情况下，一个NSOperation开始执行之后，会一直执行任务到结束，就比如上面的DownloadOperation，默认会执行完main方法中的所有代码。
 Operation提供了一个cancel方法，可以取消当前的操作。
 如果是自定义NSOperation的话，需要手动处理这个取消事件。比如，一旦调用了cancel方法，应该马上终止main方法的执行，并及时回收一些资源。
 */
class MyOperation1: Operation {
    override func main() {
        if isCancelled {
            return;
        }
    }
    
    //在方法中要及时判断
    func downloadAction() {
        if isCancelled {
            return;
        }
    }
}



