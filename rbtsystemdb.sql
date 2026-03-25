--
-- PostgreSQL database dump
--

\restrict MEPPfEWfOiHRzCcorubfElfh18zpIJBGmTkfUDKNbiEhsY2gtHZ8JXwdPFmHVAk

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-03-25 13:36:24

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
-- TOC entry 239 (class 1259 OID 83249)
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    user_id bigint,
    action character varying(100) NOT NULL,
    ip_address character varying(45),
    user_agent character varying(500),
    metadata jsonb,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.audit_logs OWNER TO super_admin;

--
-- TOC entry 238 (class 1259 OID 83248)
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_logs_id_seq OWNER TO super_admin;

--
-- TOC entry 5199 (class 0 OID 0)
-- Dependencies: 238
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- TOC entry 241 (class 1259 OID 83267)
-- Name: branches; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.branches (
    id bigint NOT NULL,
    branch_name character varying(255) NOT NULL,
    brak character varying(255) NOT NULL,
    brcode character varying(255) NOT NULL,
    parent_id bigint,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.branches OWNER TO super_admin;

--
-- TOC entry 240 (class 1259 OID 83266)
-- Name: branches_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.branches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branches_id_seq OWNER TO super_admin;

--
-- TOC entry 5200 (class 0 OID 0)
-- Dependencies: 240
-- Name: branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.branches_id_seq OWNED BY public.branches.id;


--
-- TOC entry 225 (class 1259 OID 83115)
-- Name: cache; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache OWNER TO super_admin;

--
-- TOC entry 226 (class 1259 OID 83126)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO super_admin;

--
-- TOC entry 231 (class 1259 OID 83168)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO super_admin;

--
-- TOC entry 230 (class 1259 OID 83167)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO super_admin;

--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 229 (class 1259 OID 83153)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO super_admin;

--
-- TOC entry 228 (class 1259 OID 83138)
-- Name: jobs; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO super_admin;

--
-- TOC entry 227 (class 1259 OID 83137)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO super_admin;

--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 220 (class 1259 OID 83063)
-- Name: migrations; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO super_admin;

--
-- TOC entry 219 (class 1259 OID 83062)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO super_admin;

--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 250 (class 1259 OID 83370)
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO super_admin;

--
-- TOC entry 251 (class 1259 OID 83384)
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO super_admin;

--
-- TOC entry 223 (class 1259 OID 83094)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO super_admin;

--
-- TOC entry 247 (class 1259 OID 83343)
-- Name: permissions; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO super_admin;

--
-- TOC entry 246 (class 1259 OID 83342)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO super_admin;

--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 246
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- TOC entry 237 (class 1259 OID 83232)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO super_admin;

--
-- TOC entry 236 (class 1259 OID 83231)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO super_admin;

--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 236
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 252 (class 1259 OID 83398)
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO super_admin;

--
-- TOC entry 249 (class 1259 OID 83357)
-- Name: roles; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO super_admin;

--
-- TOC entry 248 (class 1259 OID 83356)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO super_admin;

--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 248
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 224 (class 1259 OID 83103)
-- Name: sessions; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO super_admin;

--
-- TOC entry 243 (class 1259 OID 83300)
-- Name: system_permissions; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.system_permissions (
    id bigint NOT NULL,
    system_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "group" character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.system_permissions OWNER TO super_admin;

--
-- TOC entry 242 (class 1259 OID 83299)
-- Name: system_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.system_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_permissions_id_seq OWNER TO super_admin;

--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 242
-- Name: system_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.system_permissions_id_seq OWNED BY public.system_permissions.id;


--
-- TOC entry 245 (class 1259 OID 83320)
-- Name: system_role_permissions; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.system_role_permissions (
    id bigint NOT NULL,
    system_id bigint NOT NULL,
    role character varying(255) NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.system_role_permissions OWNER TO super_admin;

--
-- TOC entry 244 (class 1259 OID 83319)
-- Name: system_role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.system_role_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_role_permissions_id_seq OWNER TO super_admin;

--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 244
-- Name: system_role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.system_role_permissions_id_seq OWNED BY public.system_role_permissions.id;


--
-- TOC entry 235 (class 1259 OID 83206)
-- Name: system_user; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public."system_user" (
    id bigint NOT NULL,
    system_id bigint NOT NULL,
    user_id bigint NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    granted_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role character varying(255) DEFAULT 'user'::character varying NOT NULL
);


ALTER TABLE public."system_user" OWNER TO super_admin;

--
-- TOC entry 234 (class 1259 OID 83205)
-- Name: system_user_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.system_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_user_id_seq OWNER TO super_admin;

--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 234
-- Name: system_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.system_user_id_seq OWNED BY public."system_user".id;


--
-- TOC entry 233 (class 1259 OID 83187)
-- Name: systems; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.systems (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    base_url character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    api_key character varying(64) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.systems OWNER TO super_admin;

--
-- TOC entry 232 (class 1259 OID 83186)
-- Name: systems_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.systems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.systems_id_seq OWNER TO super_admin;

--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 232
-- Name: systems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.systems_id_seq OWNED BY public.systems.id;


--
-- TOC entry 222 (class 1259 OID 83073)
-- Name: users; Type: TABLE; Schema: public; Owner: super_admin
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    role character varying(255) DEFAULT 'user'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    branch_id bigint,
    employee_id character varying(255),
    department character varying(255),
    "position" character varying(255),
    phone_number character varying(255)
);


ALTER TABLE public.users OWNER TO super_admin;

--
-- TOC entry 221 (class 1259 OID 83072)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: super_admin
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO super_admin;

--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super_admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4915 (class 2604 OID 83252)
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 83270)
-- Name: branches id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.branches ALTER COLUMN id SET DEFAULT nextval('public.branches_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 83171)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 83141)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 83066)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 83346)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 4914 (class 2604 OID 83235)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 83360)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4919 (class 2604 OID 83303)
-- Name: system_permissions id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_permissions ALTER COLUMN id SET DEFAULT nextval('public.system_permissions_id_seq'::regclass);


--
-- TOC entry 4920 (class 2604 OID 83323)
-- Name: system_role_permissions id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_role_permissions ALTER COLUMN id SET DEFAULT nextval('public.system_role_permissions_id_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 83209)
-- Name: system_user id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public."system_user" ALTER COLUMN id SET DEFAULT nextval('public.system_user_id_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 83190)
-- Name: systems id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.systems ALTER COLUMN id SET DEFAULT nextval('public.systems_id_seq'::regclass);


--
-- TOC entry 4902 (class 2604 OID 83076)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5180 (class 0 OID 83249)
-- Dependencies: 239
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.audit_logs (id, user_id, action, ip_address, user_agent, metadata, created_at) FROM stdin;
1	1	login	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	\N	2026-03-25 10:40:51
2	1	create_user	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	{"created_user_id": 2}	2026-03-25 10:41:42
3	1	configure_access	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	{"systems": [{"id": 1, "role": "admin"}, {"id": 3, "role": "admin"}], "target_user_id": 2}	2026-03-25 10:42:43
4	2	login	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	{"system": "risk_profiling"}	2026-03-25 10:47:40
5	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 10:52:51
6	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:27:29
7	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:29:08
8	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:29:51
9	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:39:11
10	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:44:52
11	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:46:00
12	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:46:22
13	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:53:19
14	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:54:23
15	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:55:38
16	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 11:57:08
17	2	login	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	{"system": "risk_profiling"}	2026-03-25 13:01:23
18	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 13:04:24
19	1	login	127.0.0.1	curl/8.16.0	{"system": "risk_profiling"}	2026-03-25 13:05:00
\.


--
-- TOC entry 5182 (class 0 OID 83267)
-- Dependencies: 241
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.branches (id, branch_name, brak, brcode, parent_id, is_active, created_at, updated_at) FROM stdin;
1	Head Office	HO	00	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
2	Main Office	MO	01	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
3	Jasaan Branch	JB	02	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
4	Salay Branch	SB	03	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
5	CDO Branch	CDOB	04	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
6	Maramag Branch	MB	05	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
7	Gingoog Branch Lite	GNG-BLU	06	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
8	Camiguin Branch Lite	CMG-BLU	07	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
9	Butuan Branch Lite	BXU-BLU	08	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
10	Kibawe Branch Lite	KIBAWE-BLU	09	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
11	Claveria Branch Lite	Claveria-BLU	10	\N	t	2026-03-25 02:35:15	2026-03-25 02:35:15
\.


--
-- TOC entry 5166 (class 0 OID 83115)
-- Dependencies: 225
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.cache (key, value, expiration) FROM stdin;
rbtsystem-api-cache-5c785c036466adea360111aa28563bfd556b5fba:timer	i:1774415123;	1774415123
rbtsystem-api-cache-5c785c036466adea360111aa28563bfd556b5fba	i:2;	1774415123
\.


--
-- TOC entry 5167 (class 0 OID 83126)
-- Dependencies: 226
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 5172 (class 0 OID 83168)
-- Dependencies: 231
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 5170 (class 0 OID 83153)
-- Dependencies: 229
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 5169 (class 0 OID 83138)
-- Dependencies: 228
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 5161 (class 0 OID 83063)
-- Dependencies: 220
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2026_03_25_000001_create_systems_table	1
5	2026_03_25_000002_create_personal_access_tokens_table	1
6	2026_03_25_000003_create_audit_logs_table	1
7	2026_03_25_000004_create_branches_table	1
8	2026_03_25_000005_add_branch_id_to_users_table	1
9	2026_03_25_000006_add_role_to_system_user_table	1
10	2026_03_25_000007_create_system_permissions_tables	1
11	2026_03_25_010218_create_permission_tables	1
\.


--
-- TOC entry 5191 (class 0 OID 83370)
-- Dependencies: 250
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
\.


--
-- TOC entry 5192 (class 0 OID 83384)
-- Dependencies: 251
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
\.


--
-- TOC entry 5164 (class 0 OID 83094)
-- Dependencies: 223
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 5188 (class 0 OID 83343)
-- Dependencies: 247
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.permissions (id, name, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5178 (class 0 OID 83232)
-- Dependencies: 237
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
17	App\\Models\\User	1	auth_token	8ea9f8856b4070ac6daca5d642e7ff8d7e467277bfdedf225e8a8f4319c7872f	["*"]	2026-03-25 05:05:01	2026-04-01 05:04:59	2026-03-25 05:04:59	2026-03-25 05:05:01
15	App\\Models\\User	2	auth_token	ace936e21b05830b51de034687b14989629ec8ef99d5ba82f8d20932ceea2a1e	["*"]	2026-03-25 05:36:17	2026-04-01 05:01:23	2026-03-25 05:01:23	2026-03-25 05:36:17
\.


--
-- TOC entry 5193 (class 0 OID 83398)
-- Dependencies: 252
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
\.


--
-- TOC entry 5190 (class 0 OID 83357)
-- Dependencies: 249
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5165 (class 0 OID 83103)
-- Dependencies: 224
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- TOC entry 5184 (class 0 OID 83300)
-- Dependencies: 243
-- Data for Name: system_permissions; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.system_permissions (id, system_id, name, slug, "group", created_at, updated_at) FROM stdin;
1	1	View Dashboard	view-dashboard	Dashboard	2026-03-25 02:35:15	2026-03-25 02:35:15
2	1	View Users	view-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
3	1	Manage Users	manage-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
4	1	View Audit Logs	view-audit-logs	Audit	2026-03-25 02:35:15	2026-03-25 02:35:15
5	1	View Assets	view-assets	Inventory	2026-03-25 02:35:15	2026-03-25 02:35:15
6	1	Manage Assets	manage-assets	Inventory	2026-03-25 02:35:15	2026-03-25 02:35:15
7	1	View Employees	view-employees	Employees	2026-03-25 02:35:15	2026-03-25 02:35:15
8	1	Manage Employees	manage-employees	Employees	2026-03-25 02:35:15	2026-03-25 02:35:15
9	1	View Reports	view-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
10	1	Export Reports	export-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
11	2	View Dashboard	view-dashboard	Dashboard	2026-03-25 02:35:15	2026-03-25 02:35:15
12	2	View Reports	view-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
13	2	Create Reports	create-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
14	2	Edit Reports	edit-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
15	2	Delete Reports	delete-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
16	2	Submit Reports	submit-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
17	2	View Data Configuration	view-data-config	Configuration	2026-03-25 02:35:15	2026-03-25 02:35:15
18	2	Manage Data Configuration	manage-data-config	Configuration	2026-03-25 02:35:15	2026-03-25 02:35:15
19	2	View Users	view-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
20	2	Manage Users	manage-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
21	3	View Users	view-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
22	3	Manage Users	manage-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
23	3	View Roles	view-roles	Role Management	2026-03-25 02:35:15	2026-03-25 02:35:15
24	3	Manage Roles	manage-roles	Role Management	2026-03-25 02:35:15	2026-03-25 02:35:15
25	3	View Permissions	view-permissions	Permission Management	2026-03-25 02:35:15	2026-03-25 02:35:15
26	3	Manage Permissions	manage-permissions	Permission Management	2026-03-25 02:35:15	2026-03-25 02:35:15
27	3	View Customers	view-customers	Customer Management	2026-03-25 02:35:15	2026-03-25 02:35:15
28	3	Manage Customers	manage-customers	Customer Management	2026-03-25 02:35:15	2026-03-25 02:35:15
29	3	View Risk Assessments	view-risk-assessments	Risk Assessment	2026-03-25 02:35:15	2026-03-25 02:35:15
30	3	Create Risk Assessments	create-risk-assessments	Risk Assessment	2026-03-25 02:35:15	2026-03-25 02:35:15
31	3	Edit Risk Assessments	edit-risk-assessments	Risk Assessment	2026-03-25 02:35:15	2026-03-25 02:35:15
32	3	Delete Risk Assessments	delete-risk-assessments	Risk Assessment	2026-03-25 02:35:15	2026-03-25 02:35:15
33	3	View Risk Settings	view-risk-settings	Risk Settings	2026-03-25 02:35:15	2026-03-25 02:35:15
34	3	Manage Risk Settings	manage-risk-settings	Risk Settings	2026-03-25 02:35:15	2026-03-25 02:35:15
35	3	View Basic Dashboard	view-basic-dashboard	Dashboard	2026-03-25 02:35:15	2026-03-25 02:35:15
36	3	View Admin Dashboard	view-admin-dashboard	Dashboard	2026-03-25 02:35:15	2026-03-25 02:35:15
37	3	View Branch Analytics	view-branch-analytics	Dashboard	2026-03-25 02:35:15	2026-03-25 02:35:15
38	3	View System Analytics	view-system-analytics	Dashboard	2026-03-25 02:35:15	2026-03-25 02:35:15
39	3	View Basic Reports	view-basic-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
40	3	View Advanced Reports	view-advanced-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
41	3	Export Reports	export-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
42	3	View System Settings	view-system-settings	System Settings	2026-03-25 02:35:15	2026-03-25 02:35:15
43	3	Manage System Settings	manage-system-settings	System Settings	2026-03-25 02:35:15	2026-03-25 02:35:15
44	3	View Audit Logs	view-audit-logs	Audit	2026-03-25 02:35:15	2026-03-25 02:35:15
45	3	Manage Audit Logs	manage-audit-logs	Audit	2026-03-25 02:35:15	2026-03-25 02:35:15
46	3	View Branches	view-branches	Branch Management	2026-03-25 02:35:15	2026-03-25 02:35:15
47	3	Manage Branches	manage-branches	Branch Management	2026-03-25 02:35:15	2026-03-25 02:35:15
48	4	View Users	view-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
49	4	Create Users	create-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
50	4	Edit Users	edit-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
51	4	Delete Users	delete-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
52	4	Activate Users	activate-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
53	4	Deactivate Users	deactivate-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
54	4	Reset User Passwords	reset-user-passwords	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
55	4	Unlock User Accounts	unlock-user-accounts	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
56	4	View Roles	view-roles	Role Management	2026-03-25 02:35:15	2026-03-25 02:35:15
57	4	Create Roles	create-roles	Role Management	2026-03-25 02:35:15	2026-03-25 02:35:15
58	4	Edit Roles	edit-roles	Role Management	2026-03-25 02:35:15	2026-03-25 02:35:15
59	4	Delete Roles	delete-roles	Role Management	2026-03-25 02:35:15	2026-03-25 02:35:15
60	4	Assign Roles	assign-roles	Role Management	2026-03-25 02:35:15	2026-03-25 02:35:15
61	4	View Permissions	view-permissions	Permission Management	2026-03-25 02:35:15	2026-03-25 02:35:15
62	4	Assign Permissions	assign-permissions	Permission Management	2026-03-25 02:35:15	2026-03-25 02:35:15
63	4	View Transactions	view-transactions	Transactions	2026-03-25 02:35:15	2026-03-25 02:35:15
64	4	Create Transactions	create-transactions	Transactions	2026-03-25 02:35:15	2026-03-25 02:35:15
65	4	Edit Transactions	edit-transactions	Transactions	2026-03-25 02:35:15	2026-03-25 02:35:15
66	4	Approve Transactions	approve-transactions	Transactions	2026-03-25 02:35:15	2026-03-25 02:35:15
67	4	Reject Transactions	reject-transactions	Transactions	2026-03-25 02:35:15	2026-03-25 02:35:15
68	4	Cancel Transactions	cancel-transactions	Transactions	2026-03-25 02:35:15	2026-03-25 02:35:15
69	4	View Transaction History	view-transaction-history	Transactions	2026-03-25 02:35:15	2026-03-25 02:35:15
70	4	View Accounts	view-accounts	Accounts	2026-03-25 02:35:15	2026-03-25 02:35:15
71	4	Create Accounts	create-accounts	Accounts	2026-03-25 02:35:15	2026-03-25 02:35:15
72	4	Edit Accounts	edit-accounts	Accounts	2026-03-25 02:35:15	2026-03-25 02:35:15
73	4	Close Accounts	close-accounts	Accounts	2026-03-25 02:35:15	2026-03-25 02:35:15
74	4	Transfer Funds	transfer-funds	Accounts	2026-03-25 02:35:15	2026-03-25 02:35:15
75	4	Approve Transfers	approve-transfers	Accounts	2026-03-25 02:35:15	2026-03-25 02:35:15
76	4	View Balances	view-balances	Accounts	2026-03-25 02:35:15	2026-03-25 02:35:15
77	4	Generate Statements	generate-statements	Accounts	2026-03-25 02:35:15	2026-03-25 02:35:15
78	4	View Audit Logs	view-audit-logs	Audit & Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
79	4	Export Audit Logs	export-audit-logs	Audit & Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
80	4	View Compliance Reports	view-compliance-reports	Audit & Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
81	4	Generate Compliance Reports	generate-compliance-reports	Audit & Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
82	4	View Risk Assessments	view-risk-assessments	Audit & Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
83	4	Create Risk Assessments	create-risk-assessments	Audit & Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
84	4	Approve Risk Assessments	approve-risk-assessments	Audit & Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
85	4	View System Settings	view-system-settings	System	2026-03-25 02:35:15	2026-03-25 02:35:15
86	4	Edit System Settings	edit-system-settings	System	2026-03-25 02:35:15	2026-03-25 02:35:15
87	4	View System Logs	view-system-logs	System	2026-03-25 02:35:15	2026-03-25 02:35:15
88	4	Backup System	backup-system	System	2026-03-25 02:35:15	2026-03-25 02:35:15
89	4	Restore System	restore-system	System	2026-03-25 02:35:15	2026-03-25 02:35:15
90	4	Manage Security Policies	manage-security-policies	System	2026-03-25 02:35:15	2026-03-25 02:35:15
91	4	View Customers	view-customers	Customers	2026-03-25 02:35:15	2026-03-25 02:35:15
92	4	Create Customers	create-customers	Customers	2026-03-25 02:35:15	2026-03-25 02:35:15
93	4	Edit Customers	edit-customers	Customers	2026-03-25 02:35:15	2026-03-25 02:35:15
94	4	Verify Customers	verify-customers	Customers	2026-03-25 02:35:15	2026-03-25 02:35:15
95	4	Suspend Customers	suspend-customers	Customers	2026-03-25 02:35:15	2026-03-25 02:35:15
96	4	View Customer Documents	view-customer-documents	Customers	2026-03-25 02:35:15	2026-03-25 02:35:15
97	4	Approve Customer Applications	approve-customer-applications	Customers	2026-03-25 02:35:15	2026-03-25 02:35:15
98	4	View Reports	view-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
99	4	Generate Reports	generate-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
100	4	Export Reports	export-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
101	4	View Financial Reports	view-financial-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
102	4	View Regulatory Reports	view-regulatory-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
103	4	Force Password Reset	force-password-reset	Security	2026-03-25 02:35:15	2026-03-25 02:35:15
104	4	Unlock Accounts	unlock-accounts	Security	2026-03-25 02:35:15	2026-03-25 02:35:15
105	4	View Login Attempts	view-login-attempts	Security	2026-03-25 02:35:15	2026-03-25 02:35:15
106	4	Manage Sessions	manage-sessions	Security	2026-03-25 02:35:15	2026-03-25 02:35:15
107	4	Enable/Disable 2FA	enable-disable-2fa	Security	2026-03-25 02:35:15	2026-03-25 02:35:15
108	4	View Branch Data	view-branch-data	Branch Operations	2026-03-25 02:35:15	2026-03-25 02:35:15
109	4	Manage Branch Operations	manage-branch-operations	Branch Operations	2026-03-25 02:35:15	2026-03-25 02:35:15
110	4	View Branch Reports	view-branch-reports	Branch Operations	2026-03-25 02:35:15	2026-03-25 02:35:15
111	4	Approve Branch Transactions	approve-branch-transactions	Branch Operations	2026-03-25 02:35:15	2026-03-25 02:35:15
112	5	View Dashboard	view-dashboard	Dashboard	2026-03-25 02:35:15	2026-03-25 02:35:15
113	5	View Risks	view-risks	Risk Management	2026-03-25 02:35:15	2026-03-25 02:35:15
114	5	Create Risks	create-risks	Risk Management	2026-03-25 02:35:15	2026-03-25 02:35:15
115	5	Edit Risks	edit-risks	Risk Management	2026-03-25 02:35:15	2026-03-25 02:35:15
116	5	Delete Risks	delete-risks	Risk Management	2026-03-25 02:35:15	2026-03-25 02:35:15
117	5	View Controls	view-controls	Controls	2026-03-25 02:35:15	2026-03-25 02:35:15
118	5	Manage Controls	manage-controls	Controls	2026-03-25 02:35:15	2026-03-25 02:35:15
119	5	View Compliance	view-compliance	Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
120	5	Manage Compliance	manage-compliance	Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
121	5	View Compliance Reports	view-compliance-reports	Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
122	5	Generate Compliance Reports	generate-compliance-reports	Compliance	2026-03-25 02:35:15	2026-03-25 02:35:15
123	5	View Audit Logs	view-audit-logs	Audit	2026-03-25 02:35:15	2026-03-25 02:35:15
124	5	Create Audit Findings	create-audit-findings	Audit	2026-03-25 02:35:15	2026-03-25 02:35:15
125	5	View Audit Reports	view-audit-reports	Audit	2026-03-25 02:35:15	2026-03-25 02:35:15
126	5	Export Audit Reports	export-audit-reports	Audit	2026-03-25 02:35:15	2026-03-25 02:35:15
127	5	View Reports	view-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
128	5	Export Reports	export-reports	Reports	2026-03-25 02:35:15	2026-03-25 02:35:15
129	5	View Users	view-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
130	5	Manage Users	manage-users	User Management	2026-03-25 02:35:15	2026-03-25 02:35:15
\.


--
-- TOC entry 5186 (class 0 OID 83320)
-- Dependencies: 245
-- Data for Name: system_role_permissions; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.system_role_permissions (id, system_id, role, permission_id) FROM stdin;
1	1	admin	1
2	1	admin	2
3	1	admin	3
4	1	admin	4
5	1	admin	5
6	1	admin	6
7	1	admin	7
8	1	admin	8
9	1	admin	9
10	1	admin	10
11	1	user	1
12	1	user	5
13	1	user	7
14	1	user	9
15	2	admin	11
16	2	admin	12
17	2	admin	13
18	2	admin	14
19	2	admin	15
20	2	admin	16
21	2	admin	17
22	2	admin	18
23	2	admin	19
24	2	admin	20
25	2	compliance	11
26	2	compliance	12
27	2	compliance	13
28	2	compliance	14
29	2	compliance	16
30	2	compliance	17
31	2	user	11
32	2	user	12
33	2	user	13
34	3	admin	21
35	3	admin	22
36	3	admin	23
37	3	admin	24
38	3	admin	25
39	3	admin	26
40	3	admin	27
41	3	admin	28
42	3	admin	29
43	3	admin	30
44	3	admin	31
45	3	admin	32
46	3	admin	33
47	3	admin	34
48	3	admin	35
49	3	admin	36
50	3	admin	37
51	3	admin	38
52	3	admin	39
53	3	admin	40
54	3	admin	41
55	3	admin	42
56	3	admin	43
57	3	admin	44
58	3	admin	45
59	3	admin	46
60	3	admin	47
61	3	manager	21
62	3	manager	23
63	3	manager	25
64	3	manager	27
65	3	manager	28
66	3	manager	29
67	3	manager	31
68	3	manager	35
69	3	manager	37
70	3	manager	39
71	3	manager	46
72	3	compliance	21
73	3	compliance	23
74	3	compliance	25
75	3	compliance	27
76	3	compliance	28
77	3	compliance	29
78	3	compliance	31
79	3	compliance	33
80	3	compliance	34
81	3	compliance	35
82	3	compliance	37
83	3	compliance	40
84	3	compliance	41
85	3	compliance	44
86	3	compliance	46
87	3	audit	21
88	3	audit	27
89	3	audit	29
90	3	audit	35
91	3	audit	37
92	3	audit	39
93	3	audit	40
94	3	audit	44
95	3	audit	46
96	3	user	27
97	3	user	29
98	3	user	30
99	3	user	31
100	4	admin	48
101	4	admin	49
102	4	admin	50
103	4	admin	51
104	4	admin	52
105	4	admin	53
106	4	admin	54
107	4	admin	55
108	4	admin	56
109	4	admin	57
110	4	admin	58
111	4	admin	59
112	4	admin	60
113	4	admin	61
114	4	admin	62
115	4	admin	63
116	4	admin	64
117	4	admin	65
118	4	admin	66
119	4	admin	67
120	4	admin	68
121	4	admin	69
122	4	admin	70
123	4	admin	71
124	4	admin	72
125	4	admin	73
126	4	admin	74
127	4	admin	75
128	4	admin	76
129	4	admin	77
130	4	admin	78
131	4	admin	79
132	4	admin	80
133	4	admin	81
134	4	admin	82
135	4	admin	83
136	4	admin	84
137	4	admin	85
138	4	admin	86
139	4	admin	87
140	4	admin	88
141	4	admin	89
142	4	admin	90
143	4	admin	91
144	4	admin	92
145	4	admin	93
146	4	admin	94
147	4	admin	95
148	4	admin	96
149	4	admin	97
150	4	admin	98
151	4	admin	99
152	4	admin	100
153	4	admin	101
154	4	admin	102
155	4	admin	103
156	4	admin	104
157	4	admin	105
158	4	admin	106
159	4	admin	107
160	4	admin	108
161	4	admin	109
162	4	admin	110
163	4	admin	111
164	4	manager	48
165	4	manager	50
166	4	manager	52
167	4	manager	53
168	4	manager	54
169	4	manager	55
170	4	manager	63
171	4	manager	66
172	4	manager	67
173	4	manager	69
174	4	manager	70
175	4	manager	76
176	4	manager	75
177	4	manager	77
178	4	manager	91
179	4	manager	93
180	4	manager	94
181	4	manager	97
182	4	manager	98
183	4	manager	99
184	4	manager	100
185	4	manager	101
186	4	manager	78
187	4	manager	80
188	4	manager	82
189	4	manager	84
190	4	manager	108
191	4	manager	109
192	4	manager	110
193	4	manager	111
194	4	cashier	63
195	4	cashier	69
196	4	cashier	70
197	4	cashier	76
198	4	cashier	91
199	4	cashier	96
200	4	cashier	108
201	4	compliance-audit	78
202	4	compliance-audit	79
203	4	compliance-audit	80
204	4	compliance-audit	81
205	4	compliance-audit	82
206	4	compliance-audit	83
207	4	compliance-audit	48
208	4	compliance-audit	63
209	4	compliance-audit	69
210	4	compliance-audit	70
211	4	compliance-audit	91
212	4	compliance-audit	98
213	4	compliance-audit	99
214	4	compliance-audit	100
215	4	compliance-audit	101
216	4	compliance-audit	102
217	4	compliance-audit	105
218	4	compliance-audit	87
219	4	compliance-audit	108
220	4	compliance-audit	110
221	4	user	63
222	4	user	64
223	4	user	69
224	4	user	70
225	4	user	76
226	4	user	77
227	4	user	91
228	4	user	93
229	4	user	96
230	4	user	98
231	4	user	99
232	5	admin	112
233	5	admin	113
234	5	admin	114
235	5	admin	115
236	5	admin	116
237	5	admin	117
238	5	admin	118
239	5	admin	119
240	5	admin	120
241	5	admin	121
242	5	admin	122
243	5	admin	123
244	5	admin	124
245	5	admin	125
246	5	admin	126
247	5	admin	127
248	5	admin	128
249	5	admin	129
250	5	admin	130
251	5	compliance	112
252	5	compliance	113
253	5	compliance	114
254	5	compliance	115
255	5	compliance	117
256	5	compliance	118
257	5	compliance	119
258	5	compliance	120
259	5	compliance	121
260	5	compliance	122
261	5	compliance	123
262	5	compliance	125
263	5	compliance	126
264	5	compliance	127
265	5	compliance	128
266	5	compliance	129
267	5	audit	112
268	5	audit	113
269	5	audit	117
270	5	audit	123
271	5	audit	124
272	5	audit	125
273	5	audit	126
274	5	audit	127
275	5	user	112
276	5	user	113
277	5	user	117
278	5	user	127
\.


--
-- TOC entry 5176 (class 0 OID 83206)
-- Dependencies: 235
-- Data for Name: system_user; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public."system_user" (id, system_id, user_id, is_active, granted_at, role) FROM stdin;
1	1	1	t	2026-03-25 10:35:16	admin
2	2	1	t	2026-03-25 10:35:16	admin
3	3	1	t	2026-03-25 10:35:16	admin
4	4	1	t	2026-03-25 10:35:16	admin
5	5	1	t	2026-03-25 10:35:16	admin
6	1	2	t	2026-03-25 02:42:43	admin
7	3	2	t	2026-03-25 02:42:43	admin
\.


--
-- TOC entry 5174 (class 0 OID 83187)
-- Dependencies: 233
-- Data for Name: systems; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.systems (id, name, slug, description, base_url, is_active, api_key, created_at, updated_at) FROM stdin;
1	MIS System	mis_system	Management Information System	http://localhost:5173	t	5SKiKa5VhEsmRSAepwF1lPCTI8fZNR37G420DOMNvzW8UYAhZy0XyEUmfOmMxZmj	2026-03-25 02:35:15	2026-03-25 02:35:15
2	AMLA Report	amla_report	Anti-Money Laundering Act Reporting System	\N	t	sDBNFvqVhQFjxUfaevy5muj394ddAXZPrgI0Fb00gluDVvcerDUD6knH8Muhx2Oi	2026-03-25 02:35:15	2026-03-25 02:35:15
3	Risk Profiling	risk_profiling	Customer Risk Profiling System	\N	t	0EyAneEr5Zo0oGNpU9fmzavzZn6dGyMixMjsmramA3LJlaElbDLfRnjWGTGaeeLK	2026-03-25 02:35:15	2026-03-25 02:35:15
4	Sigcard	sigcard	Signature Card Management System	\N	t	fJen8e510y3HYPz9Ma7GSeJ9UfLJN3tMgjf5F2SXDKjRVx7XW3RIEkPnkXVzfB7X	2026-03-25 02:35:15	2026-03-25 02:35:15
5	GRC System	grc_system	Governance, Risk & Compliance System	\N	t	u7zihfHiFEKV4GQushAMOEblCoBmj0WgWeA5rCbcudhgIZP0QKZf8Q2HU1qoZnHe	2026-03-25 02:35:15	2026-03-25 02:35:15
\.


--
-- TOC entry 5163 (class 0 OID 83073)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: super_admin
--

COPY public.users (id, name, username, email, email_verified_at, password, role, is_active, remember_token, created_at, updated_at, branch_id, employee_id, department, "position", phone_number) FROM stdin;
1	Super Admin	admin	admin@rbtbank.com	2026-03-25 02:35:15	$2y$12$.i7nW1neKQqeeddT5RwNSOkFsrA4sLUBXjZ.KM4sHYY1pB.zPCvsW	admin	t	\N	2026-03-25 02:35:15	2026-03-25 02:35:15	1	\N	IT	MIS	\N
2	Augustin Maputol	maps	cloudsephiroth56@gmail.com	\N	$2y$12$NuCmG6XG3t9ymVZV1pjoWewDMRpK0xyzqZbMgy4J9KQepyPQqxYXe	user	t	\N	2026-03-25 02:41:41	2026-03-25 02:41:41	1	13212321	\N	\N	\N
\.


--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 238
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 19, true);


--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 240
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.branches_id_seq', 11, true);


--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.migrations_id_seq', 11, true);


--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 246
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 236
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 17, true);


--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 248
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 242
-- Name: system_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.system_permissions_id_seq', 130, true);


--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 244
-- Name: system_role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.system_role_permissions_id_seq', 278, true);


--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 234
-- Name: system_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.system_user_id_seq', 7, true);


--
-- TOC entry 5223 (class 0 OID 0)
-- Dependencies: 232
-- Name: systems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.systems_id_seq', 5, true);


--
-- TOC entry 5224 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super_admin
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4970 (class 2606 OID 83260)
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4974 (class 2606 OID 83289)
-- Name: branches branches_brcode_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_brcode_unique UNIQUE (brcode);


--
-- TOC entry 4976 (class 2606 OID 83280)
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 83135)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 4941 (class 2606 OID 83124)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 4951 (class 2606 OID 83183)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4953 (class 2606 OID 83185)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 4949 (class 2606 OID 83166)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 4946 (class 2606 OID 83151)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4924 (class 2606 OID 83071)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4995 (class 2606 OID 83383)
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- TOC entry 4998 (class 2606 OID 83397)
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- TOC entry 4934 (class 2606 OID 83102)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 4986 (class 2606 OID 83355)
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- TOC entry 4988 (class 2606 OID 83353)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4965 (class 2606 OID 83244)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4967 (class 2606 OID 83247)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 5000 (class 2606 OID 83414)
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- TOC entry 4990 (class 2606 OID 83369)
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- TOC entry 4992 (class 2606 OID 83367)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4937 (class 2606 OID 83112)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4982 (class 2606 OID 83341)
-- Name: system_role_permissions sys_role_perm_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_role_permissions
    ADD CONSTRAINT sys_role_perm_unique UNIQUE (system_id, role, permission_id);


--
-- TOC entry 4978 (class 2606 OID 83311)
-- Name: system_permissions system_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_permissions
    ADD CONSTRAINT system_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4980 (class 2606 OID 83318)
-- Name: system_permissions system_permissions_system_id_slug_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_permissions
    ADD CONSTRAINT system_permissions_system_id_slug_unique UNIQUE (system_id, slug);


--
-- TOC entry 4984 (class 2606 OID 83329)
-- Name: system_role_permissions system_role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_role_permissions
    ADD CONSTRAINT system_role_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4961 (class 2606 OID 83218)
-- Name: system_user system_user_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public."system_user"
    ADD CONSTRAINT system_user_pkey PRIMARY KEY (id);


--
-- TOC entry 4963 (class 2606 OID 83230)
-- Name: system_user system_user_system_id_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public."system_user"
    ADD CONSTRAINT system_user_system_id_user_id_unique UNIQUE (system_id, user_id);


--
-- TOC entry 4955 (class 2606 OID 83204)
-- Name: systems systems_api_key_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_api_key_unique UNIQUE (api_key);


--
-- TOC entry 4957 (class 2606 OID 83200)
-- Name: systems systems_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_pkey PRIMARY KEY (id);


--
-- TOC entry 4959 (class 2606 OID 83202)
-- Name: systems systems_slug_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_slug_unique UNIQUE (slug);


--
-- TOC entry 4926 (class 2606 OID 83093)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 4928 (class 2606 OID 83296)
-- Name: users users_employee_id_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_employee_id_unique UNIQUE (employee_id);


--
-- TOC entry 4930 (class 2606 OID 83089)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4932 (class 2606 OID 83091)
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- TOC entry 4971 (class 1259 OID 83286)
-- Name: branches_brak_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX branches_brak_index ON public.branches USING btree (brak);


--
-- TOC entry 4972 (class 1259 OID 83287)
-- Name: branches_branch_name_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX branches_branch_name_index ON public.branches USING btree (branch_name);


--
-- TOC entry 4939 (class 1259 OID 83125)
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- TOC entry 4942 (class 1259 OID 83136)
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- TOC entry 4947 (class 1259 OID 83152)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 4993 (class 1259 OID 83376)
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- TOC entry 4996 (class 1259 OID 83390)
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- TOC entry 4968 (class 1259 OID 83245)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- TOC entry 4935 (class 1259 OID 83114)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 4938 (class 1259 OID 83113)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: super_admin
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 5004 (class 2606 OID 83261)
-- Name: audit_logs audit_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 5005 (class 2606 OID 83281)
-- Name: branches branches_parent_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES public.branches(id) ON DELETE SET NULL;


--
-- TOC entry 5009 (class 2606 OID 83377)
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 5010 (class 2606 OID 83391)
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5011 (class 2606 OID 83403)
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 5012 (class 2606 OID 83408)
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5006 (class 2606 OID 83312)
-- Name: system_permissions system_permissions_system_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_permissions
    ADD CONSTRAINT system_permissions_system_id_foreign FOREIGN KEY (system_id) REFERENCES public.systems(id) ON DELETE CASCADE;


--
-- TOC entry 5007 (class 2606 OID 83335)
-- Name: system_role_permissions system_role_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_role_permissions
    ADD CONSTRAINT system_role_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.system_permissions(id) ON DELETE CASCADE;


--
-- TOC entry 5008 (class 2606 OID 83330)
-- Name: system_role_permissions system_role_permissions_system_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.system_role_permissions
    ADD CONSTRAINT system_role_permissions_system_id_foreign FOREIGN KEY (system_id) REFERENCES public.systems(id) ON DELETE CASCADE;


--
-- TOC entry 5002 (class 2606 OID 83219)
-- Name: system_user system_user_system_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public."system_user"
    ADD CONSTRAINT system_user_system_id_foreign FOREIGN KEY (system_id) REFERENCES public.systems(id) ON DELETE CASCADE;


--
-- TOC entry 5003 (class 2606 OID 83224)
-- Name: system_user system_user_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public."system_user"
    ADD CONSTRAINT system_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5001 (class 2606 OID 83290)
-- Name: users users_branch_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: super_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_branch_id_foreign FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE SET NULL;


-- Completed on 2026-03-25 13:36:24

--
-- PostgreSQL database dump complete
--

\unrestrict MEPPfEWfOiHRzCcorubfElfh18zpIJBGmTkfUDKNbiEhsY2gtHZ8JXwdPFmHVAk

