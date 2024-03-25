create table student 
(
  usn integer primary key,
  s_name varchar(20),
  addr varchar(20),
  ph integer ,
  gender varchar(2)
);

create table semsec 
(
  ssid varchar(20) primary key,
  sem integer,
  sec varchar(2)
);
  
create table class
(
  usn integer primary key,
  ssid varchar(20),
  foreign key (usn) references student(usn) on delete cascade,
  foreign key (ssid) references semsec(ssid) on delete cascade
);

create table subject 
(
  subcode integer primary key,
  title varchar(20),
  sem integer,
  credits integer
);

create table IAmarks
(
  usn integer ,
  subcode integer,
  ssid varchar(20),
  t1 integer,
  t2 integer,
  t3 integer,
  finalIA integer,
  primary key(subcode,usn,ssid),
  foreign key (usn) references student(usn) on delete cascade,
  foreign key (ssid) references semsec(ssid) on delete cascade,
  foreign key (subcode) references subject(subcode) on delete cascade);
  
  desc student;
  desc semsec;
  desc class;
  desc subject;
  desc IAmarks;
  
 insert into student
  values (101,"monu","blr",11111,"F"),
         (102,"THEJ","chittor",2222222,"M"),
         (111,'ANAND','BELAGAVI', 1233423,'M'),
        (103,'BABIITHA','BENGALURU',43123,'F'),
        (104,'CHETHAN','BENGALURU', 534234,'M'),
        (105,'DIVYA','MANGALURU',534432,'F'),
        (106,'EESHA','BENGALURU', 345456,'F'),
        (107,'GANESH','BENGALURU',574532,'M'),
        (108,'HARISH','BENGALURU', 235464,'M'),
        (109,'ISHA','TUMKUR', 764343,'F'),
        (110,'JOEY','DAVANGERE', 235653,'M');
  select * from student;
  
  insert into semsec
  values('CSE8A', 8,'A'),
    ('CSE8B', 8,'B'),
    ('CSE8C', 8,'C'),
    ('CSE7A', 7,'A'),
    ('CSE7B', 7,'B'),
    ('CSE7C', 7,'C'),
    ('CSE6A', 6,'A'),
    ('CSE6B', 6,'B'),
    ('CSE6C', 6,'C'),
    ('CSE5A', 5,'A'),
    ('CSE5B', 5,'B'),
    ('CSE5C', 5,'C'),
    ('CSE4A', 4,'A'),
    ('CSE4B', 4,'B'),
    ('CSE4C', 4,'C'),
    ('CSE3A', 3,'A'),
    ('CSE3B', 3,'B');
  select * from semsec;

insert into class 
values (101,"CSE3B"),
       (103,"CSE4C"),
       (102,"CSE5C"),
       (104,"CSE8C"),
       (105,"CSE8A"),
       (106,"CSE4B"),
       (107,"CSE7A"),
       (108,"CSE7A"),
       (109,"CSE7A");
select * from class;

insert into subject 
values (51,"atc",5,4),
       (52,'ACA', 8, 4),
    (53,'SSM', 8, 4),
    (54,'NM', 8, 4),
    (55,'CC', 8, 4),
    (56,'PW', 8, 4),
    (57,'OOAD', 7, 4),
    (58,'ECS', 7, 4),
    (59,'PTW', 7, 4),
    (60,'DWDM', 7, 4);
select * from subject;

insert into IAmarks(usn , subcode,ssid,t1,t2,t3)
values(101,51,'CSE8C', 15, 16, 18),
    (101,52,'CSE8C', 12, 19, 14),
    (101,53,'CSE8C', 19, 15, 20),
    (101,54,'CSE8C', 20, 16, 19),
    (101,55,'CSE8C', 15, 15, 12);
select* from IAmarks;

/*q1*/
select s.*,ss.sem,ss.sec
from student s, semsec ss, class c 
where s.usn=c.usn
and ss.ssid=c.ssid
and ss.sem=4 
and ss.sec="C";

/*q2*/
select ss.sem, ss.sec ,s.gender,count(s.gender) as count
from student s, class c , semsec ss
where s.usn=c.usn
and c.ssid=ss.ssid
group by ss.sem,ss.sec,s.gender
order by sem;

/*q3*/
create view tview as
select s.s_name,s.usn,i.subcode,i.t1
from student s,IAmarks i 
where s.usn=i.usn
and s.usn="101";
select* from tview;

/*q4*/
