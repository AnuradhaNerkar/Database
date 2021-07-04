create database blood;

use blood;

create table admin(a_id integer primary key,a_name varchar(20),a_address varchar(30),qualification varchar(10),join_date date,mobile varchar(10),age integer);

create table blood_bank(bb_id integer primary key,bb_name varchar(20),bb_address varchar(20),bb_city varchar(10),bb_mobile varchar(10),a_id integer,foreign key
(a_id) references admin(a_id) on delete cascade);


create table blood_stock(bs_id integer primary key,blood_group varchar(10) check(blood_group in('AB+','AB-','O+','O-','A+','A-','B+','B-')),quantity integer,
availability boolean,b_price integer,bb_id integer,foreign key(bb_id)references blood_bank(bb_id)on delete cascade);

create table blood_donor(bd_id integer primary key,bd_name varchar(20),bd_address varchar(20),bd_city varchar(10),bd_bloodgroup varchar(3),gender varchar(10),
mobile varchar(10),donate_quantity integer,age integer check(age>18),donate_date date,bb_id integer,foreign key(bb_id) references blood_bank(bb_id) 
on delete cascade);

alter table blood_donor add(a_id integer,foreign key(a_id) references admin(a_id) on delete cascade);


create table patient(p_id integer primary key,p_name varchar(20),p_address varchar(20),p_city varchar(10),p_gender varchar(10),p_hospitalname varchar(20),
p_haddress varchar(20),p_disease varchar(20),p_bloodgroup varchar(3),a_id integer,foreign key(a_id) references admin(a_id) on delete cascade,bb_id integer,
foreign key(bb_id) references blood_bank(bb_id) on delete cascade);

create table orders(o_id integer primary key,select_blood varchar(3) check(select_blood in('AB+','AB-','O+','O-','A+','A-','B+','B-')),quantity integer,price 
integer,o_address varchar(30),o_city varchar(10),prescription_image BLOB,o_date date,p_id integer,foreign key(p_id) references patient(p_id)on delete cascade,
bb_id integer,foreign key(bb_id) references blood_bank(bb_id) on delete cascade);

create table payment(pa_id integer primary key,paid_by varchar(20),total_amount integer,o_id integer,foreign key(o_id) references orders(o_id)on delete cascade,
bb_id integer, foreign key(bb_id) references blood_bank(bb_id) on delete cascade,p_id integer,foreign key(p_id) references patient(p_id) on delete cascade);

create table patient_orders_payment(p_id integer,o_id integer,pa_id integer,foreign key(p_id) references patient(p_id) on delete cascade,foreign key(o_id) 
references orders(o_id) on delete cascade,foreign key(pa_id) references payment(pa_id) on delete cascade);

create table bloodbank_blooddonor(bb_id integer,bd_id integer,foreign key(bb_id)references blood_bank(bb_id) on delete cascade,foreign key(bd_id)references 
blood_donor(bd_id) on delete cascade);

create table bloodbank_patient(bb_id integer,bd_id integer,foreign key(bb_id)references blood_bank(bb_id) on delete cascade,p_id integer,foreign key(p_id) 
references patient(p_id) on delete cascade);

create table a_login(username varchar(10),password varchar(20),a_id integer,foreign key(a_id)references admin(a_id) on delete cascade);

create table bank_login(username varchar(10),password varchar(20),bb_id integer,foreign key(bb_id)references blood_bank(bb_id) on delete cascade);

create table donor_login(username varchar(10),password varchar(20),bd_id integer,foreign key(bd_id)references blood_donor(bd_id) on delete cascade);

create table p_login(username varchar(10),password varchar(20),p_id integer,foreign key(p_id)references patient(p_id) on delete cascade);

insert into admin values(1,'Angel','shivaji nagar,pune','MCA','2021-04-01','9822345612',27);

insert into blood_bank values(1,'bloodbank','FC road','pune','9552714523',1);
insert into blood_bank values(2,'Jivanbank','Shivaji nagar','pune','8875963214',1);


insert into blood_stock values(10,'AB+',0.5,1,200,1);
insert into blood_stock values(11,'AB-',2,1,800,1);
insert into blood_stock values(12,'B+',3,1,1200,1);
insert into blood_stock values(13,'B-',4,1,2500,1);
insert into blood_stock values(14,'A+',1,0,400,1);
insert into blood_stock values(15,'A-',0.5,1,200,1);
insert into blood_stock values(16,'O+',2,0,800,2);
insert into blood_stock values(17,'O-',0.5,1,200,2);
insert into blood_stock values(18,'AB+',1,1,400,2);
insert into blood_stock values(19,'AB-',5,1,3500,2);
insert into blood_stock values(20,'A+',2,1,1000,2);
insert into blood_stock values(21,'B+',3,1,1500,2);
insert into blood_stock values(22,'B-',4,1,4000,2);


insert into blood_donor values(11,'Rajat sharma','bawdhan','pune','AB-','male','9856742314','1',23,'2021-01-05',1,1);
insert into blood_donor values(12,'Amrita singh','viman nagar','pune','O-','female','7756148978','0.5',30,'2021-01-15',1,1);
insert into blood_donor values(13,'Rajan dev','kalyani nagar','pune','AB+','male','8856457896','1.5',35,'2021-03-04',1,1);
insert into blood_donor values(14,'Gayatri devi','Undri','pune','O+','female','7815236894','1',37,'2021-03-23',1,1);
insert into blood_donor values(15,'Madhvi raut','Bibwewadi','pune','A+','female','9978456312','1',28,'2021-04-03',1,1);

insert into patient values(101,'Anjali dev','Mulund','Mumbai','female','Tata Hospital','shivaji nagar,pune','Cancer','AB+',1,1);
insert into patient values(102,'sanjay sharma','swargate','pune','male','Apollo hospital','shivaji nagar,pune','Accidant blood loss','O-',1,1);
insert into patient values(103,'Ravi chaudhary','Tilak road','pune','male','Jawahar hospital','sangamwadi,pune','Blood Cancer','B+',1,1);
insert into patient values(104,'Mrunal khairnar','katraj','Pune','female','Apollo Hospital','Ambegaon,pune','Maleria','B-',1,1);
insert into patient values(105,'Sumit dev','Ambegaon','Pune','male','chaitanya Hospital','bibwewadi,pune','Dengue','A-',1,1);
insert into patient values(106,'Ranjana Thakur','Market yard','pune','female','Sangam Hospital','shivaji nagar,pune','Accidant Blood loss','A+',1,1);

insert into orders values(1,'AB+','1',200,'Apollo Hospital','pune','k.jpg','2021-04-09','104',1);
insert into orders values(2,'O-','2',400,'Jawahar hospital','pune','k.jpg','2021-05-01','103',1);

insert into payment values(1,'Credit card',200,1,1,104);

insert into patient_orders_payment values(104,1,1);

insert into bloodbank_blooddonor values(1,11);

insert into bloodbank_patient values(1,101);

insert into a_login values('angel123','12345',1);

insert into bank_login values('b_bank','bank123',1);
insert into bank_login values('j_bank','jivan123',2);

insert into donor_login values('R_sharama','rajat123',11);

insert into p_login values('Ra_thakur','thakur123',106);

/*List the details of patient whose city=pune*/

select * from patient where p_city='pune';

/*List the count of blood donor */

select count(bd_id) from blood_donor;

/*update the patient city mumbai to pune*/

update patient set p_city='pune' where p_city='Mumbai';

/*list the names of donors who donates more than o.5 litres*/

select bd_name,donate_quantity from blood_donor where donate_quantity>0.5;

/*List the max price of bloodgroup of bloodbank whose name is jivanbank*/

select max(b_price) from blood_stock where bb_id='2';

/*create a view containing patient name,city,bloodgroup from patient*/

create view PO as select p_name,p_city,p_bloodgroup from patient;

/*create a view containing o_id,selected bloodgroup and p_id from order*/

create view details as select o_id,select_blood,p_id from orders;

select * from PO;

select * from details;

/* write a function to count the no_of_orders from order table*/

Delimiter //
create function no_of_orders(o_id integer) returns int
deterministic
begin
declare n integer;

select count(o_id) into n from orders;

return n;
End 
//

select no_of_orders('1');
















