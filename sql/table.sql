DROP TABLE IF EXISTS wals;
DROP TABLE IF EXISTS temp;
CREATE TABLE temp
(
--	id serial NOT NULL,
	wal_updated_at timestamp without time zone NOT NULL,
    filename varchar NOT NULL,
	system varchar NOT NULL,
	collected_At timestamp without time zone NOT NULL
);
CREATE TABLE wals
(
--	id serial NOT NULL,
	wal_updated_at timestamp without time zone NOT NULL,
    filename varchar NOT NULL,
	system varchar NOT NULL,
	collected_At timestamp without time zone NOT NULL
);
CREATE INDEX ON wals (system, wal_updated_at);
CREATE UNIQUE INDEX ON wals (system, filename);
