--Table qui contient les paramètre des objetcs

DROP TABLE IF EXISTS parametre_object;
CREATE TABLE parametre_object
(
    object_id        INTEGER NOT NULL PRIMARY KEY,
    object_number    VARCHAR NOT NULL,
    is_highlight     BOOLEAN NOT NULL,
    is_timeline_work BOOLEAN NOT NULL,
    is_public_domain BOOLEAN NOT NULL
);

INSERT INTO parametre_object
    (SELECT DISTINCT object_id, object_number, is_highlight, is_timeline_work, is_public_domain
     from tableinitiale);


-- Les différents département
DROP TABLE IF EXISTS department;
CREATE TABLE department
(
    gallery_number serial PRIMARY KEY,
    department     VARCHAR
);

INSERT INTO department(department)(SELECT Distinct department
                                   from tableinitiale);


--Table des différentes culture
DROP TABLE if EXISTS culture;
CREATE TABLE culture
(
    culture VARCHAR PRIMARY KEY
);
INSERT INTO culture(culture)(SELECT DISTINCT culture FROM tableinitiale where culture is not NULL);

--Les  différents objets
DROP TABLE IF EXISTS objects;
CREATE TABLE objects
(
    id_objects       SERIAL PRIMARY KEY,
    object_name      VARCHAR,
    title            VARCHAR,
    accessionyear    INTEGER,
    culture          VARCHAR,
    parametre_object INTEGER,
    FOREIGN KEY (culture) REFERENCES culture (culture),
    FOREIGN KEY (parametre_object) REFERENCES parametre_object (object_id)
);

INSERT INTO objects(object_name, title, accessionyear, culture, parametre_object) (SELECT DISTINCT object_name, title, accessionyear, culture, object_id
                                                                                   FROM tableinitiale);


DROP TABLE IF EXISTS artiste_url;
CREATE TABLE artiste_url
(
    id_url SERIAL PRIMARY KEY ,
    artist_ulan_url     VARCHAR,
    artist_wikidata_url VARCHAR
);

INSERT INTO artiste_url(artist_ulan_url, artist_wikidata_url) (SELECT DISTINCT artist_ulan_url, artist_wikidata_url
                                                               FROM tableinitiale
                                                               where artist_wikidata_url is not null
                                                                 and artist_ulan_url is not null);


DROP TABLE IF EXISTS artiste_bio;
CREATE TABLE artiste_bio
(
    id_bio SERIAL PRIMARY KEY ,
    artist_display_bio VARCHAR ,
    artist_nationality VARCHAR,
    artist_gender      VARCHAR,
    artist_begin_date  VARCHAR,
    artist_end_date    VARCHAR

);

INSERT INTO artiste_bio(artist_display_bio, artist_nationality, artist_gender, artist_begin_date,
                        artist_end_date) (SELECT DISTINCT artist_display_bio,
                                                          artist_nationality,
                                                          artist_gender,
                                                          artist_begin_date,
                                                          artist_end_date
                                          FROM tableinitiale
                                          where artist_display_bio is not null
                                          ORDER BY artist_display_bio ASC);

DROP TABLE IF EXISTS artiste;
CREATE TABLE artiste
(
    artist_display_name VARCHAR,
    constituent_id      INTEGER,
    bio INTEGER,
    PRIMARY KEY (artist_display_name, constituent_id),
    FOREIGN KEY (bio) REFERENCES artiste_bio(id_bio)

);
INSERT INTO artiste(artist_display_name, constituent_id) (SELECT DISTINCT artist_display_name, constituent_id
                                                          FROM tableinitiale
                                                          where artist_display_bio is not null
                                                          ORDER BY artist_display_name ASC);

DROP TABLE IF EXISTS artiste_data;
CREATE TABLE artiste_data
(
    artist_prefix     VARCHAR,
    artist_suffix     VARCHAR,
    artist_alpha_sort VARCHAR,
    artist_bio        INTEGER,
    artist_url        INTEGER,
    artist_date       INTEGER,
    FOREIGN KEY (artist_url) REFERENCES artiste_url (id_url)
);

INSERT INTO artiste_data(artist_prefix, artist_suffix, artist_alpha_sort, artist_bio, artist_url,
                         artist_date) (SELECT distinct artist_prefix,
                                                       artist_suffix,
                                                       artist_alpha_sort,
                                                       artist_display_bio,
                                                       artist_ulan_url,
                                                       artist_begin_date
                                       FROM tableinitiale
                                       where constituent_id is not null
);

SELECT artist_nationality
from tableinitiale;

select *
from tableinitiale;





