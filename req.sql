--Table qui contient les paramètre des objetcs

DROP TABLE IF EXISTS parametre_object,geography_data,medium, credit_line , geography_type,city ,country,county;

CREATE TABLE medium
(
    medium VARCHAR PRIMARY KEY
);

CREATE TABLE credit_line
(
    credit_line VARCHAR PRIMARY KEY
);
CREATE TABLE geography_type
(
    geography_type VARCHAR PRIMARY KEY
);

CREATE TABLE city
(
    city VARCHAR PRIMARY KEY
);

CREATE table country
(
    country VARCHAR PRIMARY KEY
);

CREATE TABLE county
(
    county VARCHAR PRIMARY KEY
);

CREATE TABLE geography_data
(
    id_country     SERIAL PRIMARY KEY,
    region         VARCHAR,
    subregion      VARCHAR,
    locate         VARCHAR,
    county         VARCHAR,
    city           VARCHAR,
    country        VARCHAR,
    geography_type VARCHAR,
    FOREIGN KEY (county) REFERENCES county (county),
    FOREIGN KEY (country) REFERENCES country (country),
    FOREIGN KEY (city) REFERENCES city (city),
    FOREIGN KEY (geography_type) REFERENCES geography_type (geography_type)
);

CREATE TABLE parametre_object
(
    object_id         INTEGER NOT NULL PRIMARY KEY,
    object_number     VARCHAR NOT NULL,
    is_highlight      BOOLEAN NOT NULL,
    is_timeline_work  BOOLEAN NOT NULL,
    is_public_domain  BOOLEAN NOT NULL,
    object_date       VARCHAR,
    object_begin_date INTEGER,
    object_end_date   INTEGER,
    dimensions        VARCHAR,
    medium            VARCHAR,
    credit            VARCHAR,
    geography_data    INTEGER,
    FOREIGN KEY (medium) REFERENCES medium (medium),
    FOREIGN KEY (credit) REFERENCES credit_line (credit_line),
    FOREIGN KEY (geography_data) REFERENCES geography_data (id_country)
);

INSERT INTO medium(SELECT DISTINCT medium FROM tableinitiale WHERE medium IS NOT NULL);

INSERT INTO credit_line(SELECT DISTINCT credit_line FROM tableinitiale WHERE credit_line is not null);

INSERT INTO geography_type(SELECT DISTINCT geography_type FROM tableinitiale WHERE geography_type is not null);

INSERT INTO city(SELECT DISTINCT city FROM tableinitiale WHERE city is not null);

INSERT INTO country(SELECT DISTINCT country FROM tableinitiale WHERE country is not null);

INSERT INTO county(SELECT DISTINCT county FROM tableinitiale WHERE county is not null);

INSERT INTO geography_data(SELECT DISTINCT geography_data FROM tableinitiale);

INSERT INTO parametre_object (SELECT DISTINCT object_id, object_number, is_highlight, is_timeline_work, is_public_domain
                              from tableinitiale);


-- A finir

-- Les différents département
DROP TABLE IF EXISTS department;
CREATE TABLE department
(
    gallery_number serial PRIMARY KEY,
    department     VARCHAR
);

INSERT INTO department(department)(SELECT Distinct department
                                   from tableinitiale);

DROP TABLE IF EXISTS other;
CREATE TABLE other
(
    id_other                SERIAL PRIMARY KEY,
    locus                   VARCHAR,
    excavation              VARCHAR,
    river                   VARCHAR,
    classification          VARCHAR,
    rights_and_reproduction VARCHAR
);

DROP TABLE IF EXISTS meta_data;
CREATE TABLE meta_data
(
    id_meta_data        SERIAL PRIMARY KEY,
    link_resource       VARCHAR,
    object_wikidata_url VARCHAR,
    metadata_date       VARCHAR,
    repository          VARCHAR,
    tags                VARCHAR,
    tags_aat_url        VARCHAR,
    tags_wikidata_url   VARCHAR
);

--Table des différentes culture
DROP TABLE IF EXISTS culture;
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


DROP TABLE IF EXISTS artiste_data;
CREATE TABLE artiste_data
(
    id_artiste          SERIAL PRIMARY KEY,
    artist_role         VARCHAR,
    artist_prefix       VARCHAR,
    artist_display_name VARCHAR,
    artist_display_bio  VARCHAR,
    artist_suffix       VARCHAR,
    artist_alpha_sort   VARCHAR,
    artist_nationality  VARCHAR,
    artist_begin_date   VARCHAR,
    artist_end_date     VARCHAR,
    artist_gender       VARCHAR,
    artist_ulan_url     VARCHAR,
    artist_wikidata_url VARCHAR

);
INSERT INTO artiste_data(artist_role, artist_prefix, artist_display_name, artist_display_bio, artist_suffix,
                         artist_alpha_sort, artist_nationality, artist_begin_date, artist_end_date, artist_gender,
                         artist_ulan_url, artist_wikidata_url) (SELECT distinct artist_role,
                                                                                artist_prefix,
                                                                                artist_display_name,
                                                                                artist_display_bio,
                                                                                artist_suffix,
                                                                                artist_alpha_sort,
                                                                                artist_nationality,
                                                                                artist_begin_date,
                                                                                artist_end_date,
                                                                                artist_gender,
                                                                                artist_ulan_url,
                                                                                artist_wikidata_url
                                                                FROM tableinitiale
                                                                where artist_display_name is not null
);


select *
from tableinitiale;


select count(locus)
from tableinitiale
