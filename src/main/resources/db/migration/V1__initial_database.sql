-- Worker Table
CREATE TABLE "Worker" (
  "id" BIGINT NOT NULL PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "full_name" VARCHAR,
  "email" VARCHAR,
  "phone_number" VARCHAR,
  "password_hash" VARCHAR,
  "skills" TEXT,
  "location" VARCHAR,
  "availability_status" VARCHAR,
  "rating" FLOAT,
  "profile_picture_url" VARCHAR,
  "verified" BOOLEAN
);

-- Client Table
CREATE TABLE "Client" (
  "id" BIGINT NOT NULL PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "business_or_full_name" VARCHAR,
  "email" VARCHAR,
  "phone_number" VARCHAR,
  "address" TEXT,
  "client_type" VARCHAR,
  "password_hash" VARCHAR
);

COMMENT ON COLUMN "Client"."client_type" IS 'enum: hotel, restaurant, home';

-- JobPost Table
CREATE TABLE "JobPost" (
  "id" BIGINT NOT NULL PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "client_id" BIGINT,
  "title" VARCHAR,
  "description" TEXT,
  "location" VARCHAR,
  "required_skills" TEXT,
  "job_type" VARCHAR,
  "salary_offer" DECIMAL,
  "status" VARCHAR,
  "posted_date" DATE,
  FOREIGN KEY ("client_id") REFERENCES "Client" ("id")
);

COMMENT ON COLUMN "JobPost"."job_type" IS 'enum: one-time, recurring';
COMMENT ON COLUMN "JobPost"."status" IS 'open, closed';

-- Booking Table
CREATE TABLE "Booking" (
  "id" BIGINT NOT NULL PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "job_id" BIGINT,
  "worker_id" BIGINT,
  "start_date" DATE,
  "end_date" DATE,
  "status" VARCHAR,
  FOREIGN KEY ("job_id") REFERENCES "JobPost" ("id"),
  FOREIGN KEY ("worker_id") REFERENCES "Worker" ("id")
);

COMMENT ON COLUMN "Booking"."status" IS 'pending, accepted, completed, cancelled';

-- Payment Table
CREATE TABLE "Payment" (
  "id" BIGINT NOT NULL PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "booking_id" BIGINT,
  "amount" DECIMAL,
  "payment_date" TIMESTAMP,
  "payment_method" VARCHAR,
  "status" VARCHAR,
  FOREIGN KEY ("booking_id") REFERENCES "Booking" ("id")
);

COMMENT ON COLUMN "Payment"."status" IS 'paid, pending, failed';

-- RentalItem Table
CREATE TABLE "RentalItem" (
  "id" BIGINT NOT NULL PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "name" VARCHAR,
  "description" TEXT,
  "category" VARCHAR,
  "rental_price_per_day" DECIMAL,
  "deposit_amount" DECIMAL,
  "availability_status" VARCHAR,
  "owner_id" BIGINT,
  FOREIGN KEY ("owner_id") REFERENCES "Client" ("id")
);

COMMENT ON COLUMN "RentalItem"."category" IS 'e.g., cleaning, cooking, uniform';
COMMENT ON COLUMN "RentalItem"."availability_status" IS 'available, rented, maintenance';

-- Split Rental Transactions

CREATE TABLE "ClientRentalTransaction" (
  "id" BIGINT PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "item_id" BIGINT NOT NULL,
  "client_id" BIGINT NOT NULL,
  "start_date" DATE,
  "end_date" DATE,
  "status" VARCHAR,
  "total_price" DECIMAL,
  "deposit_paid" BOOLEAN,
  FOREIGN KEY ("item_id") REFERENCES "RentalItem"("id"),
  FOREIGN KEY ("client_id") REFERENCES "Client"("id")
);

CREATE TABLE "WorkerRentalTransaction" (
  "id" BIGINT PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "item_id" BIGINT NOT NULL,
  "worker_id" BIGINT NOT NULL,
  "start_date" DATE,
  "end_date" DATE,
  "status" VARCHAR,
  "total_price" DECIMAL,
  "deposit_paid" BOOLEAN,
  FOREIGN KEY ("item_id") REFERENCES "RentalItem"("id"),
  FOREIGN KEY ("worker_id") REFERENCES "Worker"("id")
);

COMMENT ON COLUMN "ClientRentalTransaction"."status" IS 'pending, approved, returned, late, cancelled';
COMMENT ON COLUMN "WorkerRentalTransaction"."status" IS 'pending, approved, returned, late, cancelled';

-- Split Reviews

CREATE TABLE "ClientReview" (
  "id" BIGINT PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "client_id" BIGINT NOT NULL,
  "worker_id" BIGINT NOT NULL,
  "rating" FLOAT,
  "comment" TEXT,
  FOREIGN KEY ("client_id") REFERENCES "Client"("id"),
  FOREIGN KEY ("worker_id") REFERENCES "Worker"("id")
);

CREATE TABLE "WorkerReview" (
  "id" BIGINT PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "worker_id" BIGINT NOT NULL,
  "client_id" BIGINT NOT NULL,
  "rating" FLOAT,
  "comment" TEXT,
  FOREIGN KEY ("worker_id") REFERENCES "Worker"("id"),
  FOREIGN KEY ("client_id") REFERENCES "Client"("id")
);

-- Split Rental Reviews

CREATE TABLE "ClientRentalReview" (
  "id" BIGINT PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "rental_id" BIGINT,
  "client_id" BIGINT,
  "rating" FLOAT,
  "comment" TEXT,
  FOREIGN KEY ("rental_id") REFERENCES "ClientRentalTransaction"("id"),
  FOREIGN KEY ("client_id") REFERENCES "Client"("id")
);

CREATE TABLE "WorkerRentalReview" (
  "id" BIGINT PRIMARY KEY,
  "created_by" VARCHAR(255),
  "updated_by" VARCHAR(255),
  "created_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_date" TIMESTAMP NOT NULL,
  "rental_id" BIGINT,
  "worker_id" BIGINT,
  "rating" FLOAT,
  "comment" TEXT,
  FOREIGN KEY ("rental_id") REFERENCES "WorkerRentalTransaction"("id"),
  FOREIGN KEY ("worker_id") REFERENCES "Worker"("id")
);
