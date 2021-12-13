truncate tableinitiale;

DROP TABLE IF EXISTS objects,parametre_object,geography_data,medium, credit_line , geography_type,city ,country,county,department , other ,locus,meta_data , tags,culture, repository;

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

CREATE TABLE department
(
    gallery_number serial PRIMARY KEY,
    department     VARCHAR
);
CREATE TABLE culture
(
    culture VARCHAR PRIMARY KEY
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
CREATE TABLE tags
(

    tags VARCHAR PRIMARY KEY
);


CREATE TABLE locus
(
    locus VARCHAR PRIMARY KEY
);

CREATE TABLE other
(
    id_other                SERIAL PRIMARY KEY,
    classification          VARCHAR,
    excavation              VARCHAR,
    river                   VARCHAR,
    rights_and_reproduction VARCHAR,
    locus                   VARCHAR,
    FOREIGN KEY (locus) REFERENCES locus (locus)
);
CREATE TABLE repository
(
    repository VARCHAR PRIMARY KEY
);
CREATE TABLE meta_data
(
    id_meta_data        SERIAL PRIMARY KEY,
    link_resource       VARCHAR,
    object_wikidata_url VARCHAR,
    metadata_date       VARCHAR,
    tags_aat_url        VARCHAR,
    tags_wikidata_url   VARCHAR,
    repository          VARCHAR,
    tags                VARCHAR,
    other               INTEGER,
    FOREIGN KEY (repository) REFERENCES repository (repository),
    FOREIGN KEY (tags) REFERENCES tags (tags),
    FOREIGN KEY (other) REFERENCES other (id_other)
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
    meta_data         INTEGER,
    other             INTEGER,
    FOREIGN KEY (medium) REFERENCES medium (medium),
    FOREIGN KEY (credit) REFERENCES credit_line (credit_line),
    FOREIGN KEY (geography_data) REFERENCES geography_data (id_country),
    FOREIGN KEY (meta_data) REFERENCES meta_data (id_meta_data),
    FOREIGN KEY (other) REFERENCES other (id_other)
);

CREATE TABLE objects
(
    id_objects       SERIAL PRIMARY KEY,
    object_name      VARCHAR,
    title            VARCHAR,
    accessionyear    INTEGER,
    culture          VARCHAR,
    parametre_object INTEGER,
    gallery          INTEGER,
    FOREIGN KEY (culture) REFERENCES culture (culture),
    FOREIGN KEY (parametre_object) REFERENCES parametre_object (object_id),
    FOREIGN KEY (gallery) REFERENCES department (gallery_number)
);


INSERT INTO medium(SELECT DISTINCT medium FROM tableinitiale WHERE medium IS NOT NULL);

INSERT INTO credit_line(SELECT DISTINCT credit_line FROM tableinitiale WHERE credit_line is not null);

INSERT INTO geography_type(SELECT DISTINCT geography_type FROM tableinitiale WHERE geography_type is not null);

INSERT INTO city(SELECT DISTINCT city FROM tableinitiale WHERE city is not null);

INSERT INTO country(SELECT DISTINCT country FROM tableinitiale WHERE country is not null);

INSERT INTO county(SELECT DISTINCT county FROM tableinitiale WHERE county is not null);

INSERT INTO department(department)(SELECT Distinct department
                                   from tableinitiale);
INSERT INTO culture(culture)(SELECT DISTINCT culture FROM tableinitiale where culture is not NULL);

INSERT INTO geography_data(region, subregion, locate, county, city, country, geography_type) (SELECT DISTINCT region,
                                                                                                              subregion,
                                                                                                              locale,
                                                                                                              county,
                                                                                                              city,
                                                                                                              country,
                                                                                                              geography_type
                                                                                              FROM tableinitiale);

INSERT INTO tags(SELECT distinct tags from tableinitiale where tags is not null);

INSERT INTO locus(locus)(SELECT DISTINCT locus FROM tableinitiale WHERE locus IS NOT NULL);

INSERT INTO other(SELECT DISTINCT classification,
                                  excavation,
                                  river,
                                  rights_and_reproduction,
                                  locus
                  FROM tableinitiale
                  WHERE classification is not null);

INSERT INTO repository (select DISTINCT repository FROM tableinitiale where repository is not null);

INSERT INTO meta_data(link_resource, object_wikidata_url, metadata_date, tags_aat_url, tags_wikidata_url, repository,
                      tags) (SELECT DISTINCT link_resource,
                                             object_wikidata_url,
                                             metadata_date,
                                             tags_aat_url,
                                             tags_wikidata_url,
                                             repository,
                                             tags
                             FROM tableinitiale);


INSERT INTO parametre_object (SELECT DISTINCT object_id,
                                              object_id,
                                              object_number,
                                              is_highlight,
                                              is_timeline_work,
                                              is_public_domain,
                                              object_date,
                                              object_begin_date,
                                              object_end_date,
                                              dimensions,
                                              medium,
                                              credit,
                                              geography_data,
                                              meta_data
                              from tableinitiale);

INSERT INTO objects(object_name, title, accessionyear, culture, parametre_object, gallery) (SELECT DISTINCT object_name,
                                                                                                            title,
                                                                                                            accessionyear,
                                                                                                            culture,
                                                                                                            parametre_object,
                                                                                                            gallery
                                                                                            FROM tableinitiale);


-- A finir


DROP TABLE IF EXISTS artiste , artiste_data;

CREATE TABLE artiste_data
(
    artist_display_name VARCHAR PRIMARY KEY,
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
INSERT INTO artiste_data(SELECT distinct artist_name,
                                         artist_display_bio,
                                         artist_suffix,
                                         artist_alpha_sort,
                                         artist_nationality,
                                         artist_begin_date,
                                         artist_end_date,
                                         artist_gender,
                                         artist_ulan_url,
                                         artist_wikidata_url
                         FROM (select distinct  artist_display_name from tableinitiale)artist_name ,tableinitiale);


CREATE TABLE artiste
(
    id_artiste          SERIAL PRIMARY KEY,
    artist_display_name VARCHAR,
    artist_role         VARCHAR,
    artist_prefix       VARCHAR,
    FOREIGN KEY (artist_display_name) REFERENCES artiste_data (artist_display_name)
);

INSERT INTO artiste(artist_display_name, artist_role, artist_prefix) (SELECT distinct artist_display_name, artist_role, artist_prefix
                                                                      FROM tableinitiale
                                                                      where artist_display_name is not null
);



SELECT * from tableinitiale;

select count(*)from tableinitiale;

select pg_size_pretty(pg_relation_size('tableinitiale'))
