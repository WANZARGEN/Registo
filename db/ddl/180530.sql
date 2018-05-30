CREATE TABLE baccount
(
id integer NOT NULL AUTO_INCREMENT,
alias varchar(30) NOT NULL,
number integer NOT NULL,
bank varchar(15) NOT NULL,
balance integer NOT NULL DEFAULT 0,
usr_id integer NOT NULL,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_baccount PRIMARY KEY (id)
)
;

CREATE TABLE card
(
id integer NOT NULL AUTO_INCREMENT,
alias varchar(30) NOT NULL,
number integer NOT NULL,
company varchar(15) NOT NULL,
usr_id integer NOT NULL,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_card PRIMARY KEY (id)
)
;

CREATE TABLE card_bacc
(
id integer NOT NULL AUTO_INCREMENT,
datetime datetime,
bacc_id integer,
card_id integer NOT NULL,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_card_bacc PRIMARY KEY (id)
)
;

CREATE TABLE category
(
id integer NOT NULL AUTO_INCREMENT,
name varchar(15) NOT NULL,
CONSTRAINT pk_category PRIMARY KEY (id)
)
;

CREATE TABLE ch_memb
(
id integer NOT NULL AUTO_INCREMENT,
ch_id integer NOT NULL,
usr_id integer NOT NULL,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_ch_memb PRIMARY KEY (id)
)
;

CREATE TABLE channel
(
id integer NOT NULL AUTO_INCREMENT,
leader_id integer NOT NULL,
name varchar(20) NOT NULL,
card_id integer,
bacc_id integer,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_channel PRIMARY KEY (id)
)
;

CREATE TABLE installment
(
row_id integer NOT NULL,
month integer NOT NULL,
total integer NOT NULL,
interest integer NOT NULL DEFAULT 0,
remains integer,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_installment PRIMARY KEY (row_id)
)
;

CREATE TABLE row
(
id integer NOT NULL AUTO_INCREMENT,
date date NOT NULL,
time time NOT NULL,
amount integer NOT NULL,
comment varchar(50) NOT NULL,
currency varchar(5) NOT NULL DEFAULT 'KRW',
type varchar(1) COMMENT '\'E\' or \'I\' is available.\n\'E\' is for expense, and \'I\' is for income.\n',
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_row PRIMARY KEY (id)
)
;

CREATE TABLE row_cat
(
row_id integer NOT NULL,
cat_id integer NOT NULL,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_row_cat PRIMARY KEY (row_id, cat_id)
)
;

CREATE TABLE row_memb
(
memb_id integer NOT NULL,
row_id integer NOT NULL,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_row_memb PRIMARY KEY (memb_id, row_id)
)
;

CREATE TABLE row_tag
(
exp_id integer NOT NULL AUTO_INCREMENT,
tag_id integer NOT NULL,
active tinyint DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_row_tag PRIMARY KEY (exp_id, tag_id)
)
;

CREATE TABLE tag
(
id integer NOT NULL AUTO_INCREMENT,
name varchar(15) NOT NULL,
cat_id integer NOT NULL,
CONSTRAINT pk_tag PRIMARY KEY (id)
)
;

CREATE TABLE user
(
id integer NOT NULL AUTO_INCREMENT,
email varchar(50) NOT NULL,
password varchar(50) NOT NULL,
active tinyint NOT NULL DEFAULT 1 COMMENT '1: active\n0: inactive\n',
CONSTRAINT pk_user PRIMARY KEY (id)
)
;

ALTER TABLE baccount ADD CONSTRAINT fk_baccount_usr_id
FOREIGN KEY (usr_id) REFERENCES user (id)
;

ALTER TABLE card ADD CONSTRAINT fk_card_usr_id
FOREIGN KEY (usr_id) REFERENCES user (id)
;

ALTER TABLE card_bacc ADD CONSTRAINT fk_card_bacc_bacc_id
FOREIGN KEY (bacc_id) REFERENCES baccount (id)
;

ALTER TABLE card_bacc ADD CONSTRAINT fk_card_bacc_card_id
FOREIGN KEY (card_id) REFERENCES card (id)
;

ALTER TABLE ch_memb ADD CONSTRAINT fk_ch_memb_ch_id
FOREIGN KEY (ch_id) REFERENCES channel (id)
;

ALTER TABLE ch_memb ADD CONSTRAINT fk_ch_memb_usr_id
FOREIGN KEY (usr_id) REFERENCES user (id)
;

ALTER TABLE installment ADD CONSTRAINT fk_installment_row_id
FOREIGN KEY (row_id) REFERENCES row (id)
;

ALTER TABLE row_cat ADD CONSTRAINT fk_row_cat_cat_id
FOREIGN KEY (cat_id) REFERENCES category (id)
;

ALTER TABLE row_cat ADD CONSTRAINT fk_row_cat_row_id
FOREIGN KEY (row_id) REFERENCES row (id)
;

ALTER TABLE row_memb ADD CONSTRAINT fk_row_memb_memb_id
FOREIGN KEY (memb_id) REFERENCES ch_memb (id)
;

ALTER TABLE row_memb ADD CONSTRAINT fk_row_memb_row_id
FOREIGN KEY (row_id) REFERENCES row (id)
;

ALTER TABLE row_tag ADD CONSTRAINT fk_row_tag_row_id
FOREIGN KEY (exp_id) REFERENCES row (id)
;

ALTER TABLE row_tag ADD CONSTRAINT fk_row_tag_tag_id
FOREIGN KEY (tag_id) REFERENCES tag (id)
;

ALTER TABLE tag ADD CONSTRAINT fk_tag_cat_id
FOREIGN KEY (cat_id) REFERENCES category (id)
;

CREATE UNIQUE INDEX ix_category_name
ON category (name)
;

CREATE UNIQUE INDEX ix_tag_name
ON tag (name)
;

CREATE UNIQUE INDEX ix_user_email
ON user (email)
;

show tables;