USE master;
GO
CREATE DATABASE FieldAgent;
GO
USE FieldAgent;
GO
CREATE TABLE Agency (
 AgencyId int primary key identity(1,1),
 ShortName nvarchar(25) not null,
 LongName nvarchar(255) null
)
GO
CREATE TABLE [Location] (
 LocationId int primary key identity(1,1),
 AgencyId int not null foreign key references Agency(AgencyId),
 LocationName nvarchar(50) not null,
 Street1 nvarchar(50) not null,
 Street2 nvarchar(50) null,
 City nvarchar(50) not null,
 PostalCode nvarchar(15) not null,
 CountryCode varchar(5) not null
)
GO
CREATE TABLE Mission (
 MissionId int primary key identity(1,1),
 AgencyId int not null foreign key references Agency(AgencyId),
 CodeName nvarchar(50) not null,
 StartDate datetime2 not null,
 ProjectedEndDate datetime2 not null,
 ActualEndDate datetime2,
 OperationalCost decimal(10,2),
 Notes ntext null
)
GO
CREATE TABLE Agent(
 AgentId int primary key identity(1,1),
 FirstName nvarchar(50) not null,
 LastName nvarchar(50) not null,
 DateOfBirth datetime2 not null,
 Height decimal(5,2) not null
)
GO
CREATE TABLE Alias (
 AliasId int primary key identity(1,1),
 AgentId int not null foreign key references Agent(AgentId),
 AliasName nvarchar(50),
 InterpolId UNIQUEIDENTIFIER null,
 Persona ntext null
)
GO
CREATE TABLE MissionAgent (
 MissionId int not null foreign key references Mission(MissionId),
 AgentId int not null foreign key references Agent(AgentId),
 CONSTRAINT PK_MissionAgent PRIMARY KEY (MissionId, AgentId)
)
GO
CREATE TABLE SecurityClearance(
 SecurityClearanceId int primary key identity(1,1),
 SecurityClearanceName varchar(50) not null
)
GO
CREATE TABLE AgencyAgent (
 AgencyId int not null foreign key references Agency(AgencyId),
 AgentId int not null foreign key references Agent(AgentId),
 SecurityClearanceId int not null foreign key references SecurityClearance(SecurityClearanceId),
 BadgeId UNIQUEIDENTIFIER not null,
 ActivationDate datetime2 not null,
 DeactivationDate datetime2 null,
 IsActive bit not null default(1)
)
GO


drop table SecurityClearance
select * from SecurityClearance

Begin Tran
SET IDENTITY_INSERT SecurityClearance ON;  
GO 
insert into SecurityClearance (SecurityClearanceId, SecurityClearanceName)
Values 
(1, 'Omega'),
(2, 'Typhoon'),
(3, 'Winter'),
(4, 'Hollyrood')


select * from SecurityClearance
GO

SET IDENTITY_INSERT SecurityClearance OFF;  
GO
commit tran

GO
Begin Tran
SET IDENTITY_INSERT Agency ON;  
GO 
insert into Agency (AgencyId, ShortName, LongName)
Values 
(1, 'FBI', 'Federal burger igloo'),
(2, 'CIA', 'Cant I Apple'),
(3, 'FBC', 'Federal Bus Company'),
(4, 'SCP', 'Security Contain Protect')

select * from Agency
GO

SET IDENTITY_INSERT Agency OFF;  
GO
commit tran

GO
Begin Tran
SET IDENTITY_INSERT Agent ON;  
GO 
insert into Agent (AgentId, FirstName, LastName, DateOfBirth, Height)
Values 
(1, 'Mark', ' igloo', '1998/10/04', 6.8),
(2, 'Marky', ' Mark', '1989/09/09', 5.5),
(3, 'Markaroon', ' Lavender', '1992/01/24', 4.5),
(4, 'MarkMan', ' Ham', '1979/05/11', 7.5),
(5, 'Mary', ' Kay', '1989/05/11', 5.5),
(6, 'Marion', 'NotOtel', '1959/05/11', 6.5)

select * from Agent
GO

SET IDENTITY_INSERT Agent OFF;  
GO
commit tran

GO
Begin Tran
--SET IDENTITY_INSERT AgencyAgent ON;  

GO 
insert into AgencyAgent (AgencyId, AgentId, SecurityClearanceId, BadgeId, ActivationDate, DeactivationDate, IsActive)
Values 
(1, 1, 1, NEWID(), '2018/10/04','2020/10/04', 'True'),
(2, 2, 2,NEWID(),'2020/09/09', '2021/09/09', 'True'),
(1, 3, 3, NEWID(), '1992/01/24', '2002/01/24','False'),
(3, 4, 4, NEWID(), '1988/05/11', '1998/02/24','True'),
(2, 5,1,NEWID(),'1989/05/11','2000/07/11', 'False'),
(4, 6,2,NEWID(), '1959/05/11',null, 'True' )

select  * from AgencyAgent
GO

--SET IDENTITY_INSERT Agent OFF;  
GO
commit tran

GO
Begin Tran
SET IDENTITY_INSERT Alias ON;  
GO 
insert into Alias (AliasId,AgentId, AliasName, InterpolId, Persona)
Values 
(1, 1, 'GreenTurtle', NEWID(),' British Spy'),
(2,2, 'RedHawk', NEWID(), 'Pizza Spy'),
(3, 3,'Jessica wine', NEWID(),' Hamburglar'),
(4,4, 'Mark the Man', NEWID(),'David Bowie'),
(5, 5,'Larry scary ', NEWID(),'Groutcho'),
(6, 6,'Hansome Lansom',NEWID(), 'Russian Spy')

select * from Alias
GO

SET IDENTITY_INSERT Alias OFF;  
GO
commit tran

GO
Begin Tran
SET IDENTITY_INSERT Location ON;  
GO 
insert into Location (LocationId, AgencyId, LocationName, Street1, Street2, City, PostalCode, CountryCode)
Values 
(1, 1, 'Weenie Hut Juniors', '3444 Spongebob Dr','6567 Wowie st', 'Marfa', '77991', '01'),
(2,2, 'Pentagon', '3455 Peace St','6565 Sandy st', 'Denton', '119991', '01'),
(3, 3,'Octogon', '4222 Startrek Way','5565 Patrick st', 'Dallas', '894591', '01'),
(4,4, 'Septagon', '9321 Hello dr','6775 rick st', 'Austin', '876991', '01'),
(5, 3,'Nanogon', '3121 Macys st','6598 Pat st', 'D.C', '893891', '01'),
(6, 2,'Decagon', '3111 Kroger way','2334 Parick Blvd', 'Los Angeles', '923991', '01')

select * from Location
GO

SET IDENTITY_INSERT location OFF;  
GO
commit tran

GO
Begin Tran
SET IDENTITY_INSERT Mission ON;  
GO 
insert into Mission (MissionId, AgencyId, CodeName,Notes,StartDate,ProjectedEndDate,ActualEndDate, OperationalCost)
Values 
(1, 1, 'WayBackMachine', 'Be carful with the snakes', '2020/10/04','2020/10/28', '2021/07/13', 10000.00 ),
(2,2, 'Sloppy Joes', 'Its dangerous to go alone', '2019/04/16','2020/10/28', '2020/01/01', 600000.76),
(3, 3,'The big one', 'too much sand', '2017/05/04','2018/10/28', '2019/05/06', 654300.00 ),
(4,4, 'Pink Flamingo', 'ya need high charisma', '2003/06/06','2005/11/28', '2010/07/13', 89769.45 ),
(5, 3,'Dessert Pizza', 'not a good combination', '2018/10/04','2020/01/07', '2019/03/04', 8765345.12),
(6, 2,'Mk burrito', 'Avoid at all costs', '2020/07/26','2020/10/28', '2021/02/09', 1.00 )

select * from Mission
GO

SET IDENTITY_INSERT Mission OFF;  
GO
commit tran

GO
Begin Tran
--SET IDENTITY_INSERT MissionAgent ON;  
GO 
insert into MissionAgent (MissionId, AgentId)
Values 
(1,4),
(2,3),
(3,3),
(4,5),
(5,4),
(6,5)
select * from MissionAgent
GO

--SET IDENTITY_INSERT MissionAgent OFF;  
GO
rollback tran