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

On a bash shell run:

```
cd <path to project>
psql -U urbechan -d urbechan -a -f install.sql
npm i
npm run dev
```
