CREATE TABLE "resources" (
  "id" serial PRIMARY KEY,
  "title" varchar(250),
  "annotation" varchar,
  "type_id" int,
  "purpose" varchar,
  "last_used" timestamp,
  "time_of_using" int,
  "address" varchar
);

CREATE TABLE "resource_author" (
  "id" serial PRIMARY KEY,
  "author_id" int,
  "resource_id" int
);

CREATE TABLE "authors" (
  "id" serial PRIMARY KEY,
  "name" varchar(250),
  "surname" varchar(250)
);

CREATE TABLE "types" (
  "id" serial PRIMARY KEY,
  "name" varchar(250)
);

CREATE TABLE "users" (
  "id" serial PRIMARY KEY,
  "username" varchar
);

CREATE TABLE "resource_user" (
  "id" serial PRIMARY KEY,
  "user_id" int,
  "resource_id" int
);

ALTER TABLE "resources" ADD FOREIGN KEY ("type_id") REFERENCES "types" ("id");

ALTER TABLE "resource_author" ADD FOREIGN KEY ("author_id") REFERENCES "authors" ("id");

ALTER TABLE "resource_author" ADD FOREIGN KEY ("resource_id") REFERENCES "resources" ("id");

ALTER TABLE "resource_user" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "resource_user" ADD FOREIGN KEY ("resource_id") REFERENCES "resources" ("id");
