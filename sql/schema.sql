CREATE TABLE "resourses" (
  "id" increment PRIMARY KEY,
  "title" varchar(250),
  "annotation" varchar,
  "type_id" int,
  "purpose" varchar,
  "last_used" timestamp,
  "time_of_using" int,
  "address" varchar
);

CREATE TABLE "resourse_author" (
  "id" increment PRIMARY KEY,
  "author_id" int,
  "resourse_id" int
);

CREATE TABLE "authors" (
  "id" increment PRIMARY KEY,
  "name" varchar(250),
  "surname" varchar(250)
);

CREATE TABLE "types" (
  "id" increment PRIMARY KEY,
  "name" varchar(250)
);

CREATE TABLE "users" (
  "id" increment PRIMARY KEY,
  "username" varchar
);

CREATE TABLE "resourse_user" (
  "id" increment PRIMARY KEY,
  "user_id" int,
  "resourse_id" int
);

ALTER TABLE "resourses" ADD FOREIGN KEY ("type_id") REFERENCES "types" ("id");

ALTER TABLE "resourse_author" ADD FOREIGN KEY ("author_id") REFERENCES "authors" ("id");

ALTER TABLE "resourse_author" ADD FOREIGN KEY ("resourse_id") REFERENCES "resourses" ("id");

ALTER TABLE "resourse_user" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "resourse_user" ADD FOREIGN KEY ("resourse_id") REFERENCES "resourses" ("id");
