/*!
 * MMPDBResultSet.h
 * MMPDB
 * Created by Midhun on 5/12/15.
 * Copyright (c) 2015 Midhun. All rights reserved.
 * Holds the data of the each sqlite 
 */

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface MMPDBResultSet : NSArray

/*!
 * Initializes result set with prepared SQLite statement
 * @param stmt (sqlite3_stmt) : Prepared SQLite statement
 * @param db (sqlite3)        : Database
 * @return MMPDBResultSet     : Instance of class
 */
- (instancetype)initWithPreparedStatement:(sqlite3_stmt *)stmt andDB:(sqlite3 *)db;
@end
