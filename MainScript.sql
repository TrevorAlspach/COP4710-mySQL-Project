create schema if not exists 4710_Project;

use 4710_Project;

create table if not exists Property (
	address varchar(50) PRIMARY KEY,
    ownerName varchar(30) NOT NULL,
    price int NOT NULL
    );
    
create table if not exists House (
	bedrooms int NOT NULL, 
    bathrooms int NOT NULL, 
    size int NOT NULL, 
    address varchar(50) NOT NULL PRIMARY KEY,
    foreign key (address) references Property(address)
    );
    
create table if not exists BusinessProperty ( 
	type char(20) NOT NULL,
    size int NOT NULL, 
    address varchar(50) NOT NULL PRIMARY KEY,
    foreign key (address) references Property(address)
    );

create table if not exists Firm (
	id int PRIMARY KEY,
    name varchar(30) NOT NULL,
	address varchar(50) NOT NULL,
    foreign key (address) references Property(address)
    );
    
create table if not exists Agent (
	agentId int PRIMARY KEY,
    name varchar(30) NOT NULL,
    phone char(12) NOT NULL,
    firmId int NOT NULL,
    dateStarted date NOT NULL,
    foreign key (firmId) references Firm(id)
    );
    
create table if not exists Listings (
	address varchar(50),
    agentId int NOT NULL, 
    mlsNumber int PRIMARY KEY,
    dateListed date NOT NULL,
    foreign key (address) references Property(address),
    foreign key (agentId) references Agent(agentId)
    );
    
create table if not exists Buyer (
	id int PRIMARY KEY,
    name varchar(30) NOT NULL,
    phone char(12) NOT NULL,
    propertyType char(20),
    bedrooms int,
    bathrooms int,
    businessPropertyType char(20),
    minimumPreferredPrice int,
    maximumPreferredPrice int,
    check (propertyType = "House" OR propertyType = "Business Property")
    );
    
create table if not exists Works_With (
	buyerId int NOT NULL primary key,
    agentId int NOT NULL,
    foreign key (buyerId) references Buyer(id),
    foreign key (agentId) references Agent(agentId)
    );
    
#5 for Houses
insert into property values ('7297 Ashley Ave. Santa Clara, CA 95050', 'Phil Rivers', 140000);
insert into property values ('8485 Second Dr. Gloucester, MA 01930','Trevor Alspach',250000);
insert into property values ('212 Newbridge Street Ringgold, GA 30736','Austin Kim',280000);
insert into property values ('50 Rockledge Drive Minneapolis, MN 55406','Michael Iorga',500000);
insert into property values ('1 Howard Dr. Faribault, MN 55021','Sarah Boone',190000);

#5 for Business Properties
insert into property values ('442 NW. Bowman St. Zionsville, IN 46077','Tucker Quick', 420000);
insert into property values ('625 Proctor Dr. Longview, TX 75604', 'Ray Josephs', 235000);
insert into property values ('477 Tallwood Dr. New Rochelle, NY 10801', 'Morty Knags', 190000);
insert into property values ('439 Rockledge Ave. Grand Rapids, MI 49503', 'Tessie Nye', 580000);
insert into property values ('403 Spruce St. Henderson, KY 42420', 'Lyric Padmore', 245000);

#5 for Firm Addresses
insert into property values ('8B Iroquois St. Yuba City, CA 95993', 'Heather Adcock', 176000);
insert into property values ('549 North Ave. Lenoir, NC 28645', 'Lexia Albinson', 265000);
insert into property values ('84 Pilgrim Dr. Ada, OK 74820', 'Heath Jones', 372000);
insert into property values ('538 Nicolls Street Blacksburg, VA 24060', 'Brooks Dawson', 480000);
insert into property values ('8693 York Dr. Zanesville, OH 43701', 'Zach Baker', 295000);

#5 Houses Inserted
insert into House values (3, 2, 2200, (select address from Property where address = '7297 Ashley Ave. Santa Clara, CA 95050'));
insert into House values (2, 1, 1800, (select address from Property where address = '8485 Second Dr. Gloucester, MA 01930'));
insert into House values (3, 2, 2400, (select address from Property where address = '212 Newbridge Street Ringgold, GA 30736'));
insert into House values (4, 4, 3100, (select address from Property where address = '50 Rockledge Drive Minneapolis, MN 55406'));
insert into House values (5, 4, 4800, (select address from Property where address = '1 Howard Dr. Faribault, MN 55021'));

#5 Business Properties Inserted
insert into BusinessProperty values ('Office', 7000, (select address from Property where address = '442 NW. Bowman St. Zionsville, IN 46077'));
insert into BusinessProperty values ('Industrial', 16000, (select address from Property where address = '625 Proctor Dr. Longview, TX 75604'));
insert into BusinessProperty values ('Retail', 3200, (select address from Property where address = '477 Tallwood Dr. New Rochelle, NY 10801'));
insert into BusinessProperty values ('Hotel', 24000, (select address from Property where address = '439 Rockledge Ave. Grand Rapids, MI 49503'));
insert into BusinessProperty values ('Office', 8200, (select address from Property where address = '403 Spruce St. Henderson, KY 42420'));

#5 Firms Inserted
insert into Firm values (04286, 'Driggs Realty', (select address from Property where address = '8B Iroquois St. Yuba City, CA 95993'));
insert into Firm values (03207, 'Cardinal Realty', (select address from Property where address = '549 North Ave. Lenoir, NC 28645'));
insert into Firm values (39261, 'Haven Group Real Estate', (select address from Property where address = '84 Pilgrim Dr. Ada, OK 74820'));
insert into Firm values (97668, 'Carpe Diem Realty', (select address from Property where address = '538 Nicolls Street Blacksburg, VA 24060'));
insert into Firm values (58494, 'Brick Lane Realty', (select address from Property where address = '8693 York Dr. Zanesville, OH 43701'));

#5 Agents Inserted
insert into Agent values (84607, 'Montgomery Foster', '860-975-2406', (select id from Firm where id = 04286), '2017-07-07');
insert into Agent values (50419, 'Tranter Blackwood', '201-997-0847', (select id from Firm where id = 03207), '2017-09-15');
insert into Agent values (30592, 'Gregory Dawson', '580-385-4206', (select id from Firm where id = 39261), '2018-08-28');
insert into Agent values (45688, 'Diana Ash', '425-303-0784', (select id from Firm where id = 97668), '2018-09-20');
insert into Agent values (28604, 'Randall Thorn', '321-872-9154', (select id from Firm where id = 58494), '2020-02-20');

#10 Listings Inserted
insert into Listings values ((select address from Property where address = '7297 Ashley Ave. Santa Clara, CA 95050'), 84607, 86862551, '2018-06-22');
insert into Listings values ((select address from Property where address = '8485 Second Dr. Gloucester, MA 01930'), 50419, 57414386, '2019-08-09');
insert into Listings values ((select address from Property where address = '212 Newbridge Street Ringgold, GA 30736'), 30592, 54015539, '2020-07-06');
insert into Listings values ((select address from Property where address = '50 Rockledge Drive Minneapolis, MN 55406'), 45688, 88610829, '2020-09-15');
insert into Listings values ((select address from Property where address = '1 Howard Dr. Faribault, MN 55021'), 28604, 64856986, '2020-11-30');

insert into Listings values ((select address from Property where address = '442 NW. Bowman St. Zionsville, IN 46077'), 84607, 24484897, '2018-05-02');
insert into Listings values ((select address from Property where address = '625 Proctor Dr. Longview, TX 75604'), 50419, 92766825, '2019-05-23');
insert into Listings values ((select address from Property where address = '477 Tallwood Dr. New Rochelle, NY 10801'), 30592, 35721144, '2019-09-17');
insert into Listings values ((select address from Property where address = '439 Rockledge Ave. Grand Rapids, MI 49503'), 45688, 84364905, '2020-07-30');
insert into Listings values ((select address from Property where address = '403 Spruce St. Henderson, KY 42420'), 28604, 27576062 , '2020-11-17');

#5 Buyers Inserted
insert into Buyer (id, name, phone, propertyType, bedrooms, bathrooms, minimumPreferredPrice, maximumPreferredPrice)
  values (19167, 'Sharleen Romilly', '231-652-2617', 'House', 3, 2, 180000, 280000);
insert into Buyer (id, name, phone, propertyType, bedrooms, bathrooms, minimumPreferredPrice, maximumPreferredPrice)
 values (20909, 'Barbara Dunn', '219-650-7366', 'House', 4, 4, 280000, 500000);
insert into Buyer (id, name, phone, propertyType, bedrooms, bathrooms, minimumPreferredPrice, maximumPreferredPrice)
 values (06035, 'Marly Jervis', '256-299-6164', 'House', 3, 2, 220000, 320000);
insert into Buyer (id, name, phone, propertyType, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice)
 values (10199, 'Gorden Symonds', '614-431-5181', 'Business Property', 'Office', 200000, 300000);
insert into Buyer (id, name, phone, propertyType, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice)
 values (01245, 'Cherryl Grey', '919-537-8571', 'Business Property', 'Retail', 150000, 250000);
 
insert into works_with values (19167, 84607);
insert into works_with values (20909, 84607);
insert into works_with values (06035, 30592);
insert into works_with values (10199, 45688);
insert into works_with values (01245, 28604);






    
    

    

    
    

    

    

