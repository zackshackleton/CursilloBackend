DROP DATABASE if exists CursilloDB;

CREATE DATABASE CursilloDB;

use CursilloDB;

CREATE TABLE PARISH (
  PARISH_ID               INTEGER         NOT NULL,
  PARISH_NAME             VARCHAR(50)    NOT NULL,
  STREET                  VARCHAR(50),
  CITY                    VARCHAR(50),
  STATE_NAME              VARCHAR(25),
  ZIPCODE                 VARCHAR(5),
  PHONE_NUMBER            VARCHAR(50)   NOT NULL,
  SPONSOR_NAME            VARCHAR(50), 
  NOTES                   VARCHAR(1000),

  CONSTRAINT PARISH_PK1 PRIMARY KEY (PARISH_ID)
);

CREATE TABLE INDIVIDUAL (
 INDIVIDUAL_ID        INTEGER           NOT NULL,
 FIRST_NAME           VARCHAR(50)      NOT NULL,
 LAST_NAME            VARCHAR(50)      NOT NULL,
 PREFERRED_NAME       VARCHAR(50),
 GENDER               VARCHAR(6)      NOT NULL,
 STREET               VARCHAR(50),
 CITY                 VARCHAR(50),
 STATE_NAME           VARCHAR(25),
 ZIP_CODE             VARCHAR(5),
 PHONE_NUMBER         VARCHAR(50)      NOT NULL,
 WORK_NUMBER          VARCHAR(50),
 EMAIL                VARCHAR(50),
 DOB                  DATE              NOT NULL,
 OCCUPATION           VARCHAR(50),
 IS_MARRIED           BOOLEAN           NOT NULL,
 SPOUSE_FIRST         VARCHAR(50),
 SPOUSE_LAST          VARCHAR(50),
 HAS_SPOUSE_ATTENDED  BOOLEAN           NOT NULL DEFAULT FALSE,
 IS_ACTIVE            BOOLEAN           NOT NULL DEFAULT TRUE,
 IS_LIVING            BOOLEAN           NOT NULL DEFAULT TRUE,
 PARISH_ID            INTEGER           NOT NULL,
 SPOUSE_ID            INTEGER,
CONSTRAINT CHK_INDIVIDUAL_GENDER CHECK (GENDER IN (‘Male’, ‘Female’, ‘Other’)),
 CONSTRAINT INDIVIDUAL_PK PRIMARY KEY(INDIVIDUAL_ID),
 CONSTRAINT INDIVIDUAL_FK1 FOREIGN KEY (PARISH_ID) REFERENCES PARISH(PARISH_ID) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT INDIVIDUAL_FK2 FOREIGN KEY (SPOUSE_ID) REFERENCES INDIVIDUAL(INDIVIDUAL_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE TEAM_MEMBER (
  TEAM_MEMBER_ID      INTEGER           NOT NULL,

  CONSTRAINT TEAM_MEMBER_PK PRIMARY KEY (TEAM_MEMBER_ID),
  CONSTRAINT TEAM_MEMBER_FK1 FOREIGN KEY (TEAM_MEMBER_ID) REFERENCES INDIVIDUAL(INDIVIDUAL_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CANDIDATE (
  CANDIDATE_ID        INTEGER           NOT NULL,

  CONSTRAINT CANDIDATE_PK PRIMARY KEY (CANDIDATE_ID),
  CONSTRAINT CANDIDATE_FK1 FOREIGN KEY (CANDIDATE_ID) REFERENCES INDIVIDUAL(INDIVIDUAL_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CURSILLO (
  CURSILLO_ID         INTEGER             NOT NULL,
  DESCRIPTION         VARCHAR(1000),
  GENDER              VARCHAR(6),
  START_DATE          DATE                NOT NULL,
  END_DATE            DATE                NOT NULL,
  NOTES               VARCHAR(1000),
  STREET              VARCHAR(50),
  CITY                VARCHAR(50),
  STATE_NAME          VARCHAR(25),
  ZIP_CODE            VARCHAR(5), 
 
CONSTRAINT CHK_CURSILLO_GENDER CHECK (GENDER IN (‘Male’, ‘Female’, ‘Other’)),
  CONSTRAINT CURSILLO_PK PRIMARY KEY (CURSILLO_ID)
);


CREATE TABLE PASTOR (
  PASTOR_ID               INTEGER         NOT NULL,
  PASTOR_FIRST            VARCHAR(50)    NOT NULL,
  PASTOR_LAST             VARCHAR(50)    NOT NULL,
  PARISH_ID               INTEGER         NOT NULL,
   
  CONSTRAINT PASTOR_PK PRIMARY KEY (PASTOR_ID),
  CONSTRAINT PASTOR_FK1 FOREIGN KEY (PARISH_ID) REFERENCES PARISH(PARISH_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TALK (
  TALK_ID                INTEGER          NOT NULL,
  DESCRIPTION            VARCHAR(1000),   
  TALK_NUMBER            INTEGER          NOT NULL,
  CURSILLO_ID            INTEGER          NOT NULL,
  INDIVIDUAL_ID          INTEGER          NOT NULL,

  CONSTRAINT TALK_PK PRIMARY KEY (TALK_ID),
  CONSTRAINT TALK_FK1 FOREIGN KEY (CURSILLO_ID) REFERENCES CURSILLO(CURSILLO_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT TALK_FK2 FOREIGN KEY (INDIVIDUAL_ID) REFERENCES INDIVIDUAL(INDIVIDUAL_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE TEAM (
  TEAM_ID             INTEGER             NOT NULL,
  DESCRIPTION         VARCHAR(1000),
  TEAM_NAME           VARCHAR(50)         NOT NULL,
  CURSILLO_ID         INTEGER             NOT NULL,
  CONSTRAINT TEAM_PK PRIMARY KEY(TEAM_ID),
  CONSTRAINT TEAM_FK1 FOREIGN KEY(CURSILLO_ID) REFERENCES CURSILLO(CURSILLO_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ROLE (
  ROLE_ID             INTEGER             NOT NULL,
  DESCRIPTION         VARCHAR(1000),
  ROLE_NAME           VARCHAR(25)        NOT NULL, 
  ROLE_NUMBER         INTEGER             NOT NULL,
  TEAM_ID             INTEGER             NOT NULL,

  CONSTRAINT ROLE_PK PRIMARY KEY (ROLE_ID),
  CONSTRAINT ROLE_FK1 FOREIGN KEY (TEAM_ID) REFERENCES TEAM(TEAM_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE TEAM_MEMBER_ROLE (
  TEAM_MEMBER_ID       INTEGER            NOT NULL,
  ROLE_ID              INTEGER            NOT NULL,

  CONSTRAINT TEAM_MEMBER_ROLE_PK PRIMARY KEY (TEAM_MEMBER_ID, ROLE_ID),
  CONSTRAINT TEAM_MEMBER_ROLE_FK1 FOREIGN KEY (TEAM_MEMBER_ID) REFERENCES TEAM_MEMBER(TEAM_MEMBER_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT TEAM_MEMBER_ROLE_FK2 FOREIGN KEY (ROLE_ID) REFERENCES ROLE(ROLE_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE INDIVIDUAL_CURSILLO (
  INDIVIDUAL_ID        INTEGER            NOT NULL,
  CURSILLO_ID          INTEGER            NOT NULL,

  CONSTRAINT INDIVIDUAL_CURSILLO_PK PRIMARY KEY (INDIVIDUAL_ID, CURSILLO_ID),
  CONSTRAINT INDIVIDUAL_CURSILLO_FK1 FOREIGN KEY (INDIVIDUAL_ID) REFERENCES INDIVIDUAL(INDIVIDUAL_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT INDIVIDUAL_CURSILLO_FK2 FOREIGN KEY (CURSILLO_ID) REFERENCES CURSILLO(CURSILLO_ID) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO PARISH VALUES(1, 'St. Peter', 'Holy St.', 'Orlando', 'FL', '32143', '5443342343', 'Mr. Hall', 'The community at this Church is ready to go to our next Cursillo'); 
INSERT INTO PARISH VALUES(2, 'St. John', 'Pastor St.', 'Miami', 'FL', '12255', '4543452653', 'Mr. Davidson', 'The community at this Church is ready to go to our next Cursillo'); 
INSERT INTO PARISH VALUES(3, 'St. Luke', 'Wiscon St.', 'Tampa', 'FL', '65456', '3748747586', 'Mr. Duke', 'The community at this Church is ready to go to our next Cursillo'); 
INSERT INTO PARISH VALUES(4, 'St. Mark', 'Community St.', 'Gainesville', 'FL', '56246', '1243672397', 'Mr. Heard', 'The community at this Church is ready to go to our next Cursillo'); 
INSERT INTO PARISH VALUES(5, 'St. Matt', 'Rock St.', 'Ft. Lauderdale', 'FL', '67543', '8743342389', 'Mr. Tomlin', 'The community at this Church is ready to go to our next Cursillo'); 
INSERT INTO PARISH VALUES(6, 'St. Peter', 'Water St.', 'Oviedo', 'FL', '44543', '1243542345', 'Mr. Faulk', 'The community at this Church is ready to go to our next Cursillo'); 
INSERT INTO PARISH VALUES(7, 'St. Acts', 'Paul St.', 'South Dade', 'FL', '3676', '5233562465', 'Mr. Maul', 'The community at this Church is ready to go to our next Cursillo'); 

INSERT INTO INDIVIDUAL VALUES (1, 'John', 'Smith', 'John', 'Male', '111 Clinton Ave', 'Orlando', 'FL', '32085', '4072223245', '4079992885', 'john@smith.com', '1990-04-05', 'Welder', FALSE, NULL, NULL, FALSE, TRUE, TRUE, 1, NULL);

INSERT INTO INDIVIDUAL VALUES (2, 'Alex', 'Orbit', 'Alex', 'Female', '582 NW 3rd St', 'Tampa', 'FL', '34827', '2136623245', '8837292885', 'AlexOrbit@gmail.com', '1990-03-02', 'Actress', TRUE, 'William', 'Orbit', TRUE, TRUE, TRUE, 1, null);

INSERT INTO INDIVIDUAL VALUES (3, 'William', 'Orbit', 'Bob', 'Male', '582 NW 3rd St', 'TAMPA', 'FL', '34827', '4072223245', '4079992885', 'BobOrbit@gmail.com', '1989-06-09', 'Garbage Man', TRUE, 'Alex', 'Orbit', TRUE, TRUE, TRUE, 1, 2); 

Update INDIVIDUAL SET SPOUSE_ID = 3 WHERE INDIVIDUAL_ID = 2;

INSERT INTO INDIVIDUAL VALUES (4, 'Jessica', 'Rabbit', 'Jess', 'Female', '243 Cartoon Ave', 'Chicago', 'IL', '60602', '3123991104', '3129992018', 'JessicaRabbit@gmail.com', '1993-02-09', 'Dancer', FALSE, NULL, NULL, FALSE, TRUE, TRUE, 2, NULL);

INSERT INTO INDIVIDUAL VALUES (5, 'Andrew', 'McMahon', 'Jack', 'Male', '299 Vineland', 'Oviedo', 'FL', '32601', '4074999925', '4078527264', 'AndrewMcMahon@gmail.com', '1994-09-02', 'Musician', TRUE, 'Beatrice', 'McMahon', TRUE, TRUE, TRUE, 2, NULL);

INSERT INTO INDIVIDUAL VALUES (6, 'Beatrice', 'McMahon', 'Bea', 'Female', '299 Vineland', 'Oviedo', 'FL', '32601', '4074999925', '4078488819', 'BeaMcMahon@gmail.com', '1992-06-08', 'House Wife', TRUE, 'Andrew', 'McMahon', TRUE, TRUE, FALSE, 2, 5);

Update INDIVIDUAL SET SPOUSE_ID = 6 WHERE INDIVIDUAL_ID = 5;

INSERT INTO INDIVIDUAL VALUES (7, 'Sandy', 'Pellagrino', 'Sandy', 'Female', '3888 1st Ave', 'Johnsonville', 'Ok', '99928', '3299818184', '8488271741', 'SanPellagrino@gmail.com', '1991-02-10', 'Computer Scientist', TRUE, 'Voss', 'Pellagrino', TRUE, FALSE, FALSE, 5, NULL);

INSERT INTO INDIVIDUAL VALUES (8, 'Voss', 'Pellagrino', 'Voss','Female', '3888 1st Ave', 'Johnsonville', 'Ok', '99928', '3299818184', '8488271741', 'VossPellagrino@gmail.com', '1992-05-02', 'Computer Scientist', TRUE, 'San', 'Pellagrino', TRUE, FALSE, FALSE, 5, 7);

Update INDIVIDUAL SET SPOUSE_ID = 8 WHERE INDIVIDUAL_ID = 7;

INSERT INTO INDIVIDUAL VALUES (9, 'Sagar', 'Mistry', 'Sagar', 'Male', '38882 2nd Blvd', 'Kissimmi', 'FL', '99938', '2771937842', '2827473811', 'SagarMistry@gmail.com', '1992-04-06', 'PM Lead', FALSE, NULL, NULL, TRUE, FALSE, FALSE, 1, NULL);

INSERT INTO INDIVIDUAL VALUES (10, 'Adam', 'Levy', 'Adam', 'Male', '2212 Aasdf CT', 'Nowhere', 'HI', '48881', '4029999991', '5828824774', 'AdamLevy@gmail.com', '1991-04-07', 'Social', FALSE, NULL, NULL, TRUE, FALSE, FALSE, 3, NULL);

INSERT INTO INDIVIDUAL VALUES (11, 'Michael', 'Raymond', 'Mike', 'Male', '5432 Daern ST.', 'Laurelton', 'NY', '34532', '5652345434', '2124542341', 'mikeraymond@gmail.com', '1990-01-05', 'DM Lead', FALSE, NULL, NULL, TRUE, FALSE, FALSE, 2, NULL);

INSERT INTO INDIVIDUAL VALUES (12, 'Sam', 'Hall', 'Sam', 'Male', '3348 2nd Ave', 'Joville', 'Ok', '45438', '3214532343', '3235431234', 'Samhall@gmail.com', '1993-04-06', 'Computer Scientist', TRUE, 'Sally', 'Hall', FALSE, FALSE, FALSE, 4, NULL);

INSERT INTO INDIVIDUAL VALUES (13, 'Sal', 'Coperton', 'Sal', 'Male', '5328 4th Ave', 'Aville', 'Ok', '44211', '3213456543', '3212312345', 'Salcouperton@gmail.com', '1993-02-06', 'Mechanic', TRUE, 'Karin', 'Coperton', FALSE, FALSE, FALSE, 3, NULL);

INSERT INTO INDIVIDUAL VALUES (14, 'Charles', 'Smith', 'Charles', 'Male', '5678 5th Ave', 'Queens', 'NY', '56743', '3213245412', '3230987689', 'charlessmith@gmail.com', '1992-10-06', 'Computer Scientist', TRUE, 'Sharabel', 'Smith', FALSE, FALSE, FALSE, 5, NULL);

INSERT INTO INDIVIDUAL VALUES (15, 'John', 'Smith', 'John', 'Male', '6786 7th Ave', 'Queens', 'NY', '65467', '3213245456', '7658909343', 'johnsmith@gmail.com', '1991-11-06', 'Scientist', TRUE, 'Kayla', 'Smith', FALSE, FALSE, FALSE, 3, NULL);

INSERT INTO INDIVIDUAL VALUES (16, 'Marco', 'Herrera', 'Marco', 'Male', '7656 8th Ave', 'Orlando', 'FL', '76788', '3218769809', '4563215787', 'marcoherrera@gmail.com', '1991-08-02', 'Finance', TRUE, 'Sara', 'Herrera', FALSE, FALSE, FALSE, 1, NULL);

INSERT INTO INDIVIDUAL VALUES (17, 'Matthew', 'Heimann', 'Matt', 'Male', '6546 9th Ave', 'Tampa', 'FL', '76534', '3210986745', '4566754', 'mattheimann@gmail.com', '1992-01-10', 'Mechanic', TRUE, 'Carla', 'Heimann', TRUE, FALSE, FALSE, 4, NULL);

INSERT INTO INDIVIDUAL VALUES (18, 'Carla', 'Heimann', 'Carla', 'Female', '6546 9th Ave', 'Tampa', 'FL', '76534', '3210986745', '4075676545', 'carlaheimann@gmail.com', '1992-03-02', 'Sales', TRUE, 'Matt', 'Heimann', TRUE, TRUE, FALSE, 5, 17);

Update INDIVIDUAL SET SPOUSE_ID = 18 WHERE INDIVIDUAL_ID = 17;

INSERT INTO INDIVIDUAL VALUES (19, 'Ryan', 'Krammer', 'Ryan', 'Male', '6765 10th Ave', 'Tampa', 'FL', '76654', '3218769890', '4077657689', 'ryankrammer@gmail.com', '1992-04-03', 'Sales', TRUE, 'Samantha', 'Krammer', FALSE, TRUE, FALSE, 6, NULL);

INSERT INTO INDIVIDUAL VALUES (20, 'Kristen', 'Rockwood', 'Kristy', 'Female', '6543 11th Ave', 'Orlando', 'FL', '45345', '3217658789', '4077877898', 'kristyrockwood@gmail.com', '1991-03-10', 'Sales Representative', TRUE, 'Sam', 'Rockwood', FALSE, TRUE, FALSE, 7, NULL);

INSERT INTO INDIVIDUAL VALUES (21, 'Sally', 'Graham', 'Sally', 'Female', '4532 12th Ave', 'Orlando', 'FL', '32135', '3210987897', '4073212345', 'sallygraham@gmail.com', '1991-03-11', 'Doctor', TRUE, 'Charles', 'Graham', FALSE, TRUE, FALSE, 2, NULL);

INSERT INTO INDIVIDUAL VALUES (22, 'Luke', 'Heimann', 'Luke', 'Male', '1987 13th Ave', 'Orlando', 'FL', '43234', '3214564533', '2349432354', 'lukeheimann@gmail.com', '1994-02-11', 'Sales', TRUE, 'Cara', 'Heimann', FALSE, TRUE, FALSE, 1, NULL);

INSERT INTO INDIVIDUAL VALUES (23, 'Jessica', 'Payne', 'Jessie', 'Female', '22 Desert Plain', 'Miami', 'FL', '30065', '9096663576', '9000992888', 'jessica@payne.com', '1954-7-12', 'Retired', TRUE, 'Maxwell', 'Payne', TRUE, TRUE, TRUE, 2, NULL);

INSERT INTO INDIVIDUAL VALUES (24, 'Maxwell', 'Payne', 'Max', 'Male', '22 Desert Plain', 'Miami', 'FL', '30065', '9096663576', '9099992888', 'max@payne.com', '1952-5-01', 'Retired', TRUE, 'Jessica', 'Payne', TRUE, TRUE, TRUE, 2, 23);

Update INDIVIDUAL SET SPOUSE_ID = 24 WHERE INDIVIDUAL_ID = 23;

INSERT INTO INDIVIDUAL VALUES (25, 'Patricia', 'Gentles', 'Patty', 'Female', '67 DD Place', 'Tampa', 'FL', '33765', '7277244576', '7273442888', 'patty@gentles.com', '1985-9-10', 'Food Manager', FALSE, NULL, NULL, FALSE, TRUE, TRUE, 1, NULL);

INSERT INTO INDIVIDUAL VALUES (26, 'Juliette', 'Geller', 'Julie', 'Female', '78 Endless Road', 'Miami', 'FL', '30065', '9097223576', '9090072888', 'julie@geller.com', '1996-1-23', 'Sales-Rep', TRUE, NULL, NULL, FALSE, FALSE, TRUE, 3, NULL);

INSERT INTO INDIVIDUAL VALUES (27, 'Moby', 'Dick', 'Dicky', 'Male', '555 Kangaroo Jump St.', 'Oviedo', 'FL', '39765', '4076823576', '4072332888', 'moby@dick.com', '1960-8-31', 'Whaler', FALSE, NULL, NULL, FALSE, FALSE, FALSE, 4, NULL);

INSERT INTO INDIVIDUAL VALUES (28, 'William', 'Goldberg', 'Billy', 'Male', '33 Jesus Way', 'Tampa', 'FL', '33765', '7277223576', '7270072888', 'billy@goldberg.com', '1973-10-31', 'Alligator Wrestler', TRUE, 'Carla', 'Bloom-Goldberg', FALSE, TRUE, TRUE, 5, NULL);

INSERT INTO INDIVIDUAL VALUES (29, 'Mary', 'Lewis', 'Mary', 'Female', '102 High Five Ave', 'Orlando', 'FL', '32817', '4072223576', '4079072888', 'mary@lewis.com', '1990-6-23', 'Make-up Artist', TRUE, 'Paul', 'Lewis', TRUE, TRUE, TRUE, 4, NULL);

INSERT INTO INDIVIDUAL VALUES (30, 'Paul', 'Lewis', 'Paulie', 'Male', '102 High Five Ave', 'Orlando', 'FL', '32817', '4072223576', '4079992888', 'paul@lewis.com', '1988-7-01', 'Driver', TRUE, 'Mary', 'Lewis', TRUE, TRUE, TRUE, 4, 29);

Update INDIVIDUAL SET SPOUSE_ID = 30 WHERE INDIVIDUAL_ID = 29;


INSERT INTO TEAM_MEMBER VALUES(10);
INSERT INTO TEAM_MEMBER VALUES(2);
INSERT INTO TEAM_MEMBER VALUES(9);
INSERT INTO TEAM_MEMBER VALUES(6);
INSERT INTO TEAM_MEMBER VALUES(7);
INSERT INTO TEAM_MEMBER VALUES(4);
INSERT INTO TEAM_MEMBER VALUES(1);
INSERT INTO TEAM_MEMBER VALUES(5);
INSERT INTO TEAM_MEMBER VALUES(3);
INSERT INTO TEAM_MEMBER VALUES(8);
INSERT INTO TEAM_MEMBER VALUES(11);
INSERT INTO TEAM_MEMBER VALUES(15);
INSERT INTO TEAM_MEMBER VALUES(12);
INSERT INTO TEAM_MEMBER VALUES(13);
INSERT INTO TEAM_MEMBER VALUES(17);
INSERT INTO TEAM_MEMBER VALUES(14);
INSERT INTO TEAM_MEMBER VALUES(16);
INSERT INTO TEAM_MEMBER VALUES(18);
INSERT INTO TEAM_MEMBER VALUES(21);
INSERT INTO TEAM_MEMBER VALUES(19);
INSERT INTO TEAM_MEMBER VALUES(22);
INSERT INTO TEAM_MEMBER VALUES(20);

INSERT INTO CANDIDATE VALUES(30);
INSERT INTO CANDIDATE VALUES(28);
INSERT INTO CANDIDATE VALUES(24);
INSERT INTO CANDIDATE VALUES(26);
INSERT INTO CANDIDATE VALUES(29);
INSERT INTO CANDIDATE VALUES(27);
INSERT INTO CANDIDATE VALUES(25);
INSERT INTO CANDIDATE VALUES(23);

INSERT INTO CURSILLO VALUES(1, 'Welcome to the best Cursillo! You will have so much fun!', 'Male', '2016-11-06', '2016-11-08', 'We hope that you have the greatest time ever and refer your friends for the next Cursillo!', 'Christian St.','Orlando', 'FL', '32825');
INSERT INTO CURSILLO VALUES(2, 'Welcome to the best Cursillo! You will have so much fun!', 'Male', '2016-11-21', '2016-11-23', 'We hope that you have the greatest time ever and refer your friends for the next Cursillo!', 'Holy St.','Miami', 'FL', '35432');
INSERT INTO CURSILLO VALUES(3, 'Welcome to the best Cursillo! You will have so much fun!', 'Female', '2016-11-15', '2016-11-17', 'We hope that you have the greatest time ever and refer your friends for the next Cursillo!', 'Power St.','Tampa', 'FL', '43225');
INSERT INTO CURSILLO VALUES(4, 'Welcome to the best Cursillo! You will have so much fun!', 'Female', '2016-11-25', '2016-11-27', 'We hope that you have the greatest time ever and refer your friends for the next Cursillo!', 'Brown St.','Gainesville', 'FL', '54322');
INSERT INTO CURSILLO VALUES(5, 'Welcome to the best Cursillo! You will have so much fun!', 'Female', '2016-12-06', '2016-12-08', 'We hope that you have the greatest time ever and refer your friends for the next Cursillo!', 'School St.','Melbourne', 'FL', '55429');

INSERT INTO PASTOR VALUES(1, 'Mike', 'Jones', 1);
INSERT INTO PASTOR VALUES(2, 'Stevie', 'Wonder', 2);
INSERT INTO PASTOR VALUES(3, 'Al', 'Sharpton', 3);
INSERT INTO PASTOR VALUES(4, 'Clark', 'Kent', 4);
INSERT INTO PASTOR VALUES(5, 'Ryan', 'Leslie', 5);
INSERT INTO PASTOR VALUES(6, 'Paul', 'Walker', 6);
INSERT INTO PASTOR VALUES(7, 'Luke', 'Cage', 7);

INSERT INTO TALK VALUES(1, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 1, 4, 2);
INSERT INTO TALK VALUES(2, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 1, 4, 4);
INSERT INTO TALK VALUES(3, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 1, 5, 6);
INSERT INTO TALK VALUES(4, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 1, 2, 13);
INSERT INTO TALK VALUES(5, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 1, 2, 16);
INSERT INTO TALK VALUES(6, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 2, 1, 9);
INSERT INTO TALK VALUES(7, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 2, 1, 30);
INSERT INTO TALK VALUES(8, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 2, 4, 8);
INSERT INTO TALK VALUES(9, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 2, 3, 18);
INSERT INTO TALK VALUES(10, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 2, 1, 19);
INSERT INTO TALK VALUES(11, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 3, 2, 28);
INSERT INTO TALK VALUES(12, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 3, 5, 23);
INSERT INTO TALK VALUES(13, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 3, 1, 22);
INSERT INTO TALK VALUES(14, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 3, 3, 6);
INSERT INTO TALK VALUES(15, 'Let''s have fun! At this talk we will be discussing what will occur throughout the day.', 3, 4, 21);

INSERT INTO TEAM VALUES(1, 'The Orlando team', 'Magic', 1);
INSERT INTO TEAM VALUES(2, 'The Chicago', 'Bulls', 1);
INSERT INTO TEAM VALUES(3, 'The Boston team', 'Celtics', 2);
INSERT INTO TEAM VALUES(4, 'The New York team', 'Knicks', 3);
INSERT INTO TEAM VALUES(5, 'The Philadelphia team', '76ers', 4);
INSERT INTO TEAM VALUES(6, 'The Miami team', 'Heat', 4);
INSERT INTO TEAM VALUES(7, 'The Golden State team', 'Warriors', 5);
INSERT INTO TEAM VALUES(8, 'The Atlanta team', 'Hawks', 5);
INSERT INTO TEAM VALUES(9, 'The Portland team', 'TrailBlazers', 3);
INSERT INTO TEAM VALUES(10, 'The Detroit team', 'Pistons', 1);

INSERT INTO ROLE VALUES(1, 'Kitchen', 'Head Chef', 1,1);
INSERT INTO ROLE VALUES(2, 'Prayer', 'Prayer Leader', 2,1);
INSERT INTO ROLE VALUES(3, 'Finance', 'Bookkeeper', 3,2);
INSERT INTO ROLE VALUES(4, 'Landscape', 'Gardener', 4,3);
INSERT INTO ROLE VALUES(5, 'General', 'General Assistant', 5,4);
INSERT INTO ROLE VALUES(6, 'Family', 'Child Watcher', 6,5);
INSERT INTO ROLE VALUES(7, 'Water', 'Water Runner', 7,6);
INSERT INTO ROLE VALUES(8, 'Sanitation', 'Sanitation Manager', 8,6);
INSERT INTO ROLE VALUES(9, 'Security', 'Security Guard', 9,7);
INSERT INTO ROLE VALUES(10, 'Prayer', 'Bible reader', 10,8);
INSERT INTO ROLE VALUES(11, 'Family', 'Friendship Advisor', 11,9);
INSERT INTO ROLE VALUES(12, 'Family', 'Marriage Counselor', 12,10);
INSERT INTO ROLE VALUES(13, 'Prayer', 'Choir Leader', 13,10);
INSERT INTO ROLE VALUES(14, 'Kitchen', 'Food Runnable', 14,6);
INSERT INTO ROLE VALUES(15, 'Prayer', 'Service Leader', 15,3);

INSERT INTO TEAM_MEMBER_ROLE VALUES(2,5);
INSERT INTO TEAM_MEMBER_ROLE VALUES(5,9);
INSERT INTO TEAM_MEMBER_ROLE VALUES(4,5);
INSERT INTO TEAM_MEMBER_ROLE VALUES(20,8);
INSERT INTO TEAM_MEMBER_ROLE VALUES(18,9);
INSERT INTO TEAM_MEMBER_ROLE VALUES(21,11);
INSERT INTO TEAM_MEMBER_ROLE VALUES(1,4);
INSERT INTO TEAM_MEMBER_ROLE VALUES(3,15);
INSERT INTO TEAM_MEMBER_ROLE VALUES(10,12);
INSERT INTO TEAM_MEMBER_ROLE VALUES(13,15);
INSERT INTO TEAM_MEMBER_ROLE VALUES(6,5);
INSERT INTO TEAM_MEMBER_ROLE VALUES(7,14);
INSERT INTO TEAM_MEMBER_ROLE VALUES(9,12);
INSERT INTO TEAM_MEMBER_ROLE VALUES(8,11);
INSERT INTO TEAM_MEMBER_ROLE VALUES(11,2);
INSERT INTO TEAM_MEMBER_ROLE VALUES(12,13);
INSERT INTO TEAM_MEMBER_ROLE VALUES(14,1);
INSERT INTO TEAM_MEMBER_ROLE VALUES(16,4);
INSERT INTO TEAM_MEMBER_ROLE VALUES(15,2);
INSERT INTO TEAM_MEMBER_ROLE VALUES(17,12);
INSERT INTO TEAM_MEMBER_ROLE VALUES(19,3);
INSERT INTO TEAM_MEMBER_ROLE VALUES(22,15);

INSERT INTO INDIVIDUAL_CURSILLO VALUES (24,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (27,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (28,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (30,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (23,5);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (25,3);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (26,5);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (29,4);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (1,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (1,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (2,4);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (2,5);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (3,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (3,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (5,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (5,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (9,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (9,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (10,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (10,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (11,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (11,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (12,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (12,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (13,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (13,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (14,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (14,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (15,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (15,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (16,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (16,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (17,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (17,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (19,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (19,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (22,1);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (22,2);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (4,3);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (4,4);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (6,5);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (6,3);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (7,3);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (7,4);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (8,4);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (8,5);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (8,3);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (18,3);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (18,5);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (20,3);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (20,4);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (21,5);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (21,4);
INSERT INTO INDIVIDUAL_CURSILLO VALUES (21,3);

commit;
