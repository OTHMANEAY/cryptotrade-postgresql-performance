--
-- PostgreSQL database dump
--

\restrict I7KTZYB6NzK7OdFd0rxdY1M0CMdwzeoWCOYzgy2NYZFnUejmewcUJYPcphwrSbn

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-24 16:21:58

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 227 (class 1259 OID 24967)
-- Name: audit_trail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_trail (
    id integer NOT NULL,
    table_cible character varying,
    record_id integer,
    action character varying(20),
    utilisateur_id integer,
    date_action date,
    details text
);


ALTER TABLE public.audit_trail OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24841)
-- Name: cryptomonnaies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cryptomonnaies (
    id integer NOT NULL,
    nom character varying,
    symbole character varying,
    date_creation date,
    statut character varying(10)
);


ALTER TABLE public.cryptomonnaies OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24982)
-- Name: detection_anomalie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detection_anomalie (
    id integer NOT NULL,
    type character varying,
    ordre_id integer,
    utilisateur_id integer,
    date_detection date,
    commentaire date
);


ALTER TABLE public.detection_anomalie OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24919)
-- Name: ordres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordres (
    id integer,
    utilisateur_id integer,
    paire_id integer,
    type_ordre integer,
    mode character varying,
    quantite numeric,
    prix numeric,
    statut character varying(10),
    date_creation date
);


ALTER TABLE public.ordres OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24863)
-- Name: paire_trading; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paire_trading (
    id integer NOT NULL,
    crypto_base_id integer,
    crypto_contre_id integer,
    statut character varying(10),
    date_ouverture date
);


ALTER TABLE public.paire_trading OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24833)
-- Name: portefeuille; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portefeuille (
    id integer NOT NULL,
    solde_total numeric,
    solde_bloque numeric,
    date_maj date,
    utulisateur_id integer,
    crypto_id integer
);


ALTER TABLE public.portefeuille OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24906)
-- Name: prix_marche; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prix_marche (
    id integer NOT NULL,
    paire_id integer,
    prix numeric(1000,0),
    volume numeric(1000,0),
    date_maj date
);


ALTER TABLE public.prix_marche OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24891)
-- Name: statistique_marche; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statistique_marche (
    id integer NOT NULL,
    paire_id integer,
    indicateur character varying,
    valeur numeric,
    periode character varying,
    date_maj date
);


ALTER TABLE public.statistique_marche OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24938)
-- Name: trades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trades (
    id integer NOT NULL,
    ordre_buy_id integer,
    ordre_sell_id integer,
    paire_id integer,
    prix numeric,
    quantite numeric,
    date_execution date
);


ALTER TABLE public.trades OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24827)
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateurs (
    id integer CONSTRAINT tblutilisateurs_id_not_null NOT NULL,
    nom integer,
    email integer,
    date_inscription date,
    statut character varying(10)
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- TOC entry 5059 (class 0 OID 24967)
-- Dependencies: 227
-- Data for Name: audit_trail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_trail (id, table_cible, record_id, action, utilisateur_id, date_action, details) FROM stdin;
\.


--
-- TOC entry 5053 (class 0 OID 24841)
-- Dependencies: 221
-- Data for Name: cryptomonnaies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cryptomonnaies (id, nom, symbole, date_creation, statut) FROM stdin;
\.


--
-- TOC entry 5060 (class 0 OID 24982)
-- Dependencies: 228
-- Data for Name: detection_anomalie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detection_anomalie (id, type, ordre_id, utilisateur_id, date_detection, commentaire) FROM stdin;
\.


--
-- TOC entry 5057 (class 0 OID 24919)
-- Dependencies: 225
-- Data for Name: ordres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordres (id, utilisateur_id, paire_id, type_ordre, mode, quantite, prix, statut, date_creation) FROM stdin;
\.


--
-- TOC entry 5054 (class 0 OID 24863)
-- Dependencies: 222
-- Data for Name: paire_trading; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paire_trading (id, crypto_base_id, crypto_contre_id, statut, date_ouverture) FROM stdin;
\.


--
-- TOC entry 5052 (class 0 OID 24833)
-- Dependencies: 220
-- Data for Name: portefeuille; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portefeuille (id, solde_total, solde_bloque, date_maj, utulisateur_id, crypto_id) FROM stdin;
\.


--
-- TOC entry 5056 (class 0 OID 24906)
-- Dependencies: 224
-- Data for Name: prix_marche; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prix_marche (id, paire_id, prix, volume, date_maj) FROM stdin;
\.


--
-- TOC entry 5055 (class 0 OID 24891)
-- Dependencies: 223
-- Data for Name: statistique_marche; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statistique_marche (id, paire_id, indicateur, valeur, periode, date_maj) FROM stdin;
\.


--
-- TOC entry 5058 (class 0 OID 24938)
-- Dependencies: 226
-- Data for Name: trades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trades (id, ordre_buy_id, ordre_sell_id, paire_id, prix, quantite, date_execution) FROM stdin;
\.


--
-- TOC entry 5051 (class 0 OID 24827)
-- Dependencies: 219
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateurs (id, nom, email, date_inscription, statut) FROM stdin;
\.


--
-- TOC entry 4881 (class 2606 OID 24974)
-- Name: audit_trail pk_audit_trail; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_trail
    ADD CONSTRAINT pk_audit_trail PRIMARY KEY (id);


--
-- TOC entry 4853 (class 2606 OID 24848)
-- Name: cryptomonnaies pk_cryptomonnaies; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cryptomonnaies
    ADD CONSTRAINT pk_cryptomonnaies PRIMARY KEY (id);


--
-- TOC entry 4885 (class 2606 OID 24989)
-- Name: detection_anomalie pk_detection_anomalie; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection_anomalie
    ADD CONSTRAINT pk_detection_anomalie PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 24868)
-- Name: paire_trading pk_paire_trading; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paire_trading
    ADD CONSTRAINT pk_paire_trading PRIMARY KEY (id);


--
-- TOC entry 4847 (class 2606 OID 24840)
-- Name: portefeuille pk_portefeuille; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portefeuille
    ADD CONSTRAINT pk_portefeuille PRIMARY KEY (id);


--
-- TOC entry 4865 (class 2606 OID 24911)
-- Name: prix_marche pk_prix_marche; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prix_marche
    ADD CONSTRAINT pk_prix_marche PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 24898)
-- Name: statistique_marche pk_statistique_marche; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique_marche
    ADD CONSTRAINT pk_statistique_marche PRIMARY KEY (id);


--
-- TOC entry 4845 (class 2606 OID 24832)
-- Name: utilisateurs pk_tblutilisateurs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT pk_tblutilisateurs PRIMARY KEY (id);


--
-- TOC entry 4873 (class 2606 OID 24945)
-- Name: trades pk_trades; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT pk_trades PRIMARY KEY (id);


--
-- TOC entry 4883 (class 2606 OID 24976)
-- Name: audit_trail unq_audit_trail_utilisateur_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_trail
    ADD CONSTRAINT unq_audit_trail_utilisateur_id UNIQUE (utilisateur_id);


--
-- TOC entry 4887 (class 2606 OID 24991)
-- Name: detection_anomalie unq_detection_anomalie_ordre_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection_anomalie
    ADD CONSTRAINT unq_detection_anomalie_ordre_id UNIQUE (ordre_id);


--
-- TOC entry 4889 (class 2606 OID 24998)
-- Name: detection_anomalie unq_detection_anomalie_utilisateur_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection_anomalie
    ADD CONSTRAINT unq_detection_anomalie_utilisateur_id UNIQUE (utilisateur_id);


--
-- TOC entry 4869 (class 2606 OID 24925)
-- Name: ordres unq_ordres_paire_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordres
    ADD CONSTRAINT unq_ordres_paire_id UNIQUE (paire_id);


--
-- TOC entry 4871 (class 2606 OID 24932)
-- Name: ordres unq_ordres_utilisateur_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordres
    ADD CONSTRAINT unq_ordres_utilisateur_id UNIQUE (utilisateur_id);


--
-- TOC entry 4857 (class 2606 OID 24870)
-- Name: paire_trading unq_paire_trading_crypto_base_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paire_trading
    ADD CONSTRAINT unq_paire_trading_crypto_base_id UNIQUE (crypto_base_id);


--
-- TOC entry 4859 (class 2606 OID 24877)
-- Name: paire_trading unq_paire_trading_crypto_contre_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paire_trading
    ADD CONSTRAINT unq_paire_trading_crypto_contre_id UNIQUE (crypto_contre_id);


--
-- TOC entry 4849 (class 2606 OID 24850)
-- Name: portefeuille unq_portefeuille_crypto_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portefeuille
    ADD CONSTRAINT unq_portefeuille_crypto_id UNIQUE (crypto_id);


--
-- TOC entry 4851 (class 2606 OID 24857)
-- Name: portefeuille unq_portefeuille_utulisateur_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portefeuille
    ADD CONSTRAINT unq_portefeuille_utulisateur_id UNIQUE (utulisateur_id);


--
-- TOC entry 4867 (class 2606 OID 24913)
-- Name: prix_marche unq_prix_marche_paire_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prix_marche
    ADD CONSTRAINT unq_prix_marche_paire_id UNIQUE (paire_id);


--
-- TOC entry 4863 (class 2606 OID 24900)
-- Name: statistique_marche unq_statistique_marche_paire_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique_marche
    ADD CONSTRAINT unq_statistique_marche_paire_id UNIQUE (paire_id);


--
-- TOC entry 4875 (class 2606 OID 24947)
-- Name: trades unq_trades_ordre_buy_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT unq_trades_ordre_buy_id UNIQUE (ordre_buy_id);


--
-- TOC entry 4877 (class 2606 OID 24954)
-- Name: trades unq_trades_ordre_sell_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT unq_trades_ordre_sell_id UNIQUE (ordre_sell_id);


--
-- TOC entry 4879 (class 2606 OID 24961)
-- Name: trades unq_trades_paire_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT unq_trades_paire_id UNIQUE (paire_id);


--
-- TOC entry 4894 (class 2606 OID 24871)
-- Name: cryptomonnaies fk_cryptomonnaies_paire_trading; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cryptomonnaies
    ADD CONSTRAINT fk_cryptomonnaies_paire_trading FOREIGN KEY (id) REFERENCES public.paire_trading(crypto_base_id);


--
-- TOC entry 4895 (class 2606 OID 24878)
-- Name: cryptomonnaies fk_cryptomonnaies_paire_trading_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cryptomonnaies
    ADD CONSTRAINT fk_cryptomonnaies_paire_trading_0 FOREIGN KEY (id) REFERENCES public.paire_trading(crypto_contre_id);


--
-- TOC entry 4896 (class 2606 OID 24851)
-- Name: cryptomonnaies fk_cryptomonnaies_portefeuille; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cryptomonnaies
    ADD CONSTRAINT fk_cryptomonnaies_portefeuille FOREIGN KEY (id) REFERENCES public.portefeuille(crypto_id);


--
-- TOC entry 4901 (class 2606 OID 24992)
-- Name: ordres fk_ordres_detection_anomalie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordres
    ADD CONSTRAINT fk_ordres_detection_anomalie FOREIGN KEY (id) REFERENCES public.detection_anomalie(ordre_id);


--
-- TOC entry 4902 (class 2606 OID 24948)
-- Name: ordres fk_ordres_trades; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordres
    ADD CONSTRAINT fk_ordres_trades FOREIGN KEY (id) REFERENCES public.trades(ordre_buy_id);


--
-- TOC entry 4903 (class 2606 OID 24955)
-- Name: ordres fk_ordres_trades_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordres
    ADD CONSTRAINT fk_ordres_trades_0 FOREIGN KEY (id) REFERENCES public.trades(ordre_sell_id);


--
-- TOC entry 4897 (class 2606 OID 24926)
-- Name: paire_trading fk_paire_trading_ordres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paire_trading
    ADD CONSTRAINT fk_paire_trading_ordres FOREIGN KEY (id) REFERENCES public.ordres(paire_id);


--
-- TOC entry 4898 (class 2606 OID 24914)
-- Name: paire_trading fk_paire_trading_prix_marche; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paire_trading
    ADD CONSTRAINT fk_paire_trading_prix_marche FOREIGN KEY (id) REFERENCES public.prix_marche(paire_id);


--
-- TOC entry 4899 (class 2606 OID 24901)
-- Name: paire_trading fk_paire_trading_statistique_marche; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paire_trading
    ADD CONSTRAINT fk_paire_trading_statistique_marche FOREIGN KEY (id) REFERENCES public.statistique_marche(paire_id);


--
-- TOC entry 4900 (class 2606 OID 24962)
-- Name: paire_trading fk_paire_trading_trades; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paire_trading
    ADD CONSTRAINT fk_paire_trading_trades FOREIGN KEY (id) REFERENCES public.trades(paire_id);


--
-- TOC entry 4890 (class 2606 OID 24977)
-- Name: utilisateurs fk_utilisateurs_audit_trail; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT fk_utilisateurs_audit_trail FOREIGN KEY (id) REFERENCES public.audit_trail(utilisateur_id);


--
-- TOC entry 4891 (class 2606 OID 24999)
-- Name: utilisateurs fk_utilisateurs_detection_anomalie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT fk_utilisateurs_detection_anomalie FOREIGN KEY (id) REFERENCES public.detection_anomalie(utilisateur_id);


--
-- TOC entry 4892 (class 2606 OID 24933)
-- Name: utilisateurs fk_utilisateurs_ordres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT fk_utilisateurs_ordres FOREIGN KEY (id) REFERENCES public.ordres(utilisateur_id);


--
-- TOC entry 4893 (class 2606 OID 24858)
-- Name: utilisateurs fk_utilisateurs_portefeuille; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT fk_utilisateurs_portefeuille FOREIGN KEY (id) REFERENCES public.portefeuille(utulisateur_id);


-- Completed on 2025-12-24 16:21:58

--
-- PostgreSQL database dump complete
--

\unrestrict I7KTZYB6NzK7OdFd0rxdY1M0CMdwzeoWCOYzgy2NYZFnUejmewcUJYPcphwrSbn

