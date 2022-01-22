DROP DATABASE IF EXISTS TestingSystem_Candidate;
CREATE DATABASE TestingSystem_Candidate;
USE TestingSystem_Candidate;



CREATE TABLE `Candidate`(
id 						TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`FirstName` 			NVARCHAR(100) NOT NULL,
`LastName` 				NVARCHAR (100) NOT NULL,
`Phone` 				CHAR(11) NOT NULL,
`Email`   				VARCHAR(60) NOT NULL,
`password` 				VARCHAR(100) NOT NULL,	
ExpInYear 				TINYINT UNSIGNED ,
ProSkill  				ENUM ('JAVA' , 'GOLANG','SQL' ),
GraduationRank    ENUM ('GOOD','RATHER','MEDIUM','WEAK'),
Category		ENUM('EXPERIENCECANDIDATE', 'FRESHERCANDIDATE') NOT NULL

);





INSERT INTO `Candidate`(`FirstName`,	 `LastName`, 		`Phone`, 		`Email`, 				`password` ,   ExpInYear      ,	ProSkill		,GraduationRank	,`Category`					)                   
VALUES                	('FirstName1', 	 'LastName1',	'0988585568', 	'email1@viettel.com.vn',	 '123456aA',   	NULL		,		NULL		,	'GOOD'		,	'FRESHERCANDIDATE'			),				  	
						('FirstName2', 	 'LastName2',	'0988585565', 	'email2@viettel.com.vn',	 '123456aA',   	NULL		,		NULL		,	'RATHER'	,	'FRESHERCANDIDATE'			), 			 	
                        ('FirstName3', 	 'LastName3',	'0988585564', 	'email3@viettel.com.vn',	 '123456aA',   	NULL		,		NULL		,	'MEDIUM'	,		'FRESHERCANDIDATE'		),  			
                        ('FirstName4', 	 'LastName4',	'0988585569', 	'email4@viettel.com.vn',	 '123456aA',   	NULL		,		NULL		,	'WEAK'		,		'FRESHERCANDIDATE'		),   				
                        ('FirstName5', 	 'LastName5',	'0988585563', 	'email5@viettel.com.vn',	 '123456aA',   		5,				'JAVA'		 ,  NULL		,		 	'ExperienceCandidate' ),	
                        ('FirstName6', 	 'LastName6',	'0988585561', 	'email6@viettel.com.vn',	 '123456aA',   		5,				'GOLANG'	  ,  	NULL	,	'ExperienceCandidate'	),
                        ('FirstName7', 	 'LastName7',	'0988585562', 	'email7@viettel.com.vn',	 '123456aA',   		5,				'SQL'		   , 	NULL	,	 'ExperienceCandidate'	),
                        ('FirstName8', 	 'LastName8',	'0988585563', 	'email8@viettel.com.vn',	 '123456aA',   		5,				'GOLANG'	    ,	NULL	,	 'ExperienceCandidate'	);
                        
                        





                        
                        

