SELECT 
	c.[Company_Name],
    ct."Description",
	MAX (CASE WHEN t.Team_Role_RecID IN (8,13,14) THEN m.Member_ID ELSE NULL END) as TeamLead,
	MAX (CASE WHEN t.Team_Role_RecID = 52 THEN m.Member_ID ELSE NULL END) as "Service Manager",
	MAX (CASE WHEN t.Team_Role_RecID = 20 THEN m.Member_ID ELSE NULL END) as vCIO,
	MAX (CASE WHEN t.Team_Role_RecID = 1 THEN m.Member_ID ELSE NULL END) as CAM
FROM Company AS c
JOIN Company_Company_Type as cct ON cct.Company_RecID=c.Company_RecID
JOIN Company_Type as ct ON ct.Company_Type_RecID=cct.Company_Type_RecID
JOIN Company_Team as ctm ON ctm.Company_RecID=c.Company_RecID
JOIN Team_Role as t ON t.Team_Role_RecID=ctm.Team_Role_Recid
JOIN dbo."Member" as m ON m.Member_RecID = ctm.Member_RecID
WHERE ct.Company_Type_RecID IN (235,236,237)
Group BY c.Company_Name, ct.Description