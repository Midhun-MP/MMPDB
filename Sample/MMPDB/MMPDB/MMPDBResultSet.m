/*!
 * MMPDBResultSet.m
 * MMPDB
 * Created by Midhun on 5/12/15.
 * Copyright (c) 2015 Midhun. All rights reserved.
 * Holds the data of the each sqlite
 */

#import "MMPDBResultSet.h"
#import "MMPDBConstants.h"

@implementation MMPDBResultSet

#pragma mark - Initialization
/*!
 * Initializes result set with prepared SQLite statement
 * @param stmt (sqlite3_stmt) : Prepared SQLite statement
 * @param db (sqlite3)        : Database
 * @return MMPDBResultSet     : Instance of class
 */
- (instancetype)initWithPreparedStatement:(sqlite3_stmt *)stmt andDB:(sqlite3 *)db
{
    int colCount             = sqlite3_column_count(stmt);
    NSMutableArray *colNames = [[NSMutableArray alloc] init];
    const char *colName      = NULL;
    for (int index = 0; index < colCount; index++)
    {
        colName  = sqlite3_column_name(stmt, index);
        [colNames addObject:[NSString stringWithUTF8String:colName]];
    }
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        for (int colIndex = 0; colIndex < [colNames count]; colIndex++)
        {
            [tempDict setObject:[self getColValueFrom:stmt at:colIndex] forKey:colNames[colIndex]];
        }
        [tempArray addObject:tempDict];
    }
    if (!colCount)
    {
        int lastInsertedRow = (int)sqlite3_last_insert_rowid(db);
        int affectedRow     = sqlite3_changes(db);
        NSDictionary *dict  = @{kMMPDBAffectedRows  : @(affectedRow),
                                kMMPDBInsertedRowId : @(lastInsertedRow)
                                };
        [tempArray addObject:dict];
    }
    sqlite3_finalize(stmt);
    
    self = (MMPDBResultSet *)[[NSArray alloc] initWithArray:tempArray];
    return self;
}

#pragma mark - Utility

/*!
 * Returns the string value of specified column
 * @param stmt (sqlite3_stmt) : Prepared SQLite statement
 * @param colIndex (int)      : Index of Column
 * @return NSString           : String value contained in the specified column
 */
- (NSString *)getColValueFrom:(sqlite3_stmt *)stmt at:(int)colIndex
{
    const unsigned char *colValue = sqlite3_column_text(stmt, colIndex);
    NSString *result = @"";
    if (colValue != NULL)
    {
        result = [NSString stringWithUTF8String:(const char *)colValue];
    }
    return result;
}

@end
