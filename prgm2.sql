create database s;
use s;
create table salesman
(
  s_id integer primary key,
  name varchar(20),
  city varchar (20),
  commission varchar(10));
  
create  table customer
(
  c_id integer primary key,
  c_name varchar(20),
  city varchar(10),
  grade integer,
  s_id integer,
  foreign key (s_id) references salesman(s_id) on delete cascade
  );
  
create table orders(
  o_no integer primary key,
  p_amt integer,
  ord_date date,
  c_id integer,
  s_id integer,
  foreign key (s_id) references salesman(s_id) on delete cascade,
  foreign key(c_id) references customer(c_id) on delete cascade
  );
insert into salesman 
values(100,"ram","ayodhya","10%"),
      (200,"siya","ayodhya","15%"),
      (300,"krish","dwarka","20%"),
      (400,"radha","dwarka","25%"),
      (500,"laksh","mysore","30%");
insert into customer
values (10,"jannu","ayodhya",1000,100),
        (20,"sonu","ayodhya",2000,300),
        (30,"ronu","mysore",3000,400),
        (40,"monu","ayodhya",4000,200),
        (50,"jonu","ayodhya",5000,100);
insert into orders
values (1,2500,'2017-05-04',10,200),
        (2,3500,'2017-05-04', 10, 100),
    (3, 3600, '2017-05-04', 10, 200),
    (4, 45050, '2017-01-20', 10, 200),
    (5, 1500, '2017-02-24', 20, 200),
    (6, 3500, '2017-04-13', 40, 300),
    (7, 5550, '2017-03-09', 20, 200),
    (8, 450, '2017-03-09', 20, 200);
    
select* from salesman;
select* from customer;
select * from orders;

/*q1*/
select grade,count(*)
from customer
group by grade
having grade> (select avg(grade)
                from customer
                where city="ayodhya");
/*q2*/
select s_id,name
from salesman s
where (select count(*)
              from customer
              where s_id=s.s_id)>1;
/*q3*/
select s.s_id,s.name,c_name
from salesman s, customer
where s.city=customer.city
union
select s_id,name,'no customer'
from salesman 
where not city=any (select city
                    from customer);
/*q4*/
create view es as
select o.ord_date,s.s_id,s.name
from salesman s,orders o
where s.s_id=o.s_id
and o.p_amt= (
              select max(p_amt)
              from orders oo 
              where oo.ord_date=o.ord_date);
select * from es;              
            
delete from salesman where s_id=200;
select * from salesman;

