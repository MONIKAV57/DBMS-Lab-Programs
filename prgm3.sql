create database m;
use m;

create table actor
( a_id integer primary key,
  a_name varchar(20),
  a_gender varchar(2)
);

create table director
( d_id integer primary key,
  d_name varchar(20),
  d_ph integer
);

create table movies
( m_id integer primary key,
  m_title varchar(20),
  m_year integer,
  m_lang varchar(10),
  d_id integer,
  foreign key (d_id) references director(d_id) on delete cascade
);

create table movie_cast 
( a_id integer,
  m_id integer,
  role varchar(20),
  primary key(a_id,m_id),
  foreign key (a_id) references actor(a_id) on delete cascade,
  foreign key (m_id) references movies(m_id) on delete cascade
);

create table rating 
( m_id integer primary key,
  rev_star integer,foreign key (m_id) references movies(m_id) on delete cascade
);

insert into actor 
values (10,"vijay","M"),
       (20,"trisha","F"),
       (30,"surya","M"),
       (40,"punith","M"),
       (50,"jo","F");
       
insert into director 
values (11,"nelson",111111),
       (22,"gvm",2222222),
       (33,"karti",33333),
       (44,"siva",4444444),
       (55,"ajith",555555);

insert into movies
values (51,"leo",2024,"tamil",11),
       (52,"vtv",2021,"tamil",22),
       (53,"24",2019,"english",22),
       (54,"para",2003,"kannda",44),
       (55,"alagi",2005,"tamil",55);
       
insert into movie_cast
values (10,52,"hero"),
       (10,51,"hero"),
       (30,52,"comedian"),
       (20,53,"heroine"),
       (10,55,"heroine"),
       (10,53,"them");
  
insert into rating
values(51,1),
      (52,2),
      (53,3),
      (54,4),
      (55,5);
      
select * from actor;
select* from director;
select * from movies;
select* from movie_cast;
select* from rating;

/*q1*/
select m_title
from movies
where d_id in (select d_id
                from director
                where d_name="gvm");
                
/*q2*/
select m_title
from movies m, movie_cast mv
where m.m_id=mv.m_id
and mv.a_id in (
                  select a_id
                  from movie_cast
                  group by a_id
                  having count(*)>1)
group by m_title
having count(*)>=1;

/*q3*/
select a_name,m_title,m_year
from actor a 
join movie_cast c on a.a_id=c.a_id
join movies m on c.m_id=m.m_id
where m_year not between 2000 and 2015;

/*q4*/
select m_title, max(rev_star)
from movies
inner join rating using (m_id)
group by m_title
having max(rev_star)>0;

/*q5*/
update rating
set rev_star=5
where m_id in (
              select m_id 
              from movies
              where d_id in(
                            select d_id
                            from director
                            where d_name="nelson"));
select * from rating;                            

