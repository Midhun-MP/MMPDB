/*!
 * MMPDB.h
 * MMPDB
 * Created by Midhun on 5/5/15.
 * Copyright (c) 2015 Midhun. All rights reserved.
 * This class is used to create a database connection through which you can get column values from sqlite by mentioning column name instead of it's index
 */

#import <Foundation/Foundation.h>
#import "MMPDBResultSet.h"
#import "MMPDBConstants.h"

@interface MMPDB : NSObject

#pragma mark - Properties

/*!
 * Property for holding the database operation result
 */
@property (nonatomic, strong) MMPDBResultSet *resultSet;


#pragma mark - Utility

/*!
 * This method can be used for copying database from specified path to desired path
 * @param fromPath (NSString)  : Path from where the db need to be copied
 * @param toPath (NSString)    : Path to where the db need to be copied
 * @param shouldRewrite (BOOL) : Indicates whether need to rewrite or not, if the toPath already contains the db
 * @return BOOL                : Status of operation
 */
- (BOOL)copyDB:(NSString *)fromPath to:(NSString *)toPath reWrite:(BOOL)shouldRewrite;

#pragma mark - Database methods

/*!
 * Initializes database, this method opens a database connection
 * @param dbPath (NSString) : Path of database that need to be opened
 * @return BOOL             : Status of operation
 */
- (BOOL)initializeDBWithPath:(NSString *)dbPath;

/*!
 * Initializes database, this method opens a database connection
 * @param dbName (NSString) : Name of database that need to be opened
 * @return BOOL             : Status of operation
 */
- (BOOL)initializeDBWithName:(NSString *)dbName;

/*!
 * Closes the database. If this method called on an instance, need to initialize the db again for further operation
 * @return BOOL : Status of operation
 */
- (BOOL)closeDB;

/*!
 * Executes the query on initialized database
 * @param query (NSString) : Query that need to be executed
 * @return BOOL            : Status of operation
 */
- (BOOL)executeQuery:(NSString *)query;

@end


