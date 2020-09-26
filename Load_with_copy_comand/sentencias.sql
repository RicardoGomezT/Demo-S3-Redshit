create table event(
	eventid integer not null distkey,
	venueid smallint not null,
	catid smallint not null,
	dateid smallint not null sortkey,
	eventname varchar(200),
	starttime timestamp);
	
create table category(
	catid smallint not null distkey sortkey,
	catgroup varchar(10),
	catname varchar(10),
	catdesc varchar(50));
	
create table date(
	dateid smallint not null distkey sortkey,
	caldate date not null,
	day character(3) not null,
	week smallint not null,
	month character(5) not null,
	qtr character(5) not null,
	year smallint not null,
	holiday boolean default('N'));
	
create table venue(
	venueid smallint not null distkey sortkey,
	venuename varchar(100),
	venuecity varchar(30),
	venuestate char(2),
	venueseats integer);


create table listing(
	listid integer not null distkey,
	sellerid integer not null,
	eventid integer not null,
	dateid smallint not null  sortkey,
	numtickets smallint not null,
	priceperticket decimal(8,2),
	totalprice decimal(8,2),
	listtime timestamp);
	

create table sales(
	salesid integer not null,
	listid integer not null distkey,
	sellerid integer not null,
	buyerid integer not null,
	eventid integer not null,
	dateid smallint not null sortkey,
	qtysold smallint not null,
	pricepaid decimal(8,2),
	commission decimal(8,2),
	saletime timestamp);

create table users(
	userid integer not null distkey sortkey,
	username char(8),
	firstname varchar(30),
	lastname varchar(30),
	city varchar(30),
	state char(2),
	email varchar(100),
	phone char(14),
	likesports boolean,
	liketheatre boolean,
	likeconcerts boolean,
	likejazz boolean,
	likeclassical boolean,
	likeopera boolean,
	likerock boolean,
	likevegas boolean,
	likebroadway boolean,
	likemusicals boolean);

SELECT * FROM users;

copy users from 's3://tu_bucket/allusers_pipe.txt' 
credentials 'aws_iam_role=tu_arn_iam' 
delimiter '|' region 'tu_region';

copy venue from 's3://tu_bucket/venue_pipe.txt' 
credentials 'aws_iam_role=tu_arn_iam' 
delimiter '|' region 'tu_region';

copy category from 's3://tu_bucket/category_pipe.txt' 
credentials 'aws_iam_role=tu_arn_iam' 
delimiter '|' region 'tu_region';

copy date from 's3://tu_bucket/date2008_pipe.txt' 
credentials 'aws_iam_role=tu_arn_iam' 
delimiter '|' region 'tu_region';

copy event from 's3://tu_bucket/allevents_pipe.txt' 
credentials 'aws_iam_role=tu_arn_iam' 
delimiter '|' timeformat 'YYYY-MM-DD HH:MI:SS' region 'tu_region';

copy listing from 's3://tu_bucket/listings_pipe.txt' 
credentials 'aws_iam_role=tu_arn_iam' 
delimiter '|' region 'tu_region';

copy sales from 's3://tu_bucket/sales_tab.txt'
credentials 'aws_iam_role=tu_arn_iam'
delimiter '\t' timeformat 'MM/DD/YYYY HH:MI:SS' region 'tu_region';

--cargue de archivos json

create  table  estudiante
( id  int2,
nombre  varchar(20),
apellido  varchar(20),
edad  int2,
fecha_ingreso  date );

SELECT * FROM estudiante;

copy  estudiante  from  's3://demo-redshift-richie/tickitdb/estudiante.json'  credentials  'aws_iam_role=tu_arn_iam'
format  as  json  'auto'  region  'tu_region';


