/*!
 * MMPDB.m
 * MMPDB
 * Created by Midhun on 5/5/15.
 * Copyright (c) 2015 Midhun. All rights reserved.
 * This class is used to create a database connection through which you can get column values from sqlite by mentioning column name instead of it's index
 */

#import "MMPDB.h"
#import <sqlite3.h>

@implementation MMPDB
{
    /*!
     * SQLite Database Object
     */
    sqlite3 *__db;
    
    /*!
     * Stores SQLite Prepared Statement
     */
    sqlite3_stmt *__stmt;
}

#pragma mark - Utility

/*!
 * This method can be used for copying database from specified path to desired path
 * @param fromPath (NSString)  : Path from where the db need to be copied
 * @param toPath (NSString)    : Path to where the db need to be copied
 * @param shouldRewrite (BOOL) : Indicates whether need to rewrite or not, if the toPath already contains the db
 * @return BOOL                : Status of operation
 */
- (BOOL)copyDB:(NSString *)fromPath to:(NSString *)toPath reWrite:(BOOL)shouldRewrite
{
    BOOL status = false;
    @try
    {
        NSFileManager *fileMngr = [NSFileManager defaultManager];
        NSError *error;
        
        // Checks whether from path contains the specified file
        if (![fileMngr fileExistsAtPath:fromPath])
        {
            status = [fileMngr copyItemAtPath:fromPath toPath:toPath error:&error];
        }
        
        if(shouldRewrite || ![fileMngr fileExistsAtPath:toPath])
        {
            status = [[NSFileManager defaultManager] removeItemAtPath:toPath error:&error];
            status = [fileMngr copyItemAtPath:fromPath toPath:toPath error:&error];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@ Exception in %s on %d due to %@",[exception name],__PRETTY_FUNCTION__,__LINE__,[exception reason]);
    }
    return status;
}

/*!
 * Creates database folder structure
 * @return BOOL : Operation Status
 */
- (BOOL)createDBFolder
{
    
    return [[NSFileManager defaultManager] createDirectoryAtPath:[self getDocDirPath] withIntermediateDirectories:YES attributes:nil error:nil];
}

/*!
 * Returns the document directory path of database
 * @return NSString : String that represents the document folder structure
 */
- (NSString *)getDocDirPath
{
    NSArray *paths               = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbFolder           = [documentsDirectory stringByAppendingPathComponent:kMMPDBFolderName];
    return dbFolder;
}

#pragma mark - Database methods

/*!
 * Initializes database, this method opens a database connection
 * @param dbPath (NSString) : Path of database that need to be opened
 * @return BOOL             : Status of operation
 */
- (BOOL)initializeDBWithPath:(NSString *)dbPath
{
    BOOL status = false;
    if (sqlite3_open([dbPath UTF8String], &__db) == SQLITE_OK)
    {
        status = true;
    }
    return status;
}

/*!
 * Initializes database, this method opens a database connection
 * @param dbName (NSString) : Name of database that need to be opened
 * @return BOOL             : Status of operation
 */
- (BOOL)initializeDBWithName:(NSString *)dbName
{
    [self createDBFolder];
    NSString *dbPath = [[self getDocDirPath] stringByAppendingPathComponent:dbName];
    [self copyDB:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName] to:dbPath reWrite:NO];
    return [self initializeDBWithPath:dbPath];
}

/*!
 * Closes the database. If this method called on an instance, need to initialize the db again for further operation
 * @return BOOL : Status of operation
 */
- (BOOL)closeDB
{
    BOOL status = false;
    if (sqlite3_close(__db) == SQLITE_OK)
    {
        status = true;
    }
    return status;
}

/*!
 * Executes the query on initialized database
 * @param query (NSString) : Query that need to be executed
 * @return BOOL            : Status of operation
 */
- (BOOL)executeQuery:(NSString *)query
{
    BOOL status = false;
    if (sqlite3_prepare(__db, [query UTF8String], -1, &__stmt, NULL) == SQLITE_OK)
    {
        status = true;
        

        _resultSet = [[MMPDBResultSet alloc] initWithPreparedStatement:__stmt andDB:__db];
    }
    return status;
}


@end

