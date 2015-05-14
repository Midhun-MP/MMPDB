# MMPDB
A custom SQLite wrapper for iOS.
Instead of specifying column index, can specify column name to get the data.


### Adding Library to Project

Add the Library folder to your project and import `MMPDBCommon.h` to the file where you want to use the library.

### Initialize database

- Initialize database with name : It'll copy the database from bundle to document directory

```
MMPDB *db = [[MMPDB alloc] init];
[db initializeDBWithName:@"MyDbName.sqlite"];
```

- Initialize database with path : You can initialize a database with it's path

```
MMPDB *db = [[MMPDB alloc] init];
NSString *fromPath = [[NSBundle mainBundle] pathForResource:@"Database" ofType:@"sqlite"];
NSString *toPath   = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, -1, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Database.sqlite"];
// Copies the databse from bundle to document directory
[db copyDB:fromPath to:toPath reWrite:NO];
[db initializeDBWithPath:toPath];
```

### Execute query

```
MMPDB *db = [[MMPDB alloc] init];
[db initializeDBWithName:@"MyDbName.sqlite"];
BOOL success = [db executeQuery:@"SELECT * FROM Contacts"];
```

### Getting Result

The result will be returned as an object of MMPDBResult (NSArray) containing NSDictionary.
Each dictionary object represents a row.

```
MMPDB *db = [[MMPDB alloc] init];
[db initializeDBWithName:@"MyDbName.sqlite"];
BOOL success = [db executeQuery:@"SELECT * FROM Contacts"];
if (success)
{
	MMPDBResultSet *dbResult = [db resultSet];
	NSLog(@"Name -> %@",dbResult[0][@"Name"]);
}
```
