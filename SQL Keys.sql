select id,ClientID, LocationID, retiredassets.Name, LastContact, RetiredDate from retiredassets where YEARWEEK(LastContact, 1) = YEARWEEK(CURDATE(),1) AND LocationID !=1172;

select * from retiredassets;

show full processlist;

select * from Searches;


UPDATE `plugin_vm_hvVirtualMachines` `vm` LEFT JOIN `networkdevices` `d` ON `d` . `MAC` = `vm` . `MACAddress` SET `vm` . `GuestDeviceId` = `d` . `DeviceID` WHERE `d` . `DeviceID` IS NOT NULL;



SELECT `config` . `LocalLTShare` `LocalLTShare` , `config` . `SystemPassword` `SystemPassword` , `IFNULL` ( `pr1` . `value` , ? ) `FileServicePort` , `IFNULL` ( `lt_servers` . `WebAccessAddress` , `lt_servers` . `AppAccessAddress` ) `WebAccessAddress` FROM `config` LEFT JOIN `properties` `pr1` ON `pr1` . `Name` = ? LEFT JOIN `lt_servers` ON `lt_servers` . `Roles`;
select * from lt_scripts;
select * from v_extradataclients;

select * from runningscripts;
select count(*) from runningscripts;
select s.ScriptName,count(rs.ScriptID)  from runningscripts rs JOIN lt_scripts s ON s.ScriptID=rs.ScriptID GROUP By s.ScriptName ;
select s.ScriptName,count(rs.ScriptID)  from runningscripts rs JOIN lt_scripts s ON s.ScriptID=rs.ScriptID where rs.step=0 GROUP By s.ScriptName ;
select s.ScriptName,rs.step, count(rs.scriptID)  from runningscripts rs JOIN lt_scripts s ON s.ScriptID=rs.ScriptID where rs.step!=0 Group By rs.step;
select s.ScriptName,rs.start,count(rs.ScriptID)  from runningscripts rs JOIN lt_scripts s ON s.ScriptID=rs.ScriptID where rs.step = 0 GROUP By rs.start ;
select Count(*) from runningscripts where step=0;
select Count(*) from runningscripts where step!=0;

select * from pendingscripts ps;
select s.ScriptName,count(ps.ScriptID),ps.NextRun from pendingscripts ps JOIN lt_scripts s ON s.ScriptID=ps.ScriptID GROUP By ps.NextRun ;
select s.ScriptName,count(ps.ScriptID)  from pendingscripts ps JOIN lt_scripts s ON s.ScriptID=ps.ScriptID GROUP By s.ScriptName ;
Select 
	SUM(CASE when Priority=1 THEN 1 ELSE 0 END) as 'Priority Level 1', 
	SUM(CASE when Priority=2 THEN 1 ELSE 0 END) as 'Priority Level 2', 
    SUM(CASE when Priority=3 THEN 1 ELSE 0 END) as 'Priority Level 3', 
    SUM(CASE when Priority=4 THEN 1 ELSE 0 END) as 'Priority Level 4', 
	SUM(CASE when Priority=5 THEN 1 ELSE 0 END) as 'Priority Level 5', 
    SUM(CASE when Priority=6 THEN 1 ELSE 0 END) as 'Priority Level 6',
    SUM(CASE when Priority=7 THEN 1 ELSE 0 END) as 'Priority Level 7', 
	SUM(CASE when Priority=8 THEN 1 ELSE 0 END) as 'Priority Level 8', 
    SUM(CASE when Priority=9 THEN 1 ELSE 0 END) as 'Priority Level 9',
    SUM(CASE when Priority=10 THEN 1 ELSE 0 END) as 'Priority Level 10' 
    FROM pendingscripts;

select * from scheduledscripts ss;
select * from scheduledscripts ss where scriptID=6268;
select * from scheduledscripts ss where ss.SkipOffline=0;
select * from scheduledscripts ss where ss.ComputerID !=0;
select count(*) from scheduledscripts ss where ss.ComputerID !=0 AND ss.Disabled=0;
select s.ScriptName,count(ss.ScriptID)  from scheduledscripts ss JOIN lt_scripts s ON s.ScriptID=ss.ScriptID GROUP By s.ScriptName ;
select s.ScriptName,count(ss.ScriptID), ss.ScriptId  from scheduledscripts ss JOIN lt_scripts s ON s.ScriptID=ss.ScriptID where ss.ComputerID != 0 GROUP By s.ScriptName ;
select s.ScriptName,count(ss.ScriptID)  from scheduledscripts ss JOIN lt_scripts s ON s.ScriptID=ss.ScriptID where ss.SkipOffline = 0 GROUP By s.ScriptName ;
select s.ScriptName,count(ss.ScriptID), ss.ScriptId  from groupscripts ss JOIN lt_scripts s ON s.ScriptID=ss.ScriptID GROUP By s.ScriptName ;

select * from groupscripts; 
select * from groupscripts ss where ss.SkipOffline=0;
Delete from runningscripts where step=0;
Delete from scheduledScripts where disabled=1;
delete from groupscripts where scriptID=6268;
delete from scheduledscripts where scriptID=7152;

UPDATE scheduledScripts ss SET ss.Disabled = 1 WHERE ss.scriptID=6268;
UPDATE scheduledScripts ss SET ss.Priority = 5 WHERE ss.Priority =1;
UPDATE scheduledScripts ss SET ss.WakeOffline = 0 WHERE ss.WakeOffline =1;
UPDATE scheduledScripts ss SET ss.SkipOffline = 1 WHERE ss.SkipOffline =0;
UPDATE groupscripts ss SET ss.Priority = 5 WHERE ss.Priority =1;
UPDATE pendingscripts ss SET ss.Priority = 5 WHERE ss.Priority =1;
UPDATE groupscripts ss SET ss.SkipOffline = 1 WHERE ss.SkipOffline =0;

select * from lt_scripts where LocationScript=1;
select * from lt_scripts where scriptID=233;
UPDATE lt_scripts SET LocationScript = 0 where LocationScript=1;


select * from users where ClientID like '5,%';
select * from userclasses;

select * from users where Email like '%Ad%';



SELECT * FROM labtech.lt_scripts;

select  ENGINE, TABLE_NAME,Round( DATA_LENGTH/1024/1024) as data_length , round(INDEX_LENGTH/1024/1024) as index_length, round(DATA_FREE/ 1024/1024) as data_free from information_schema.tables  where  DATA_FREE > 0 and table_schema = 'labtech' order by data_free desc;

set global transaction_isolation = 'read-committed';

show events;

show create event plugin_table_rebuild;

show full processlist;

analyze table h_commands;

kill 21215;


select computerid, count(distinct OS) as os_cnt from hotfix group by computerid having os_cnt > 1;


drop table if exists plugins_new;
drop table if exists plugins_slow2;
CREATE TABLE plugins_new LIKE `plugins`;
INSERT INTO plugins_new SELECT * FROM `plugins`;
RENAME TABLE `plugins` TO plugins_slow2, plugins_new TO `plugins`;
   
      show full processlist;
      
      #INSERT INTO maintenancemodequeue SELECT "", computerid, NOW(), 120, 3, -1, "MySQL Upgrade" FROM computers;

      Select 
SUM(CASE when GroupID!=0 THEN 1 ELSE 0 END) as GroupID,
SUM(CASE when ClientID!=0 THEN 1 ELSE 0 END) as ClientID,
SUM(CASE when LocationID!=0 THEN 1 ELSE 0 END) as SiteID,
SUM(CASE when ComputerID!=0 THEN 1 ELSE 0 END) as ComputerID
FROM 
scheduledscripts
where Disabled=0;


select Count(*) from runningscripts where step=0;
select Count(*) from runningscripts where step!=0;

Select 
SUM(CASE when step=0 Then 1 ELSE 0 END) as StalledScripts,
SUM(CASE when step!=0 Then 1 else 0 end) as ActiveScripts
from 
runningscripts;

SELECT 
   computers.computerid as `Computer Id`,
   computers.name as `Computer Name`,
   clients.name as `Client Name`,
   computers.domain as `Computer Domain`,
   computers.username as `Computer User`,
   Services.Display as `Computer.Services.DisplayName`,
   IFNULL(IFNULL(edfAssigned1.Value,edfDefault1.value),'0') as `Computer - Client - Extra Data Field - Software Removal - ThreatLocker - Uninstall on Servers`,
   inv_operatingsystem.Server as `Computer.OS.IsServer`,
   IFNULL(IFNULL(edfAssigned2.Value,edfDefault2.value),'0') as `Computer - Extra Data Field - Reporting - Is Server`,
   IFNULL(IFNULL(edfAssigned3.Value,edfDefault3.value),'0') as `Computer - Extra Data Field - Software Removal - Threatlocker - Do Not Install`
FROM Computers 
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)
LEFT JOIN Clients ON (Computers.ClientId=Clients.ClientId)
LEFT JOIN Locations ON (Computers.LocationId=Locations.LocationID)
LEFT JOIN Services ON (services.ComputerId = Computers.ComputerId)
LEFT JOIN ExtraFieldData edfAssigned1 ON (edfAssigned1.id=Clients.ClientId and edfAssigned1.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='a37b2bb1-3dcc-4417-9480-d6927875376e'))
LEFT JOIN ExtraFieldData edfDefault1 ON (edfDefault1.id=0 and edfDefault1.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='a37b2bb1-3dcc-4417-9480-d6927875376e'))
LEFT JOIN ExtraFieldData edfAssigned2 ON (edfAssigned2.id=Computers.ComputerId and edfAssigned2.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='6f19a062-88cd-4c52-818f-9b5813e9dd39'))
LEFT JOIN ExtraFieldData edfDefault2 ON (edfDefault2.id=0 and edfDefault2.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='6f19a062-88cd-4c52-818f-9b5813e9dd39'))
LEFT JOIN ExtraFieldData edfAssigned3 ON (edfAssigned3.id=Computers.ComputerId and edfAssigned3.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='55ccab86-3fd9-4a4f-8b5c-96cc582d105f'))
LEFT JOIN ExtraFieldData edfDefault3 ON (edfDefault3.id=0 and edfDefault3.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='55ccab86-3fd9-4a4f-8b5c-96cc582d105f'))
 WHERE 
((((Instr(Services.Display,'ThreatLocker') > 0) AND (((((IFNULL(IFNULL(edfAssigned1.Value,edfDefault1.value),'0')<>0) AND (((inv_operatingsystem.Server<>0) OR (IFNULL(IFNULL(edfAssigned2.Value,edfDefault2.value),'0')<>0))))) OR (IFNULL(IFNULL(edfAssigned3.Value,edfDefault3.value),'0')<>0))))))



select *, count(*) as cnt from runningscripts join lt_scripts using (scriptid) group by scriptid order by cnt desc limit 10;


select lastcontact from computers where computerid = 66765;

select * from runningscripts where computerid = 60547;

select * from h_commands where computerid = 66765;

select * from pendingscripts;


select * from properties;


select * from scheduledscripts where SkipOffline = 0;


SELECT 
   computers.computerid as `Computer Id`,
   computers.name as `Computer Name`,
   clients.name as `Client Name`,
   computers.domain as `Computer Domain`,
   computers.username as `Computer User`,
   IFNULL(IFNULL(edfAssigned1.Value,edfDefault1.value),'0') as `Computer - Client - Extra Data Field - Software Removal - ThreatLocker - Uninstall on Servers`,
   inv_operatingsystem.Server as `Computer.OS.IsServer`,
   IFNULL(IFNULL(edfAssigned2.Value,edfDefault2.value),'0') as `Computer - Extra Data Field - Reporting - Is Server`,
   IFNULL(IFNULL(edfAssigned3.Value,edfDefault3.value),'0') as `Computer - Extra Data Field - Reporting - Is Workstation`,
   IFNULL(IFNULL(edfAssigned4.Value,edfDefault4.value),'0') as `Computer - Client - Extra Data Field - Software Removal - ThreatLocker - Uninstall on Workstations`,
   IFNULL(IFNULL(edfAssigned5.Value,edfDefault5.value),'0') as `Computer - Extra Data Field - Reporting - Is Workstation`,
   IFNULL(IFNULL(edfAssigned6.Value,edfDefault6.value),'0') as `Computer - Extra Data Field - Reporting - Is Server`
FROM Computers 
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)
LEFT JOIN Clients ON (Computers.ClientId=Clients.ClientId)
LEFT JOIN Locations ON (Computers.LocationId=Locations.LocationID)
LEFT JOIN ExtraFieldData edfAssigned1 ON (edfAssigned1.id=Clients.ClientId and edfAssigned1.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='a37b2bb1-3dcc-4417-9480-d6927875376e'))
LEFT JOIN ExtraFieldData edfDefault1 ON (edfDefault1.id=0 and edfDefault1.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='a37b2bb1-3dcc-4417-9480-d6927875376e'))
LEFT JOIN ExtraFieldData edfAssigned2 ON (edfAssigned2.id=Computers.ComputerId and edfAssigned2.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='6f19a062-88cd-4c52-818f-9b5813e9dd39'))
LEFT JOIN ExtraFieldData edfDefault2 ON (edfDefault2.id=0 and edfDefault2.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='6f19a062-88cd-4c52-818f-9b5813e9dd39'))
LEFT JOIN ExtraFieldData edfAssigned3 ON (edfAssigned3.id=Computers.ComputerId and edfAssigned3.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='7565f787-a305-4b50-8b9c-7790fc8030bb'))
LEFT JOIN ExtraFieldData edfDefault3 ON (edfDefault3.id=0 and edfDefault3.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='7565f787-a305-4b50-8b9c-7790fc8030bb'))
LEFT JOIN ExtraFieldData edfAssigned4 ON (edfAssigned4.id=Clients.ClientId and edfAssigned4.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='49434786-d78f-4684-934f-258ed14bdce4'))
LEFT JOIN ExtraFieldData edfDefault4 ON (edfDefault4.id=0 and edfDefault4.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='49434786-d78f-4684-934f-258ed14bdce4'))
LEFT JOIN ExtraFieldData edfAssigned5 ON (edfAssigned5.id=Computers.ComputerId and edfAssigned5.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='7565f787-a305-4b50-8b9c-7790fc8030bb'))
LEFT JOIN ExtraFieldData edfDefault5 ON (edfDefault5.id=0 and edfDefault5.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='7565f787-a305-4b50-8b9c-7790fc8030bb'))
LEFT JOIN ExtraFieldData edfAssigned6 ON (edfAssigned6.id=Computers.ComputerId and edfAssigned6.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='6f19a062-88cd-4c52-818f-9b5813e9dd39'))
LEFT JOIN ExtraFieldData edfDefault6 ON (edfDefault6.id=0 and edfDefault6.ExtraFieldId =(Select ExtraField.id FROM ExtraField WHERE LTGuid='6f19a062-88cd-4c52-818f-9b5813e9dd39'))
 WHERE 
((((((IFNULL(IFNULL(edfAssigned1.Value,edfDefault1.value),'0')<>0) AND (((inv_operatingsystem.Server<>0) OR (IFNULL(IFNULL(edfAssigned2.Value,edfDefault2.value),'0')<>0))) AND (IFNULL(IFNULL(edfAssigned3.Value,edfDefault3.value),'0')=0))) OR (((IFNULL(IFNULL(edfAssigned4.Value,edfDefault4.value),'0')<>0) AND (((inv_operatingsystem.Server=0) OR (IFNULL(IFNULL(edfAssigned5.Value,edfDefault5.value),'0')<>0))) AND (IFNULL(IFNULL(edfAssigned6.Value,edfDefault6.value),'0')=0))))))


flush hosts;
TRUNCATE TABLE performance_schema.host_cache;


select * from lt_servers;
select * from tickets limit 1;

select * from hotfix where computerid = 74274;

select count(distinct os) as cnt, computerid from hotfix group by computerid having cnt > 1;

select * from performance_schema.host_cache;
#TRUNCATE TABLE performance_schema.host_cache;

set global transaction_isolation = 'read-committed';

show full processlist;

kill 55940;

UPDATE hotfix h JOIN hotfixdata hfd ON h.hotfixid = hfd.ltproductkey SET h.cvssscore = hfd.cvss;

select @@global.wait_timeout;
select convert(concat((select count(*) from clients),':', (select count(*) from locations),':',(select count(*) from computers),':',(select count(*) from contacts),':',(select count(*) from h_commands),':',(select count(*) from h_computers),':',(Select Replace(RedirHostName,':',';') from config),': ') using latin1);

INSERT IGNORE INTO `v_extradata_swap-7b335a22-6761-11f0-95f4-00155d16d601` (`id`, `System Notification`) SELECT `TicketID`,
IFNULL(`efd`.`Value`, IFNULL(`efd2`.`Value`, '')) as `System Notification`
from `Tickets` `src` 
left join `ExtraFieldData` `efd` on `efd`.`ID`=`src`.`TicketID` and `efd`.`extrafieldid`=405 
left join `ExtraFieldData` `efd2` on `efd2`.`ID` = 0 and `efd2`.`extrafieldid`=405
Group by `src`.`TicketID`
ON DUPLICATE KEY UPDATE `System Notification`=VALUES(`System Notification`);

Update Tickets set Status=2,UpdateDate=Now() Where DueDate<=Now() and DueDate>StartedDate and Status=3;