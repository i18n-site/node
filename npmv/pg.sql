CREATE schema cdn;

CREATE TABLE cdn.pkg (
id bigserial NOT NULL,
name character varying(255) NOT NULL,
PRIMARY KEY (id),
UNIQUE (name)
);

CREATE TABLE cdn.refresh
(
id bigserial NOT NULL,
pkg_id bigint NOT NULL,
uid bigint NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE cdn.vps (
id bigserial NOT NULL,
name character varying(255) NOT NULL,
PRIMARY KEY (id),
UNIQUE (name)
);

CREATE TABLE cdn.vps_refresh (
id bigserial NOT NULL,
refresh_id bigint NOT NULL,
ts bigint NOT NULL,
PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION cdn.refresh_pkg(uid bigint, pkg_name character varying(255))
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  last_id bigint;
  pkg_id bigint;
BEGIN
  SELECT id INTO pkg_id FROM cdn.pkg WHERE name=pkg_name;
  IF NOT FOUND THEN
    INSERT INTO cdn.pkg(name) VALUES (pkg_name) RETURNING id INTO pkg_id;
  END IF;
  INSERT INTO cdn.refresh(pkg_id, uid) VALUES (pkg_id, uid) RETURNING id INTO last_id;
  PERFORM pg_notify(CAST('refresh_pkg' AS text), last_id::text);
END;
$$;
