--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ride_state; Type: TYPE; Schema: public; Owner: usher-db
--

CREATE TYPE public.ride_state AS ENUM (
    'CREATED',
    'RUNNING',
    'COMPLETED',
    'DELETED'
);


ALTER TYPE public.ride_state OWNER TO "usher-db";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: usher-db
--

CREATE TABLE public.reviews (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    ride_id uuid NOT NULL,
    driver_review text,
    user_review text,
    driver_stars integer,
    user_stars integer,
    user_review_created_at timestamp without time zone,
    driver_review_created_at timestamp without time zone,
    CONSTRAINT reviews_driver_stars_check CHECK (((driver_stars > 0) AND (driver_stars < 6))),
    CONSTRAINT reviews_user_stars_check CHECK (((user_stars > 0) AND (user_stars < 6)))
);


ALTER TABLE public.reviews OWNER TO "usher-db";

--
-- Name: rides; Type: TABLE; Schema: public; Owner: usher-db
--

CREATE TABLE public.rides (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    driver_id uuid,
    start_lat double precision,
    start_lon double precision,
    end_lat double precision,
    end_lon double precision,
    state public.ride_state DEFAULT 'CREATED'::public.ride_state NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    ended_at timestamp without time zone
);


ALTER TABLE public.rides OWNER TO "usher-db";

--
-- Name: users; Type: TABLE; Schema: public; Owner: usher-db
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying(254),
    hashed_password character varying(256),
    name character varying(100),
    last_name character varying(100),
    driver boolean,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO "usher-db";

--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: usher-db
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_ride_id_key; Type: CONSTRAINT; Schema: public; Owner: usher-db
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_ride_id_key UNIQUE (ride_id);


--
-- Name: rides rides_pkey; Type: CONSTRAINT; Schema: public; Owner: usher-db
--

ALTER TABLE ONLY public.rides
    ADD CONSTRAINT rides_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: usher-db
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: usher-db
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_ride_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: usher-db
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_ride_id_fkey FOREIGN KEY (ride_id) REFERENCES public.rides(id);


--
-- Name: rides rides_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: usher-db
--

ALTER TABLE ONLY public.rides
    ADD CONSTRAINT rides_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: rides rides_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: usher-db
--

ALTER TABLE ONLY public.rides
    ADD CONSTRAINT rides_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

