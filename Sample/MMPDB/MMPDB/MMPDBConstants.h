/*!
 * MMPDBConstants.h
 * MMPDB
 * Created by Midhun on 5/12/15.
 * Copyright (c) 2015 Midhun. All rights reserved.
 * Constant class that holds the constants used in this library
 */

#import <Foundation/Foundation.h>

@interface MMPDBConstants : NSObject

/*!
 * Holds the MMPDB folder name
 */
extern NSString * const kMMPDBFolderName;

/*!
 * Holds the key for retrieving affected row count
 */
extern NSString * const kMMPDBAffectedRows;

/*!
 * Holds the key for retrieving inserted row id
 */
extern NSString * const kMMPDBInsertedRowId;
@end
