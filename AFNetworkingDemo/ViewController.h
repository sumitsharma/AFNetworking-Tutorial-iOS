//
//  ViewController.h
//  AFNetworkingDemo
//
//  Created by Magnon International on 01/08/13.
//  Copyright (c) 2013 Sumit Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UITableView *tblView;
}

@property(nonatomic, retain) NSArray *movies;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@end
