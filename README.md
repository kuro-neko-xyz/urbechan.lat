# Requirements

- node
- postgres

# Installation

On a psql shell run:

```
CREATE ROLE urbechan WITH LOGIN PASSWORD <your password>;
CREATE DATABASE urbechan;
ALTER DATABASE urbechan OWNER TO urbechan;
```

**On a fresh PostgreSQL installation you may need to modify the `pg_hba.conf` to change the method of authentication from `peer` to `scram-sha-256` if you do not want to create an `urbechan` user in your system.**

On a bash shell run:

```
cd <path to project>
psql -U urbechan -d urbechan -a -f install.sql
npm i
npm run dev
```
