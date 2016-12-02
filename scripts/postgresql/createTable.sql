-- Table: public.thunderset

DROP TABLE public.thunderset;

CREATE TABLE public.thunderset
(
  id character varying NOT NULL,
  dd character varying,
  mm character varying,
  yyyy character varying,
  institute numeric,
  gender numeric,
  ct numeric,
  cn numeric,
  ff date,
  lf date,
  who numeric,
  date_intake character varying,
  dob date,
  total_dose numeric,
  surgery character varying,
  surgery_type character varying,
  pt character varying,
  pn character varying,
  wait_and_see character varying,
  age character varying,
  trg character varying,
  surgery_date character varying,
  CONSTRAINT id_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.thunderset
  OWNER TO postgres;