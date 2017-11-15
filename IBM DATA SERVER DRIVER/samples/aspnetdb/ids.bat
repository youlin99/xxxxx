DROP TABLE aspnet_Applications;

CREATE TABLE aspnet_Applications(
    ApplicationName VARCHAR(255) NOT NULL,
    LoweredApplicationName VARCHAR(255) NOT NULL,
    ApplicationId SERIAL NOT NULL,
    Description VARCHAR(255),
    UNIQUE(ApplicationName),
    UNIQUE(LoweredApplicationName),
    PRIMARY KEY(ApplicationId)
);

DROP TABLE aspnet_Users;

CREATE TABLE aspnet_Users(
    ApplicationId INT NOT NULL,
    UserId SERIAL NOT NULL,
    UserName VARCHAR(255) NOT NULL,
    LoweredUserName VARCHAR(255) NOT NULL,
    MobileAlias VARCHAR(16) DEFAULT NULL,
    IsAnonymous SMALLINT DEFAULT 0 NOT NULL,
    LastActivityDate DATETIME YEAR TO FRACTION(5) NOT NULL,
    UNIQUE(ApplicationId,LoweredUserName),
    PRIMARY KEY(UserId),
    FOREIGN KEY (ApplicationId) REFERENCES aspnet_Applications(ApplicationId)
);

DROP TABLE aspnet_Membership;

CREATE TABLE aspnet_Membership(
    ApplicationId INT NOT NULL,
    UserId INT NOT NULL,
    Password VARCHAR(128) NOT NULL,
    PasswordFormat INTEGER DEFAULT 0 NOT NULL,
    PasswordSalt VARCHAR(128) NOT NULL,
    MobilePIN VARCHAR(16),
    Email VARCHAR(255),
    LoweredEmail VARCHAR(255),
    PasswordQuestion VARCHAR(255),
    PasswordAnswer VARCHAR(128),
    IsApproved SMALLINT NOT NULL,
    IsLockedOut SMALLINT DEFAULT 0 NOT NULL,
    CreateDate DATETIME YEAR TO FRACTION(5) NOT NULL,
    LastLoginDate DATETIME YEAR TO FRACTION(5) NOT NULL,
    LastPasswordChangedDate DATETIME YEAR TO FRACTION(5) NOT NULL,
    LastLockoutDate DATETIME YEAR TO FRACTION(5) NOT NULL,
    FailedPwdAtmptCount INTEGER DEFAULT 0 NOT NULL,
    FailedPwdAtmptWinStart DATETIME YEAR TO FRACTION(5) NOT NULL,
    FailedPwdAnsAtmptCount INTEGER DEFAULT 0 NOT NULL,
    FailedPwdAnsAtmptWinStart DATETIME YEAR TO FRACTION(5) NOT NULL,
    Comment CLOB,
    PRIMARY KEY(UserId),
    FOREIGN KEY (UserID) REFERENCES aspnet_Users(UserId),
    FOREIGN KEY (ApplicationId) REFERENCES aspnet_Applications(ApplicationId)
);

DROP TABLE aspnet_Paths;

CREATE TABLE aspnet_Paths(
    ApplicationId INT NOT NULL,
    PathId SERIAL NOT NULL,
    Path VARCHAR(255) NOT NULL,
    LoweredPath VARCHAR(255) NOT NULL,
    UNIQUE(ApplicationId, LoweredPath),
    PRIMARY KEY(PathId),
    FOREIGN KEY (ApplicationId) REFERENCES aspnet_Applications(ApplicationId)
);

DROP TABLE aspnet_PersonalizationAllUsers;

CREATE TABLE aspnet_PersonalizationAllUsers(
    PathId INT NOT NULL,
    PageSettings BLOB NOT NULL,
    LastUpdatedDate DATETIME YEAR TO FRACTION(5) NOT NULL,
    FOREIGN KEY (PathId) REFERENCES aspnet_Paths(PathId)
);

DROP TABLE aspnet_PersonalizationPerUser;

CREATE TABLE aspnet_PersonalizationPerUser(
    Id SERIAL NOT NULL,
    PathId INT  NOT NULL,
    UserId INT  NOT NULL,
    PageSettings BLOB NOT NULL,
    LastUpdatedDate DATETIME YEAR TO FRACTION(5) NOT NULL,
    UNIQUE(PathId,UserId),
    PRIMARY KEY(Id),
    FOREIGN KEY (UserID) REFERENCES aspnet_Users(UserId),
    FOREIGN KEY (PathId) REFERENCES aspnet_Paths(PathId)
);

DROP TABLE aspnet_Profile;

CREATE TABLE aspnet_Profile(
    UserId INT NOT NULL,
    PropertyNames CLOB NOT NULL,
    PropertyValuesString CLOB NOT NULL,
    PropertyValuesBinary BLOB NOT NULL,
    LastUpdatedDate DATETIME YEAR TO FRACTION(5) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES aspnet_Users(UserId),
    PRIMARY KEY(UserId)
);

DROP TABLE aspnet_Roles;

CREATE TABLE aspnet_Roles(
    ApplicationId INT NOT NULL,
    RoleId SERIAL NOT NULL,
    RoleName VARCHAR(255) NOT NULL,
    LoweredRoleName VARCHAR(255) NOT NULL,
    Description VARCHAR(255),
    UNIQUE(ApplicationId, LoweredRoleName),
    PRIMARY KEY(RoleId),
    FOREIGN KEY (ApplicationId) REFERENCES aspnet_Applications(ApplicationId)
);

DROP TABLE aspnet_SchemaVersions;

CREATE TABLE aspnet_SchemaVersions(
    Feature VARCHAR(128) NOT NULL,
    CompatibleSchemaVersion VARCHAR(128) NOT NULL,
    IsCurrentVersion SMALLINT NOT NULL,
    PRIMARY KEY(Feature, CompatibleSchemaVersion)
);

DROP TABLE aspnet_UsersInRoles;

CREATE TABLE aspnet_UsersInRoles(
    UserId INT NOT NULL,
    RoleId INT NOT NULL,
    PRIMARY KEY(UserId, RoleId),
    FOREIGN KEY (RoleId) REFERENCES aspnet_Roles(RoleId),
    FOREIGN KEY (UserID) REFERENCES aspnet_Users(UserId)
);

DROP TABLE aspnet_WebEvent_Events;

CREATE TABLE aspnet_WebEvent_Events(
    EventId CHAR(32) NOT NULL,
    EventTimeUtc DATETIME YEAR TO FRACTION(5) NOT NULL,
    EventTime DATETIME YEAR TO FRACTION(5) NOT NULL,
    EventType VARCHAR(255) NOT NULL,
    EventSequence DECIMAL(19,0) NOT NULL,
    EventOccurrence DECIMAL(19,0) NOT NULL,
    EventCode INTEGER NOT NULL,
    EventDetailCode INTEGER NOT NULL,
    Message LVARCHAR(1024),
    ApplicationPath VARCHAR(255),
    ApplicationVirtualPath VARCHAR(255),
    MachineName VARCHAR(255) NOT NULL,
    RequestUrl LVARCHAR(1024),
    ExceptionType VARCHAR(255),
    Details CLOB,
    PRIMARY KEY(EventId)
);

