-- create a table
CREATE TABLE people (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  job TEXT NOT NULL,
  alive boolean not NULL,
  employer TEXT
);
CREATE TABLE publications (
  id SERIAL PRIMARY KEY,
  title TEXT not NULL,
  year INTEGER not NULL,
  author_id INTEGER not NULL,
  foreign KEY (author_id) references people(id)
);

insert into people values (DEFAULT, 'Annaia Danvers', 'Programmer',  TRUE, 'Siili');
insert into people values (DEFAULT, 'Lisa Randall', 'Physicist', TRUE, null );
insert into people values (DEFAULT, 'Grace Hopper', 'Computer Scientist', FALSE, 'US Navy');
insert into people values (DEFAULT, 'Steve Klabnik', 'Programmer', TRUE, 'Oxide');

insert into publications values (DEFAULT, 'The Rust Programming Language', 2018, 4);
insert into publications values (DEFAULT, 'Understanding Computers', 1987, 3 );
insert into publications values (DEFAULT, 'Higgs Discovery', 2013, 2 );
insert into publications values (DEFAULT, 'Warped Passages', 2005, 2 );

