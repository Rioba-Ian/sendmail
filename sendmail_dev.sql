--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id bigint NOT NULL,
    name character varying(255),
    email character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: mails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mails (
    id bigint NOT NULL,
    subject character varying(255),
    body character varying(255),
    contact_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.mails OWNER TO postgres;

--
-- Name: mails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mails_id_seq OWNER TO postgres;

--
-- Name: mails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mails_id_seq OWNED BY public.mails.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email public.citext NOT NULL,
    hashed_password character varying(255) NOT NULL,
    confirmed_at timestamp(0) without time zone,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    msisdn character varying(255),
    role character varying(255) DEFAULT 'user'::character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token bytea NOT NULL,
    context character varying(255) NOT NULL,
    sent_to character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users_tokens OWNER TO postgres;

--
-- Name: users_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_tokens_id_seq OWNER TO postgres;

--
-- Name: users_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_tokens_id_seq OWNED BY public.users_tokens.id;


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: mails id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mails ALTER COLUMN id SET DEFAULT nextval('public.mails_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens ALTER COLUMN id SET DEFAULT nextval('public.users_tokens_id_seq'::regclass);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, name, email, inserted_at, updated_at, user_id) FROM stdin;
2	Ian test 1	iantest1@gmail.com	2023-08-22 14:09:40	2023-08-22 14:09:40	\N
3	Ian test 2 new contact	riobafelix@gmail.com	2023-08-23 11:08:17	2023-08-23 11:08:17	\N
4	email contacts	email@gmail.com	2023-08-23 11:47:34	2023-08-23 11:47:34	\N
5	name 1	name@email.com	2023-08-23 11:51:19	2023-08-23 11:51:19	4
\.


--
-- Data for Name: mails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mails (id, subject, body, contact_id, inserted_at, updated_at, user_id) FROM stdin;
1	test mail 1 subject	test body of mail 1 subject	\N	2023-08-22 14:14:47	2023-08-22 14:14:47	\N
2	Testing 	long text body about 500chars	\N	2023-08-23 11:09:57	2023-08-23 11:09:57	\N
3	subject 1	body 1	\N	2023-08-23 11:14:31	2023-08-23 11:14:31	\N
4	sub 1	body 1	\N	2023-08-23 11:47:54	2023-08-23 11:47:54	4
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20230822132532	2023-08-22 13:30:01
20230822132928	2023-08-22 13:30:01
20230823060904	2023-08-23 06:09:21
20230823062552	2023-08-23 06:27:19
20230823063425	2023-08-23 06:36:10
20230823065518	2023-08-23 06:56:25
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, confirmed_at, inserted_at, updated_at, first_name, last_name, msisdn, role) FROM stdin;
1	test@gmail.com	$2b$12$f4Hpv.pXwF5QCbCiSkgtC.Zn8wqBc1R0hvvmfiL3FQY7VJX5QoQvu	\N	2023-08-23 06:27:40	2023-08-23 06:27:40	Rioba test 1	Ian test 1	123456	user
2	admin@rioba.com	$2b$12$eEu6XPVkM.vfGM6O62pNzuKKpc.yr2ghbsqq/lFVzMLU5UOOpN.rC	\N	2023-08-23 09:13:32	2023-08-23 09:13:32	admin1	admin name 2	12345678	admin
3	test2@gmail.com	$2b$12$NO5YIpl32dI2FOeZe9ny4.sNOEWCrEUF9buSRZmCcRzKBGcqiN0/2	\N	2023-08-23 11:07:41	2023-08-23 11:07:41	Ian test 2	Rioba test 2	654321	user
4	mozillatest@gmailc.com	$2b$12$0WwqGiFNwI7dcljHeoGT.uRrjofiCuSnXK4HEE9Jjz6yYTArVhh56	\N	2023-08-23 11:13:56	2023-08-23 11:13:56	mozilla	test	98090	user
\.


--
-- Data for Name: users_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_tokens (id, user_id, token, context, sent_to, inserted_at) FROM stdin;
1	1	\\xf526d0a988bcab7c46a2d7e6fecfcd038299ff9fb745057ff3680b168d691498	confirm	test@gmail.com	2023-08-23 06:27:40
5	2	\\x012445e3a36e0e04561c4125a52ffb39e55d09f073f55b5becbb497819c82bee	session	\N	2023-08-23 09:38:34
6	3	\\xb6b353fa75da1f5bb30b827203a7dbed478f2038e08c016b5224b978aee49639	confirm	test2@gmail.com	2023-08-23 11:07:41
8	3	\\x5765645427348d45397edf37c521dcb289971fa8de375c637d8bc40be648d0b6	session	\N	2023-08-23 11:10:50
9	4	\\x570ac21f18931463687ce9dac84b97027e075d1f2eae69510a2397efc4d75581	confirm	mozillatest@gmailc.com	2023-08-23 11:13:56
10	4	\\xb47674bca0ac5cc249905e904f2079c26ce34a8966ccf009f8518e9e1950dc70	session	\N	2023-08-23 11:13:56
\.


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_seq', 5, true);


--
-- Name: mails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mails_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: users_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_tokens_id_seq', 10, true);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: mails mails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mails
    ADD CONSTRAINT mails_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_tokens users_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_pkey PRIMARY KEY (id);


--
-- Name: contacts_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contacts_user_id_index ON public.contacts USING btree (user_id);


--
-- Name: mails_contact_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mails_contact_id_index ON public.mails USING btree (contact_id);


--
-- Name: mails_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mails_user_id_index ON public.mails USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: users_tokens_context_token_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_tokens_context_token_index ON public.users_tokens USING btree (context, token);


--
-- Name: users_tokens_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_tokens_user_id_index ON public.users_tokens USING btree (user_id);


--
-- Name: contacts contacts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: mails mails_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mails
    ADD CONSTRAINT mails_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contacts(id);


--
-- Name: mails mails_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mails
    ADD CONSTRAINT mails_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_tokens users_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

