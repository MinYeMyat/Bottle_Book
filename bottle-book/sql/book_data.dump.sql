--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Homebrew)
-- Dumped by pg_dump version 15.4

-- Started on 2023-10-31 11:33:17 JST

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16407)
-- Name: book; Type: TABLE; Schema: public; Owner: book_user
--

CREATE TABLE public.book (
    id integer NOT NULL,
    name character varying(255),
    volume character varying(255),
    author character varying(255),
    publisher character varying(255),
    memo text,
    create_date timestamp with time zone NOT NULL,
    del boolean
);


ALTER TABLE public.book OWNER TO book_user;

--
-- TOC entry 215 (class 1259 OID 16406)
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: book_user
--

CREATE SEQUENCE public.book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.book_id_seq OWNER TO book_user;

--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 215
-- Name: book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: book_user
--

ALTER SEQUENCE public.book_id_seq OWNED BY public.book.id;


--
-- TOC entry 214 (class 1259 OID 16390)
-- Name: book_user; Type: TABLE; Schema: public; Owner: book_user
--

CREATE TABLE public.book_user (
    user_id character varying(255) NOT NULL,
    passwd character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    user_shi character varying(255),
    user_mei character varying(255),
    del boolean
);


ALTER TABLE public.book_user OWNER TO book_user;

--
-- TOC entry 3465 (class 2604 OID 16410)
-- Name: book id; Type: DEFAULT; Schema: public; Owner: book_user
--

ALTER TABLE ONLY public.book ALTER COLUMN id SET DEFAULT nextval('public.book_id_seq'::regclass);


--
-- TOC entry 3614 (class 0 OID 16407)
-- Dependencies: 216
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: book_user
--

COPY public.book (id, name, volume, author, publisher, memo, create_date, del) FROM stdin;
1	aa	bb	cc	dd	aa	2023-10-25 14:58:55.127866+09	f
2	pyhton	1000	steven	SB	pyhton	2023-10-26 13:27:41.739987+09	f
3	java	1000000	sun	sun	excellent	2023-10-26 13:28:58.014921+09	f
\.


--
-- TOC entry 3612 (class 0 OID 16390)
-- Dependencies: 214
-- Data for Name: book_user; Type: TABLE DATA; Schema: public; Owner: book_user
--

COPY public.book_user (user_id, passwd, email, user_shi, user_mei, del) FROM stdin;
ye	402590	minyemyat99@gmail.com	min	ye myat	f
\.


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 215
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: book_user
--

SELECT pg_catalog.setval('public.book_id_seq', 3, true);


--
-- TOC entry 3469 (class 2606 OID 16414)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: book_user
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- TOC entry 3467 (class 2606 OID 16396)
-- Name: book_user book_user_pkey; Type: CONSTRAINT; Schema: public; Owner: book_user
--

ALTER TABLE ONLY public.book_user
    ADD CONSTRAINT book_user_pkey PRIMARY KEY (user_id);


-- Completed on 2023-10-31 11:33:18 JST

--
-- PostgreSQL database dump complete
--

