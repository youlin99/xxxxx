--* [300000]MTK T-SQL Converter.  Version: 30Jan2008_1637

--| -- Extractor has started
--| -- Version 2.0.5.0, build: 30Jan2008_1637
--| -- Thu Mar 13 18:38:41 CDT 2008
--| -- Source ODBC Connection = aspnetdb
--| -- UserID = kanchana
--| -- include dependencies
--|  
--| use aspnetdb

--* [600034]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(8:1)-(8:12)No target server translation available, but statement has been taken into account

connect to aspnetdb;

--| SETUSER 'dbo'

--* [600034]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(11:1)-(11:13)No target server translation available, but statement has been taken into account


--| -- write user-defined types
--| CREATE TABLE [aspnet_Applications]
--|    ([ApplicationName] nvarchar(256)   NOT NULL ,
--|    [LoweredApplicationName] nvarchar(256)   NOT NULL ,
--|    [ApplicationId] uniqueidentifier DEFAULT (newid())  NOT NULL ,
--|    [Description] nvarchar(256)   NULL    )

--* [600138]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(15:1)-(19:42)Triggers are generated for complex defaults and check constraints in this table.
--* [300139]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(18:4)-(18:63)NULL constraint was removed because of the complex DEFAULT.
--* [600024]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(18:4)-(18:63)NOT NULL constraint is added because of a PRIMARY KEY or UNIQUE constraint.

DROP TABLE aspnet_Applications;

CREATE TABLE aspnet_Applications(
    ApplicationName VARGRAPHIC(256) NOT NULL,
    LoweredApplicationName VARGRAPHIC(256) NOT NULL,
    ApplicationId INT NOT NULL GENERATED AS IDENTITY,
    Description VARGRAPHIC(256)
);

--KP: ToDo
--CREATE TRIGGER "[aspnet_Applications]_trig" NO CASCADE BEFORE INSERT ON aspnet_Applications
--REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL 

--BEGIN ATOMIC
    
--| newid()

--    IF NEW.ApplicationId IS NULL THEN 
--        
--        SET NEW.ApplicationId = MSSQL.NEWID();
    
--    END IF;

--END;

--| ALTER TABLE [aspnet_Applications]   ADD  PRIMARY KEY ( [ApplicationId] ASC )

ALTER TABLE aspnet_Applications
 ADD  PRIMARY KEY(ApplicationId);

--| ALTER TABLE [aspnet_Applications]   ADD CONSTRAINT UQ__aspnet_Applicati__7F60ED59 UNIQUE ( [LoweredApplicationName] ASC )

ALTER TABLE aspnet_Applications
 ADD  CONSTRAINT UQ__aspnet_Applicati__7F60ED59 UNIQUE(LoweredApplicationName);

--| ALTER TABLE [aspnet_Applications]   ADD CONSTRAINT UQ__aspnet_Applicati__00551192 UNIQUE ( [ApplicationName] ASC )

ALTER TABLE aspnet_Applications
 ADD  CONSTRAINT UQ__aspnet_Applicati__00551192 UNIQUE(ApplicationName);

--| CREATE TABLE [aspnet_Membership]
--|    ([ApplicationId] uniqueidentifier   NOT NULL ,
--|    [UserId] uniqueidentifier   NOT NULL ,
--|    [Password] nvarchar(128)   NOT NULL ,
--|    [PasswordFormat] int DEFAULT ((0))  NOT NULL ,
--|    [PasswordSalt] nvarchar(128)   NOT NULL ,
--|    [MobilePIN] nvarchar(16)   NULL ,
--|    [Email] nvarchar(256)   NULL ,
--|    [LoweredEmail] nvarchar(256)   NULL ,
--|    [PasswordQuestion] nvarchar(256)   NULL ,
--|    [PasswordAnswer] nvarchar(128)   NULL ,
--|    [IsApproved] bit   NOT NULL ,
--|    [IsLockedOut] bit   NOT NULL ,
--|    [CreateDate] datetime   NOT NULL ,
--|    [LastLoginDate] datetime   NOT NULL ,
--|    [LastPasswordChangedDate] datetime   NOT NULL ,
--|    [LastLockoutDate] datetime   NOT NULL ,
--|    [FailedPasswordAttemptCount] int   NOT NULL ,
--|    [FailedPasswordAttemptWindowStart] datetime   NOT NULL ,
--|    [FailedPasswordAnswerAttemptCount] int   NOT NULL ,
--|    [FailedPasswordAnswerAttemptWindowStart] datetime   NOT NULL ,
--|    [Comment] ntext   NULL    )

DROP TABLE aspnet_Membership;

CREATE TABLE aspnet_Membership(
    ApplicationId INT NOT NULL,
    UserId INT NOT NULL,
    Password VARGRAPHIC(128) NOT NULL,
    PasswordFormat INTEGER DEFAULT 0 NOT NULL,
    PasswordSalt VARGRAPHIC(128) NOT NULL,
    MobilePIN VARGRAPHIC(16),
    Email VARGRAPHIC(256),
    LoweredEmail VARGRAPHIC(256),
    PasswordQuestion VARGRAPHIC(256),
    PasswordAnswer VARGRAPHIC(128),
    IsApproved SMALLINT NOT NULL,
    IsLockedOut SMALLINT DEFAULT 0 NOT NULL,
    CreateDate TIMESTAMP NOT NULL,
    LastLoginDate TIMESTAMP NOT NULL,
    LastPasswordChangedDate TIMESTAMP NOT NULL,
    LastLockoutDate TIMESTAMP NOT NULL,
    FailedPasswordAttemptCount INTEGER DEFAULT 0 NOT NULL,
    FailedPasswordAttemptWindowStart TIMESTAMP NOT NULL,
    FailedPasswordAnswerAttemptCount INTEGER DEFAULT 0 NOT NULL,
    FailedPasswordAnswerAttemptWindowStart TIMESTAMP NOT NULL,
    Comment DBCLOB(1G) NOT LOGGED
);

--| ALTER TABLE [aspnet_Membership]   ADD  PRIMARY KEY ( [UserId] ASC )

ALTER TABLE aspnet_Membership
 ADD  PRIMARY KEY(UserId);


--* [600138]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(58:1)-(62:46)Triggers are generated for complex defaults and check constraints in this table.
--* [300139]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(60:4)-(60:56)NULL constraint was removed because of the complex DEFAULT.
--* [600024]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(60:4)-(60:56)NOT NULL constraint is added because of a PRIMARY KEY or UNIQUE constraint.

DROP TABLE aspnet_Paths;

CREATE TABLE aspnet_Paths(
    ApplicationId INT NOT NULL,
    PathId INT NOT NULL GENERATED AS IDENTITY,
    Path VARGRAPHIC(256) NOT NULL,
    LoweredPath VARGRAPHIC(256) NOT NULL
);

--KP: ToDo
--CREATE TRIGGER "[aspnet_Paths]_trig" NO CASCADE BEFORE INSERT ON aspnet_Paths
--REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL 

--BEGIN ATOMIC
    
--| newid()
--
--    IF NEW.PathId IS NULL THEN 
--        
--        SET NEW.PathId = MSSQL.NEWID();
    
--    END IF;

--END!

--| ALTER TABLE [aspnet_Paths]   ADD  PRIMARY KEY ( [PathId] ASC )

ALTER TABLE aspnet_Paths
 ADD  PRIMARY KEY(PathId);

--| ALTER TABLE [aspnet_Paths]   ADD  UNIQUE ( [ApplicationId] ASC, [LoweredPath] ASC )

ALTER TABLE aspnet_Paths
 ADD  UNIQUE(ApplicationId,LoweredPath);

--| CREATE TABLE [aspnet_PersonalizationAllUsers]
--|    ([PathId] uniqueidentifier   NOT NULL ,
--|    [PageSettings] image   NOT NULL ,
--|    [LastUpdatedDate] datetime   NOT NULL    )

DROP TABLE aspnet_PersonalizationAllUsers;

CREATE TABLE aspnet_PersonalizationAllUsers(
    PathId INT NOT NULL,
    PageSettings BLOB(2G) NOT LOGGED NOT NULL,
    LastUpdatedDate TIMESTAMP NOT NULL
);

--| ALTER TABLE [aspnet_PersonalizationAllUsers]   ADD  PRIMARY KEY ( [PathId] ASC )

ALTER TABLE aspnet_PersonalizationAllUsers
 ADD  PRIMARY KEY(PathId);

--| CREATE TABLE [aspnet_PersonalizationPerUser]
--|    ([Id] uniqueidentifier DEFAULT (newid())  NOT NULL ,
--|    [PathId] uniqueidentifier   NULL ,
--|    [UserId] uniqueidentifier   NULL ,
--|    [PageSettings] image   NOT NULL ,
--|    [LastUpdatedDate] datetime   NOT NULL    )

--* [600138]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(81:1)-(86:45)Triggers are generated for complex defaults and check constraints in this table.
--* [300139]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(82:5)-(82:53)NULL constraint was removed because of the complex DEFAULT.
--* [600024]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(82:5)-(82:53)NOT NULL constraint is added because of a PRIMARY KEY or UNIQUE constraint.
--* [600024]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(83:4)-(83:35)NOT NULL constraint is added because of a PRIMARY KEY or UNIQUE constraint.
--* [600024]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(84:4)-(84:35)NOT NULL constraint is added because of a PRIMARY KEY or UNIQUE constraint.

DROP TABLE aspnet_PersonalizationPerUser;

CREATE TABLE aspnet_PersonalizationPerUser(
    Id INT NOT NULL GENERATED AS IDENTITY,
    PathId INT  NOT NULL,
    UserId INT  NOT NULL,
    PageSettings BLOB(2G) NOT LOGGED NOT NULL,
    LastUpdatedDate TIMESTAMP NOT NULL
);

--KP: ToDo
--CREATE TRIGGER "[aspnet_PersonalizationPerUser]_trig" NO CASCADE BEFORE INSERT ON --aspnet_PersonalizationPerUser
--REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL 

--BEGIN ATOMIC
    
--| newid()

--    IF NEW.Id IS NULL THEN 
        
--        SET NEW.Id = MSSQL.NEWID();
    
--    END IF;

--END!

--| ALTER TABLE [aspnet_PersonalizationPerUser]   ADD  PRIMARY KEY ( [Id] ASC )

ALTER TABLE aspnet_PersonalizationPerUser
 ADD  PRIMARY KEY(Id);

--| ALTER TABLE [aspnet_PersonalizationPerUser]   ADD  UNIQUE ( [PathId] ASC, [UserId] ASC )

ALTER TABLE aspnet_PersonalizationPerUser
 ADD  UNIQUE(PathId,UserId);

--| ALTER TABLE [aspnet_PersonalizationPerUser]   ADD CONSTRAINT --aspnet_PersonalizationPerUser_ncindex2 UNIQUE ( [UserId] ASC, [PathId] ASC )

ALTER TABLE aspnet_PersonalizationPerUser
 ADD  CONSTRAINT aspnet_PersonalizationPerUser_ncindex2 UNIQUE(UserId,PathId);

--| CREATE TABLE [aspnet_Profile]
--|    ([UserId] uniqueidentifier   NOT NULL ,
--|    [PropertyNames] ntext   NOT NULL ,
--|    [PropertyValuesString] ntext   NOT NULL ,
--|    [PropertyValuesBinary] image   NOT NULL ,
--|    [LastUpdatedDate] datetime   NOT NULL    )

DROP TABLE aspnet_Profile;

CREATE TABLE aspnet_Profile(
    UserId INT NOT NULL,
    PropertyNames DBCLOB(1G) NOT LOGGED NOT NULL,
    PropertyValuesString DBCLOB(1G) NOT LOGGED NOT NULL,
    PropertyValuesBinary BLOB(2G) NOT LOGGED NOT NULL,
    LastUpdatedDate TIMESTAMP NOT NULL
);

--| ALTER TABLE [aspnet_Profile]   ADD  PRIMARY KEY ( [UserId] ASC )

ALTER TABLE aspnet_Profile
 ADD  PRIMARY KEY(UserId);

--| CREATE TABLE [aspnet_Roles]
--|    ([ApplicationId] uniqueidentifier   NOT NULL ,
--|    [RoleId] uniqueidentifier DEFAULT (newid())  NOT NULL ,
--|    [RoleName] nvarchar(256)   NOT NULL ,
--|    [LoweredRoleName] nvarchar(256)   NOT NULL ,
--|    [Description] nvarchar(256)   NULL    )

--* [600138]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(109:1)-(114:42)Triggers are generated for complex defaults and check constraints in this table.
--* [300139]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(111:4)-(111:56)NULL constraint was removed because of the complex DEFAULT.
--* [600024]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(111:4)-(111:56)NOT NULL constraint is added because of a PRIMARY KEY or UNIQUE constraint.

DROP TABLE aspnet_Roles;

CREATE TABLE aspnet_Roles(
    ApplicationId INT NOT NULL,
    RoleId INT NOT NULL GENERATED AS IDENTITY,
    RoleName VARGRAPHIC(256) NOT NULL,
    LoweredRoleName VARGRAPHIC(256) NOT NULL,
    Description VARGRAPHIC(256)
);

--KP: ToDo
--CREATE TRIGGER "[aspnet_Roles]_trig" NO CASCADE BEFORE INSERT ON aspnet_Roles
--REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL 

--BEGIN ATOMIC
    
--| newid()

--    IF NEW.RoleId IS NULL THEN 
        
--        SET NEW.RoleId = MSSQL.NEWID();
    
--    END IF;

--END!

--| ALTER TABLE [aspnet_Roles]   ADD  PRIMARY KEY ( [RoleId] ASC )

ALTER TABLE aspnet_Roles
 ADD  PRIMARY KEY(RoleId);

--| ALTER TABLE [aspnet_Roles]   ADD  UNIQUE ( [ApplicationId] ASC, [LoweredRoleName] ASC )

ALTER TABLE aspnet_Roles
 ADD  UNIQUE(ApplicationId,LoweredRoleName);

--| CREATE TABLE [aspnet_SchemaVersions]
--|    ([Feature] nvarchar(128)   NOT NULL ,
--|    [CompatibleSchemaVersion] nvarchar(128)   NOT NULL ,
--|    [IsCurrentVersion] bit   NOT NULL    )

DROP TABLE aspnet_SchemaVersions;

CREATE TABLE aspnet_SchemaVersions(
    Feature VARGRAPHIC(128) NOT NULL,
    CompatibleSchemaVersion VARGRAPHIC(128) NOT NULL,
    IsCurrentVersion SMALLINT NOT NULL
);

--| ALTER TABLE [aspnet_SchemaVersions]   ADD  PRIMARY KEY ( [Feature] ASC, --[CompatibleSchemaVersion] ASC )

ALTER TABLE aspnet_SchemaVersions
 ADD  PRIMARY KEY(Feature,CompatibleSchemaVersion);

--| CREATE TABLE [aspnet_Users]
--|    ([ApplicationId] uniqueidentifier   NOT NULL ,
--|    [UserId] uniqueidentifier DEFAULT (newid())  NOT NULL ,
--|    [UserName] nvarchar(256)   NOT NULL ,
--|    [LoweredUserName] nvarchar(256)   NOT NULL ,
--|    [MobileAlias] nvarchar(16) DEFAULT (NULL)  NULL ,
--|    [IsAnonymous] bit DEFAULT ((0))  NOT NULL ,
--|    [LastActivityDate] datetime   NOT NULL    )

--* [600138]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(133:1)-(140:46)Triggers are generated for complex defaults and check constraints in this table.
--* [300139]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(135:4)-(135:56)NULL constraint was removed because of the complex DEFAULT.
--* [600024]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(135:4)-(135:56)NOT NULL constraint is added because of a PRIMARY KEY or UNIQUE constraint.

DROP TABLE aspnet_Users;

CREATE TABLE aspnet_Users(
    ApplicationId INT NOT NULL,
    UserId INT NOT NULL GENERATED AS IDENTITY,
    UserName VARGRAPHIC(256) NOT NULL,
    LoweredUserName VARGRAPHIC(256) NOT NULL,
    MobileAlias VARGRAPHIC(16) DEFAULT NULL,
    IsAnonymous SMALLINT DEFAULT 0 NOT NULL,
    LastActivityDate TIMESTAMP NOT NULL
);

--KP: ToDo
--CREATE TRIGGER "[aspnet_Users]_trig" NO CASCADE BEFORE INSERT ON aspnet_Users
--REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL 

--BEGIN ATOMIC
    
--| newid()

--    IF NEW.UserId IS NULL THEN 
        
--        SET NEW.UserId = MSSQL.NEWID();
    
--    END IF;

--END!

--| ALTER TABLE [aspnet_Users]   ADD  PRIMARY KEY ( [UserId] ASC )

ALTER TABLE aspnet_Users
 ADD  PRIMARY KEY(UserId);

--| ALTER TABLE [aspnet_Users]   ADD  UNIQUE ( [ApplicationId] ASC, [LoweredUserName] ASC )

ALTER TABLE aspnet_Users
 ADD  UNIQUE(ApplicationId,LoweredUserName);

--| CREATE TABLE [aspnet_UsersInRoles]
--|    ([UserId] uniqueidentifier   NOT NULL ,
--|    [RoleId] uniqueidentifier   NOT NULL    )

DROP TABLE aspnet_UsersInRoles;

CREATE TABLE aspnet_UsersInRoles(
    UserId INT NOT NULL,
    RoleId INT NOT NULL
);

--| ALTER TABLE [aspnet_UsersInRoles]   ADD  PRIMARY KEY ( [UserId] ASC, [RoleId] ASC )

ALTER TABLE aspnet_UsersInRoles
 ADD  PRIMARY KEY(UserId,RoleId);

--| CREATE TABLE [aspnet_WebEvent_Events]
--|    ([EventId] char(32)   NOT NULL ,
--|    [EventTimeUtc] datetime   NOT NULL ,
--|    [EventTime] datetime   NOT NULL ,
--|    [EventType] nvarchar(256)   NOT NULL ,
--|    [EventSequence] decimal(19,0)   NOT NULL ,
--|    [EventOccurrence] decimal(19,0)   NOT NULL ,
--|    [EventCode] int   NOT NULL ,
--|    [EventDetailCode] int   NOT NULL ,
--|    [Message] nvarchar(1024)   NULL ,
--|    [ApplicationPath] nvarchar(256)   NULL ,
--|    [ApplicationVirtualPath] nvarchar(256)   NULL ,
--|    [MachineName] nvarchar(256)   NOT NULL ,
--|    [RequestUrl] nvarchar(1024)   NULL ,
--|    [ExceptionType] nvarchar(256)   NULL ,
--|    [Details] ntext   NULL    )

DROP TABLE aspnet_WebEvent_Events;

CREATE TABLE aspnet_WebEvent_Events(
    EventId CHAR(32) NOT NULL GENERATED AS IDENTITY,
    EventTimeUtc TIMESTAMP NOT NULL,
    EventTime TIMESTAMP NOT NULL,
    EventType VARGRAPHIC(256) NOT NULL,
    EventSequence DECIMAL(19,0) NOT NULL,
    EventOccurrence DECIMAL(19,0) NOT NULL,
    EventCode INTEGER NOT NULL,
    EventDetailCode INTEGER NOT NULL,
    Message VARGRAPHIC(1024),
    ApplicationPath VARGRAPHIC(256),
    ApplicationVirtualPath VARGRAPHIC(256),
    MachineName VARGRAPHIC(256) NOT NULL,
    RequestUrl VARGRAPHIC(1024),
    ExceptionType VARGRAPHIC(256),
    Details DBCLOB(1G) NOT LOGGED
);

--| ALTER TABLE [aspnet_WebEvent_Events]   ADD  PRIMARY KEY ( [EventId] ASC )

ALTER TABLE aspnet_WebEvent_Events
 ADD  PRIMARY KEY(EventId);

CREATE TABLE SiteMap (
    ID          int] NOT NULL,
    Title       varchar(32),
    Description varchar(512),
    Url         varchar(512),
    Roles       varchar(512),
    Parent      int
);

--KP: Sysdiagrams not needed
--| CREATE TABLE [sysdiagrams]
--|    ([name] sysname   NOT NULL ,
--|    [principal_id] int   NOT NULL ,
--|    [diagram_id] int   IDENTITY ,
--|    [version] int   NULL ,
--|    [definition] varbinary(-1)   NULL    )

--* [200002]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(184:26)-(184:25)Unexpected syntax -- not translated.


--| ALTER TABLE [sysdiagrams]   ADD  PRIMARY KEY ( [diagram_id] ASC )

--* [200011]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(187:13)-(187:25)Reference to unknown object: [sysdiagrams]

--ALTER TABLE [sysdiagrams]
-- ADD  PRIMARY KEY([diagram_id])!

--| ALTER TABLE [sysdiagrams]   ADD CONSTRAINT UK_principal_name UNIQUE ( [principal_id] ASC, [name] ASC )

--* [200011]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(189:13)-(189:25)Reference to unknown object: [sysdiagrams]

--ALTER TABLE [sysdiagrams]
-- ADD  UNIQUE([principal_id],[name])!

--| CREATE VIEW [dbo].[vw_aspnet_Applications]
--|   AS SELECT [dbo].[aspnet_Applications].[ApplicationName], [dbo].[aspnet_Applications].[LoweredApplicationName], [dbo].[aspnet_Applications].[ApplicationId], [dbo].[aspnet_Applications].[Description]
--|   FROM [dbo].[aspnet_Applications]

CREATE VIEW vw_aspnet_Applications
    AS SELECT aspnet_Applications.ApplicationName,
              aspnet_Applications.LoweredApplicationName,
              aspnet_Applications.ApplicationId,
              aspnet_Applications.Description
       FROM aspnet_Applications;

--| CREATE VIEW [dbo].[vw_aspnet_MembershipUsers]
--|   AS SELECT [dbo].[aspnet_Membership].[UserId],
--|             [dbo].[aspnet_Membership].[PasswordFormat],
--|             [dbo].[aspnet_Membership].[MobilePIN],
--|             [dbo].[aspnet_Membership].[Email],
--|             [dbo].[aspnet_Membership].[LoweredEmail],
--|             [dbo].[aspnet_Membership].[PasswordQuestion],
--|             [dbo].[aspnet_Membership].[PasswordAnswer],
--|             [dbo].[aspnet_Membership].[IsApproved],
--|             [dbo].[aspnet_Membership].[IsLockedOut],
--|             [dbo].[aspnet_Membership].[CreateDate],
--|             [dbo].[aspnet_Membership].[LastLoginDate],
--|             [dbo].[aspnet_Membership].[LastPasswordChangedDate],
--|             [dbo].[aspnet_Membership].[LastLockoutDate],
--|             [dbo].[aspnet_Membership].[FailedPasswordAttemptCount],
--|             [dbo].[aspnet_Membership].[FailedPasswordAttemptWindowStart],
--|             [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptCount],
--|             [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptWindowStart],
--|             [dbo].[aspnet_Membership].[Comment],
--|             [dbo].[aspnet_Users].[ApplicationId],
--|             [dbo].[aspnet_Users].[UserName],
--|             [dbo].[aspnet_Users].[MobileAlias],
--|             [dbo].[aspnet_Users].[IsAnonymous],
--|             [dbo].[aspnet_Users].[LastActivityDate]
--|   FROM [dbo].[aspnet_Membership] INNER JOIN [dbo].[aspnet_Users]
--|       ON [dbo].[aspnet_Membership].[UserId] = [dbo].[aspnet_Users].[UserId]

CREATE VIEW vw_aspnet_MembershipUsers
    AS SELECT aspnet_Membership.UserId,
              aspnet_Membership.PasswordFormat,
              aspnet_Membership.MobilePIN,
              aspnet_Membership.Email,
              aspnet_Membership.LoweredEmail,
              aspnet_Membership.PasswordQuestion,
              aspnet_Membership.PasswordAnswer,
              aspnet_Membership.IsApproved,
              aspnet_Membership.IsLockedOut,
              aspnet_Membership.CreateDate,
              aspnet_Membership.LastLoginDate,
              aspnet_Membership.LastPasswordChangedDate,
              aspnet_Membership.LastLockoutDate,
              aspnet_Membership.FailedPasswordAttemptCount,
              aspnet_Membership.FailedPasswordAttemptWindowStart,
              aspnet_Membership.FailedPasswordAnswerAttemptCount,
              aspnet_Membership.FailedPasswordAnswerAttemptWindowStart,
              aspnet_Membership.Comment,
              aspnet_Users.ApplicationId,
              aspnet_Users.UserName,
              aspnet_Users.MobileAlias,
              aspnet_Users.IsAnonymous,
              aspnet_Users.LastActivityDate
       FROM aspnet_Membership INNER JOIN 
              aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId;

--| CREATE VIEW [dbo].[vw_aspnet_Profiles]
--|   AS SELECT [dbo].[aspnet_Profile].[UserId], [dbo].[aspnet_Profile].[LastUpdatedDate],
--|       [DataSize]=  DATALENGTH([dbo].[aspnet_Profile].[PropertyNames])
--|                  + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesString])
--|                  + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesBinary])
--|   FROM [dbo].[aspnet_Profile]

--* [700298]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(229:20)-(229:69)Call to function DATALENGTH is made with: incorrect number of arguments; invalid or unknown argument types.
--* [700298]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(230:20)-(230:76)Call to function DATALENGTH is made with: incorrect number of arguments; invalid or unknown argument types.
--* [700298]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(231:20)-(231:76)Call to function DATALENGTH is made with: incorrect number of arguments; invalid or unknown argument types.

CREATE VIEW vw_aspnet_Profiles
    AS SELECT aspnet_Profile.UserId,
              aspnet_Profile.LastUpdatedDate,
              LENGTH(aspnet_Profile.PropertyNames) + 
              LENGTH(aspnet_Profile.PropertyValuesString) +
              LENGTH(aspnet_Profile.PropertyValuesBinary) AS DataSize
       FROM aspnet_Profile;

--| CREATE VIEW [dbo].[vw_aspnet_Roles]
--|   AS SELECT [dbo].[aspnet_Roles].[ApplicationId], [dbo].[aspnet_Roles].[RoleId], --[dbo].[aspnet_Roles].[RoleName], [dbo].[aspnet_Roles].[LoweredRoleName], --[dbo].[aspnet_Roles].[Description]
--|   FROM [dbo].[aspnet_Roles]

CREATE VIEW vw_aspnet_Roles
    AS SELECT aspnet_Roles.ApplicationId,
              aspnet_Roles.RoleId,
              aspnet_Roles.RoleName,
              aspnet_Roles.LoweredRoleName,
              aspnet_Roles.Description
       FROM aspnet_Roles;

--| CREATE VIEW [dbo].[vw_aspnet_Users]
--|   AS SELECT [dbo].[aspnet_Users].[ApplicationId], [dbo].[aspnet_Users].[UserId], --[dbo].[aspnet_Users].[UserName], [dbo].[aspnet_Users].[LoweredUserName], --[dbo].[aspnet_Users].[MobileAlias], [dbo].[aspnet_Users].[IsAnonymous], --[dbo].[aspnet_Users].[LastActivityDate]
--|   FROM [dbo].[aspnet_Users]

CREATE VIEW vw_aspnet_Users
    AS SELECT aspnet_Users.ApplicationId,
              aspnet_Users.UserId,
              aspnet_Users.UserName,
              aspnet_Users.LoweredUserName,
              aspnet_Users.MobileAlias,
              aspnet_Users.IsAnonymous,
              aspnet_Users.LastActivityDate
       FROM aspnet_Users;

--| CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
--|   AS SELECT [dbo].[aspnet_UsersInRoles].[UserId], [dbo].[aspnet_UsersInRoles].[RoleId]
--|   FROM [dbo].[aspnet_UsersInRoles]

CREATE VIEW vw_aspnet_UsersInRoles
    AS SELECT aspnet_UsersInRoles.UserId,
              aspnet_UsersInRoles.RoleId
       FROM aspnet_UsersInRoles;

--| CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
--|   AS SELECT [dbo].[aspnet_Paths].[ApplicationId], [dbo].[aspnet_Paths].[PathId], --[dbo].[aspnet_Paths].[Path], [dbo].[aspnet_Paths].[LoweredPath]
--|   FROM [dbo].[aspnet_Paths]

CREATE VIEW vw_aspnet_WebPartState_Paths
    AS SELECT aspnet_Paths.ApplicationId,
              aspnet_Paths.PathId,
              aspnet_Paths.Path,
              aspnet_Paths.LoweredPath
       FROM aspnet_Paths;

--| CREATE VIEW [dbo].[vw_aspnet_WebPartState_Shared]
--|   AS SELECT [dbo].[aspnet_PersonalizationAllUsers].[PathId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationAllUsers].[PageSettings]), [dbo].[aspnet_PersonalizationAllUsers].[LastUpdatedDate]
--|   FROM [dbo].[aspnet_PersonalizationAllUsers]

--* [700298]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(256:73)-(256:137)Call to function DATALENGTH is made with: incorrect number of arguments; invalid or unknown argument types.

CREATE VIEW vw_aspnet_WebPartState_Shared
    AS SELECT aspnet_PersonalizationAllUsers.PathId,
              LENGTH(aspnet_PersonalizationAllUsers.PageSettings) AS DataSize,
              aspnet_PersonalizationAllUsers.LastUpdatedDate
       FROM aspnet_PersonalizationAllUsers;

--| CREATE VIEW [dbo].[vw_aspnet_WebPartState_User]
--|   AS SELECT [dbo].[aspnet_PersonalizationPerUser].[PathId], [dbo].[aspnet_PersonalizationPerUser].[UserId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationPerUser].[PageSettings]), [dbo].[aspnet_PersonalizationPerUser].[LastUpdatedDate]
--|   FROM [dbo].[aspnet_PersonalizationPerUser]

--* [700298]"C:\MTK\projects\aspnetdb\WizardExtractorOutput.src"(261:120)-(261:183)Call to function DATALENGTH is made with: incorrect number of arguments; invalid or unknown argument types.

CREATE VIEW vw_aspnet_WebPartState_User
    AS SELECT aspnet_PersonalizationPerUser.PathId,
              aspnet_PersonalizationPerUser.UserId,
              LENGTH(aspnet_PersonalizationPerUser.PageSettings) AS DataSize,
              aspnet_PersonalizationPerUser.LastUpdatedDate
       FROM aspnet_PersonalizationPerUser;

--KP: Ignore
