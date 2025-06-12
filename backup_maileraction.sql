--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-0+deb12u1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-0+deb12u1)

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO chima;

--
-- Name: block_templates; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.block_templates (
    id bigint NOT NULL,
    name character varying,
    description text,
    html_content text,
    category character varying,
    settings jsonb,
    public boolean,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.block_templates OWNER TO chima;

--
-- Name: block_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.block_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.block_templates_id_seq OWNER TO chima;

--
-- Name: block_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.block_templates_id_seq OWNED BY public.block_templates.id;


--
-- Name: bounces; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.bounces (
    id bigint NOT NULL,
    reason character varying,
    bounced_at timestamp(6) without time zone,
    email_record_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    campaign_id bigint,
    campaign_uuid uuid
);


ALTER TABLE public.bounces OWNER TO chima;

--
-- Name: bounces_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.bounces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bounces_id_seq OWNER TO chima;

--
-- Name: bounces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.bounces_id_seq OWNED BY public.bounces.id;


--
-- Name: campaign_emails; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.campaign_emails (
    id bigint NOT NULL,
    campaign_id bigint NOT NULL,
    email_record_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    campaign_uuid uuid
);


ALTER TABLE public.campaign_emails OWNER TO chima;

--
-- Name: campaign_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.campaign_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaign_emails_id_seq OWNER TO chima;

--
-- Name: campaign_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.campaign_emails_id_seq OWNED BY public.campaign_emails.id;


--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.campaigns (
    id bigint NOT NULL,
    email_limit integer,
    status character varying,
    user_id bigint NOT NULL,
    industry_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    subject character varying,
    body text,
    template_id bigint,
    send_at timestamp(6) without time zone,
    html_content text,
    name character varying,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    canvas_cleared boolean
);


ALTER TABLE public.campaigns OWNER TO chima;

--
-- Name: campaigns_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.campaigns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaigns_id_seq OWNER TO chima;

--
-- Name: campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.campaigns_id_seq OWNED BY public.campaigns.id;


--
-- Name: credit_accounts; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.credit_accounts (
    id bigint NOT NULL,
    available_credit integer,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.credit_accounts OWNER TO chima;

--
-- Name: credit_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.credit_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credit_accounts_id_seq OWNER TO chima;

--
-- Name: credit_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.credit_accounts_id_seq OWNED BY public.credit_accounts.id;


--
-- Name: email_blocks; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.email_blocks (
    id bigint NOT NULL,
    campaign_id bigint NOT NULL,
    user_id bigint NOT NULL,
    block_template_id bigint,
    name character varying,
    block_type character varying,
    html_content text,
    settings jsonb,
    "position" integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    campaign_uuid uuid
);


ALTER TABLE public.email_blocks OWNER TO chima;

--
-- Name: email_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.email_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_blocks_id_seq OWNER TO chima;

--
-- Name: email_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.email_blocks_id_seq OWNED BY public.email_blocks.id;


--
-- Name: email_error_logs; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.email_error_logs (
    id bigint NOT NULL,
    email character varying,
    campaign_id bigint,
    error text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    campaign_uuid uuid
);


ALTER TABLE public.email_error_logs OWNER TO chima;

--
-- Name: email_error_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.email_error_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_error_logs_id_seq OWNER TO chima;

--
-- Name: email_error_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.email_error_logs_id_seq OWNED BY public.email_error_logs.id;


--
-- Name: email_event_logs; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.email_event_logs (
    id bigint NOT NULL,
    email character varying NOT NULL,
    event_type character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    campaign_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    campaign_uuid uuid
);


ALTER TABLE public.email_event_logs OWNER TO chima;

--
-- Name: email_event_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.email_event_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_event_logs_id_seq OWNER TO chima;

--
-- Name: email_event_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.email_event_logs_id_seq OWNED BY public.email_event_logs.id;


--
-- Name: email_logs; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.email_logs (
    id bigint NOT NULL,
    status character varying,
    opened_at timestamp(6) without time zone,
    clicked_at timestamp(6) without time zone,
    campaign_id bigint NOT NULL,
    email_record_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    credit_refunded boolean DEFAULT false,
    attempts_count integer,
    campaign_uuid uuid
);


ALTER TABLE public.email_logs OWNER TO chima;

--
-- Name: email_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.email_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_logs_id_seq OWNER TO chima;

--
-- Name: email_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.email_logs_id_seq OWNED BY public.email_logs.id;


--
-- Name: email_records; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.email_records (
    id bigint NOT NULL,
    email character varying,
    company character varying,
    website character varying,
    industry_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    bounces_count integer,
    active boolean
);


ALTER TABLE public.email_records OWNER TO chima;

--
-- Name: email_records_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.email_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_records_id_seq OWNER TO chima;

--
-- Name: email_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.email_records_id_seq OWNED BY public.email_records.id;


--
-- Name: industries; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.industries (
    id bigint NOT NULL,
    name character varying,
    email_count integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name_en character varying
);


ALTER TABLE public.industries OWNER TO chima;

--
-- Name: industries_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.industries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.industries_id_seq OWNER TO chima;

--
-- Name: industries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.industries_id_seq OWNED BY public.industries.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    title character varying NOT NULL,
    body text NOT NULL,
    read_at timestamp(6) without time zone,
    email_sent_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO chima;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO chima;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: plans; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.plans (
    id bigint NOT NULL,
    name character varying,
    max integer,
    campaigna integer,
    max_email integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.plans OWNER TO chima;

--
-- Name: plans_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plans_id_seq OWNER TO chima;

--
-- Name: plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;


--
-- Name: public_email_records; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.public_email_records (
    id bigint NOT NULL,
    email character varying,
    website character varying,
    address character varying,
    municipality character varying,
    city character varying,
    country character varying,
    company_name character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    industry_id bigint NOT NULL,
    source_keyword character varying,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.public_email_records OWNER TO chima;

--
-- Name: public_email_records_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.public_email_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.public_email_records_id_seq OWNER TO chima;

--
-- Name: public_email_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.public_email_records_id_seq OWNED BY public.public_email_records.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO chima;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO chima;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO chima;

--
-- Name: scrape_targets; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.scrape_targets (
    id bigint NOT NULL,
    url character varying,
    status integer,
    last_attempt_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.scrape_targets OWNER TO chima;

--
-- Name: scrape_targets_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.scrape_targets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scrape_targets_id_seq OWNER TO chima;

--
-- Name: scrape_targets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.scrape_targets_id_seq OWNED BY public.scrape_targets.id;


--
-- Name: scraping_sources; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.scraping_sources (
    id bigint NOT NULL,
    url character varying,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.scraping_sources OWNER TO chima;

--
-- Name: scraping_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.scraping_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scraping_sources_id_seq OWNER TO chima;

--
-- Name: scraping_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.scraping_sources_id_seq OWNED BY public.scraping_sources.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.sessions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    session_token character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_agent character varying,
    ip_address character varying
);


ALTER TABLE public.sessions OWNER TO chima;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO chima;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: solid_queue_blocked_executions; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_blocked_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    concurrency_key character varying NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_blocked_executions OWNER TO chima;

--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_blocked_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_blocked_executions_id_seq OWNER TO chima;

--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_blocked_executions_id_seq OWNED BY public.solid_queue_blocked_executions.id;


--
-- Name: solid_queue_claimed_executions; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_claimed_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    process_id bigint,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_claimed_executions OWNER TO chima;

--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_claimed_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_claimed_executions_id_seq OWNER TO chima;

--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_claimed_executions_id_seq OWNED BY public.solid_queue_claimed_executions.id;


--
-- Name: solid_queue_failed_executions; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_failed_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    error text,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_failed_executions OWNER TO chima;

--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_failed_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_failed_executions_id_seq OWNER TO chima;

--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_failed_executions_id_seq OWNED BY public.solid_queue_failed_executions.id;


--
-- Name: solid_queue_jobs; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_jobs (
    id bigint NOT NULL,
    queue_name character varying NOT NULL,
    class_name character varying NOT NULL,
    arguments text,
    priority integer DEFAULT 0 NOT NULL,
    active_job_id character varying,
    scheduled_at timestamp(6) without time zone,
    finished_at timestamp(6) without time zone,
    concurrency_key character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_jobs OWNER TO chima;

--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_jobs_id_seq OWNER TO chima;

--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_jobs_id_seq OWNED BY public.solid_queue_jobs.id;


--
-- Name: solid_queue_pauses; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_pauses (
    id bigint NOT NULL,
    queue_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_pauses OWNER TO chima;

--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_pauses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_pauses_id_seq OWNER TO chima;

--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_pauses_id_seq OWNED BY public.solid_queue_pauses.id;


--
-- Name: solid_queue_processes; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_processes (
    id bigint NOT NULL,
    kind character varying NOT NULL,
    last_heartbeat_at timestamp(6) without time zone NOT NULL,
    supervisor_id bigint,
    pid integer NOT NULL,
    hostname character varying,
    metadata text,
    created_at timestamp(6) without time zone NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.solid_queue_processes OWNER TO chima;

--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_processes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_processes_id_seq OWNER TO chima;

--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_processes_id_seq OWNED BY public.solid_queue_processes.id;


--
-- Name: solid_queue_ready_executions; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_ready_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_ready_executions OWNER TO chima;

--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_ready_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_ready_executions_id_seq OWNER TO chima;

--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_ready_executions_id_seq OWNED BY public.solid_queue_ready_executions.id;


--
-- Name: solid_queue_recurring_executions; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_recurring_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    task_key character varying NOT NULL,
    run_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_recurring_executions OWNER TO chima;

--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_recurring_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_recurring_executions_id_seq OWNER TO chima;

--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_recurring_executions_id_seq OWNED BY public.solid_queue_recurring_executions.id;


--
-- Name: solid_queue_recurring_tasks; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_recurring_tasks (
    id bigint NOT NULL,
    key character varying NOT NULL,
    schedule character varying NOT NULL,
    command character varying(2048),
    class_name character varying,
    arguments text,
    queue_name character varying,
    priority integer DEFAULT 0,
    static boolean DEFAULT true NOT NULL,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_recurring_tasks OWNER TO chima;

--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_recurring_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_recurring_tasks_id_seq OWNER TO chima;

--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_recurring_tasks_id_seq OWNED BY public.solid_queue_recurring_tasks.id;


--
-- Name: solid_queue_scheduled_executions; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_scheduled_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    scheduled_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_scheduled_executions OWNER TO chima;

--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_scheduled_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_scheduled_executions_id_seq OWNER TO chima;

--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_scheduled_executions_id_seq OWNED BY public.solid_queue_scheduled_executions.id;


--
-- Name: solid_queue_semaphores; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.solid_queue_semaphores (
    id bigint NOT NULL,
    key character varying NOT NULL,
    value integer DEFAULT 1 NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_semaphores OWNER TO chima;

--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.solid_queue_semaphores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solid_queue_semaphores_id_seq OWNER TO chima;

--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.solid_queue_semaphores_id_seq OWNED BY public.solid_queue_semaphores.id;


--
-- Name: support_requests; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.support_requests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    message text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category integer,
    status integer,
    priority integer,
    source integer
);


ALTER TABLE public.support_requests OWNER TO chima;

--
-- Name: support_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.support_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.support_requests_id_seq OWNER TO chima;

--
-- Name: support_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.support_requests_id_seq OWNED BY public.support_requests.id;


--
-- Name: template_blocks; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.template_blocks (
    id bigint NOT NULL,
    template_id bigint NOT NULL,
    block_type character varying NOT NULL,
    html_content text NOT NULL,
    settings jsonb,
    "position" integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.template_blocks OWNER TO chima;

--
-- Name: template_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.template_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_blocks_id_seq OWNER TO chima;

--
-- Name: template_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.template_blocks_id_seq OWNED BY public.template_blocks.id;


--
-- Name: templates; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.templates (
    id bigint NOT NULL,
    name character varying,
    description text,
    category character varying,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    public boolean,
    preview_image_url character varying,
    html_content text,
    theme character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.templates OWNER TO chima;

--
-- Name: templates_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templates_id_seq OWNER TO chima;

--
-- Name: templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.templates_id_seq OWNED BY public.templates.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.transactions (
    id bigint NOT NULL,
    amount integer,
    status character varying,
    payment_method character varying,
    user_id bigint NOT NULL,
    credit_account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    campaign_id bigint,
    campaign_uuid uuid
);


ALTER TABLE public.transactions OWNER TO chima;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_seq OWNER TO chima;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: chima
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email_address character varying,
    password_digest character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role integer DEFAULT 4 NOT NULL,
    plan_id bigint,
    time_zone character varying,
    remember_token character varying,
    company character varying,
    name character varying,
    password_reset_token character varying,
    password_reset_sent_at timestamp(6) without time zone
);


ALTER TABLE public.users OWNER TO chima;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: chima
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO chima;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chima
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: block_templates id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.block_templates ALTER COLUMN id SET DEFAULT nextval('public.block_templates_id_seq'::regclass);


--
-- Name: bounces id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.bounces ALTER COLUMN id SET DEFAULT nextval('public.bounces_id_seq'::regclass);


--
-- Name: campaign_emails id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaign_emails ALTER COLUMN id SET DEFAULT nextval('public.campaign_emails_id_seq'::regclass);


--
-- Name: campaigns id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaigns ALTER COLUMN id SET DEFAULT nextval('public.campaigns_id_seq'::regclass);


--
-- Name: credit_accounts id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.credit_accounts ALTER COLUMN id SET DEFAULT nextval('public.credit_accounts_id_seq'::regclass);


--
-- Name: email_blocks id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_blocks ALTER COLUMN id SET DEFAULT nextval('public.email_blocks_id_seq'::regclass);


--
-- Name: email_error_logs id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_error_logs ALTER COLUMN id SET DEFAULT nextval('public.email_error_logs_id_seq'::regclass);


--
-- Name: email_event_logs id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_event_logs ALTER COLUMN id SET DEFAULT nextval('public.email_event_logs_id_seq'::regclass);


--
-- Name: email_logs id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_logs ALTER COLUMN id SET DEFAULT nextval('public.email_logs_id_seq'::regclass);


--
-- Name: email_records id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_records ALTER COLUMN id SET DEFAULT nextval('public.email_records_id_seq'::regclass);


--
-- Name: industries id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.industries ALTER COLUMN id SET DEFAULT nextval('public.industries_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: plans id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);


--
-- Name: public_email_records id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.public_email_records ALTER COLUMN id SET DEFAULT nextval('public.public_email_records_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: scrape_targets id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.scrape_targets ALTER COLUMN id SET DEFAULT nextval('public.scrape_targets_id_seq'::regclass);


--
-- Name: scraping_sources id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.scraping_sources ALTER COLUMN id SET DEFAULT nextval('public.scraping_sources_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: solid_queue_blocked_executions id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_blocked_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_blocked_executions_id_seq'::regclass);


--
-- Name: solid_queue_claimed_executions id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_claimed_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_claimed_executions_id_seq'::regclass);


--
-- Name: solid_queue_failed_executions id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_failed_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_failed_executions_id_seq'::regclass);


--
-- Name: solid_queue_jobs id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_jobs ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_jobs_id_seq'::regclass);


--
-- Name: solid_queue_pauses id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_pauses ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_pauses_id_seq'::regclass);


--
-- Name: solid_queue_processes id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_processes ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_processes_id_seq'::regclass);


--
-- Name: solid_queue_ready_executions id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_ready_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_ready_executions_id_seq'::regclass);


--
-- Name: solid_queue_recurring_executions id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_recurring_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_recurring_executions_id_seq'::regclass);


--
-- Name: solid_queue_recurring_tasks id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_recurring_tasks ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_recurring_tasks_id_seq'::regclass);


--
-- Name: solid_queue_scheduled_executions id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_scheduled_executions_id_seq'::regclass);


--
-- Name: solid_queue_semaphores id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_semaphores ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_semaphores_id_seq'::regclass);


--
-- Name: support_requests id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.support_requests ALTER COLUMN id SET DEFAULT nextval('public.support_requests_id_seq'::regclass);


--
-- Name: template_blocks id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.template_blocks ALTER COLUMN id SET DEFAULT nextval('public.template_blocks_id_seq'::regclass);


--
-- Name: templates id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.templates ALTER COLUMN id SET DEFAULT nextval('public.templates_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-03-09 02:07:09.386339	2025-03-09 02:07:09.386343
\.


--
-- Data for Name: block_templates; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.block_templates (id, name, description, html_content, category, settings, public, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bounces; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.bounces (id, reason, bounced_at, email_record_id, created_at, updated_at, campaign_id, campaign_uuid) FROM stdin;
3	Dirección no válida	2025-03-12 01:40:34.86957	9	2025-03-12 01:40:34.872757	2025-03-22 06:12:10.016012	1	024eba05-3608-4a52-ac71-5a569d4daebf
2	Dirección no válida	2025-03-12 01:40:34.82225	5	2025-03-12 01:40:34.82598	2025-03-22 06:12:09.973985	1	024eba05-3608-4a52-ac71-5a569d4daebf
1	Dirección no válida	2025-03-12 01:40:34.775406	1	2025-03-12 01:40:34.777256	2025-03-22 06:12:09.967119	1	024eba05-3608-4a52-ac71-5a569d4daebf
\.


--
-- Data for Name: campaign_emails; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.campaign_emails (id, campaign_id, email_record_id, created_at, updated_at, campaign_uuid) FROM stdin;
1	1	1	2025-03-12 01:40:34.645869	2025-03-12 01:40:34.645869	024eba05-3608-4a52-ac71-5a569d4daebf
2	1	2	2025-03-12 01:40:34.658689	2025-03-12 01:40:34.658689	024eba05-3608-4a52-ac71-5a569d4daebf
3	1	3	2025-03-12 01:40:34.669343	2025-03-12 01:40:34.669343	024eba05-3608-4a52-ac71-5a569d4daebf
4	1	4	2025-03-12 01:40:34.680179	2025-03-12 01:40:34.680179	024eba05-3608-4a52-ac71-5a569d4daebf
5	1	5	2025-03-12 01:40:34.68853	2025-03-12 01:40:34.68853	024eba05-3608-4a52-ac71-5a569d4daebf
6	1	6	2025-03-12 01:40:34.701887	2025-03-12 01:40:34.701887	024eba05-3608-4a52-ac71-5a569d4daebf
7	1	7	2025-03-12 01:40:34.712844	2025-03-12 01:40:34.712844	024eba05-3608-4a52-ac71-5a569d4daebf
8	1	8	2025-03-12 01:40:34.725173	2025-03-12 01:40:34.725173	024eba05-3608-4a52-ac71-5a569d4daebf
9	1	9	2025-03-12 01:40:34.734263	2025-03-12 01:40:34.734263	024eba05-3608-4a52-ac71-5a569d4daebf
10	1	10	2025-03-12 01:40:34.744047	2025-03-12 01:40:34.744047	024eba05-3608-4a52-ac71-5a569d4daebf
11	6	19	2025-03-26 03:27:16.776124	2025-03-26 03:27:16.776124	0f32ec4d-470d-4829-8bcd-048957a5e185
12	6	20	2025-03-26 03:27:16.782977	2025-03-26 03:27:16.782977	0f32ec4d-470d-4829-8bcd-048957a5e185
13	6	21	2025-03-26 03:27:16.786858	2025-03-26 03:27:16.786858	0f32ec4d-470d-4829-8bcd-048957a5e185
\.


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.campaigns (id, email_limit, status, user_id, industry_id, created_at, updated_at, subject, body, template_id, send_at, html_content, name, uuid, canvas_cleared) FROM stdin;
1	500	pending	2	1	2025-03-11 01:40:34.486329	2025-03-12 01:40:34.487104	\N	\N	\N	\N	\N	\N	024eba05-3608-4a52-ac71-5a569d4daebf	f
3	5	completed	3	3	2025-03-22 03:19:20.894552	2025-03-22 03:42:55.971333	Promoción exclusiva para tu empresa 📨	<h1>Hola!</h1><p>Te presentamos una oferta imperdible.</p>	\N	\N	\N	\N	45f1cac8-ee63-493e-a04b-784a16289dac	f
6	3	completed	1	1	2025-03-26 03:26:49.070125	2025-03-26 03:29:02.31995	Falla crítica	<p>Error test</p>	\N	\N	\N	\N	0f32ec4d-470d-4829-8bcd-048957a5e185	f
2	1	completed	1	1	2025-03-19 04:54:07.649944	2025-03-28 17:17:33.875401	¡Hola desde AWS SES!	<h1>Probando envío real vía AWS SES 😎</h1><p>Este es un test.</p>	\N	\N	\N	\N	b4570b6b-9283-4956-8371-2c88ba49d56b	f
5	3	completed	1	1	2025-03-26 03:19:27.78916	2025-03-28 17:32:02.349405	Falla crítica	<p>Error test</p>	\N	\N	\N	\N	344200ac-2c83-4a99-bbf6-3f78cc21e0c8	f
7	1	completed	1	1	2025-03-26 06:07:14.98341	2025-03-29 03:56:56.979806	Sin intentos	<p>Nada se intentó</p>	\N	\N	\N	\N	8196a156-67eb-4f2f-b387-c5444a6deb59	f
4	5	sending	3	3	2025-03-22 03:46:47.395294	2025-04-02 04:28:35.808129	🎉 Oferta exclusiva para clientes especiales	<h1>¡Hola!</h1><p>Tenemos una promoción especial solo para ti.</p>	\N	\N	\N	\N	daad37ec-7b17-49fe-a333-f8b257cd9911	f
\.


--
-- Data for Name: credit_accounts; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.credit_accounts (id, available_credit, user_id, created_at, updated_at) FROM stdin;
2	1000	1	2025-03-12 01:08:41.115222	2025-03-12 01:08:41.115222
1	590	2	2025-03-11 05:34:35.839506	2025-03-15 03:06:52.31082
\.


--
-- Data for Name: email_blocks; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.email_blocks (id, campaign_id, user_id, block_template_id, name, block_type, html_content, settings, "position", created_at, updated_at, campaign_uuid) FROM stdin;
9	7	1	\N	\N	hero-basic	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_basic.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-basic"\n     data-block-id="block-2a143e56-4a23-4648-9fce-732fa51c1079"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-block text-center px-4 py-5">\n    <!-- Imagen principal -->\n    <img src="https://placehold.co/480x180?text=Banner"\n         alt="Hero Básico"\n         class="mb-4 rounded shadow-sm mx-auto d-block"\n         style="max-width: 400px; width: 100%; height: auto;">\n    \n    <!-- Título -->\n    <h1 class="fw-bold mb-2" style="font-size: 2rem;">\n      Hero Básico\n    </h1>\n    \n    <!-- Texto introductorio -->\n    <p class="text-muted mb-3" style="font-size: 1.08rem;">\n      Imagen, texto y botón\n    </p>\n    \n    <!-- Botón principal -->\n    <a href="#" class="btn btn-success px-4" style="font-size:1.05rem;">\n      Botón\n    </a>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb -->	\N	\N	2025-06-10 04:41:49.81834	2025-06-10 04:41:49.81834	\N
10	7	1	\N	\N	hero-basic	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_basic.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-basic"\n     data-block-id="block-80f8d153-2cd3-4afb-ba99-7c5d5d30e4eb"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-block text-center px-4 py-5">\n    <!-- Imagen principal -->\n    <img src="https://placehold.co/480x180?text=Banner"\n         alt="Hero Básico"\n         class="mb-4 rounded shadow-sm mx-auto d-block"\n         style="max-width: 400px; width: 100%; height: auto;">\n    \n    <!-- Título -->\n    <h1 class="fw-bold mb-2" style="font-size: 2rem;">\n      Hero Básico\n    </h1>\n    \n    <!-- Texto introductorio -->\n    <p class="text-muted mb-3" style="font-size: 1.08rem;">\n      Imagen, texto y botón\n    </p>\n    \n    <!-- Botón principal -->\n    <a href="#" class="btn btn-success px-4" style="font-size:1.05rem;">\n      Botón\n    </a>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb -->	\N	\N	2025-06-10 05:09:26.997796	2025-06-10 05:09:26.997796	\N
11	7	1	\N	\N	hero-image	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_image.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_image.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-image"\n     data-block-id="block-ce8af0ab-9e29-45bb-b9d7-d3bbfd01644a"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-image-block text-center px-4 py-5">\n    <img src="https://placehold.co/480x220?text=Main+Image"\n         alt="Hero con Imagen"\n         class="mb-4 rounded shadow mx-auto d-block"\n         style="max-width: 460px; width: 100%; height: auto;">\n    <h2 class="fw-bold mb-2" style="font-size: 1.65rem;">\n      Hero con Imagen\n    </h2>\n    <p class="text-muted mb-3">\n      Imagen grande + texto\n    </p>\n    <a href="#" class="btn btn-primary px-4">\n      Botón\n    </a>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_image.html.erb -->	\N	\N	2025-06-10 05:10:15.597552	2025-06-10 05:10:15.597552	\N
12	7	1	\N	\N	hero-bg	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_bg.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_bg.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-bg"\n     data-block-id="block-a192e8cd-c0d9-499f-b04d-1cc0944d4fbf"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-bg-block text-center px-4 py-5" style="background: linear-gradient(90deg, #e0eafc, #cfdef3); border-radius: 8px;">\n    <h2 class="fw-bold mb-2" style="font-size: 1.6rem;">\n      Hero con Fondo\n    </h2>\n    <p class="mb-3">\n      Fondo de color o gradiente\n    </p>\n    <a href="#" class="btn btn-info px-4">\n      Botón\n    </a>\n  </div>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_bg.html.erb -->	\N	\N	2025-06-10 05:11:19.835059	2025-06-10 05:11:19.835059	\N
13	7	1	\N	\N	hero-video	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_video.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_video.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-video"\n     data-block-id="block-7591bca5-4853-4070-8ef8-658d1e3fd413"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-video-block text-center px-4 py-5">\n    <div class="mb-4" style="position: relative; width: 100%; max-width: 440px; margin: 0 auto;">\n      <img src="https://placehold.co/440x220?text=Video+Thumbnail" alt="Video Preview" style="width: 100%; border-radius: 8px;">\n      <span style="position: absolute; left: 50%; top: 50%; transform: translate(-50%, -50%);">\n        <svg width="56" height="56" fill="#19c37d" viewBox="0 0 20 20"><polygon points="8,5 15,10 8,15" /></svg>\n      </span>\n    </div>\n    <h2 class="fw-bold mb-2">Hero Video</h2>\n    <p class="text-muted mb-3">\n      Video embebido\n    </p>\n    <a href="#" class="btn btn-primary px-4">\n      Botón\n    </a>\n  </div>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_video.html.erb -->	\N	\N	2025-06-10 05:26:24.933483	2025-06-10 05:26:24.933483	\N
14	7	1	\N	\N	hero-overlay	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_overlay.html.erb --><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_overlay.html.erb -->	\N	\N	2025-06-10 05:26:35.553895	2025-06-10 05:26:35.553895	\N
15	7	1	\N	\N	hero-basic	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_basic.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-basic"\n     data-block-id="block-436b2b52-9e58-404f-8fe1-70fa011ba1c7"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-block text-center px-4 py-5">\n    <!-- Imagen principal -->\n    <img src="https://placehold.co/480x180?text=Banner"\n         alt="Hero Básico"\n         class="mb-4 rounded shadow-sm mx-auto d-block"\n         style="max-width: 400px; width: 100%; height: auto;">\n    \n    <!-- Título -->\n    <h1 class="fw-bold mb-2" style="font-size: 2rem;">\n      Hero Básico\n    </h1>\n    \n    <!-- Texto introductorio -->\n    <p class="text-muted mb-3" style="font-size: 1.08rem;">\n      Imagen, texto y botón\n    </p>\n    \n    <!-- Botón principal -->\n    <a href="#" class="btn btn-success px-4" style="font-size:1.05rem;">\n      Botón\n    </a>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb -->	\N	\N	2025-06-10 05:27:11.891544	2025-06-10 05:27:11.891544	\N
16	7	1	\N	\N	navigation-logo	<div>Bloque no disponible aún</div>	\N	\N	2025-06-10 05:27:51.43972	2025-06-10 05:27:51.43972	\N
18	7	1	\N	\N	navigation-logo	<div>Bloque no disponible aún</div>	\N	\N	2025-06-11 03:38:33.695505	2025-06-11 03:38:33.695505	\N
19	7	1	\N	\N	navigation-logo_text	<div>Bloque no disponible aún</div>	\N	\N	2025-06-11 03:38:43.802537	2025-06-11 03:38:43.802537	\N
20	7	1	\N	\N	navigation-logo	<div>Bloque no disponible aún</div>	\N	\N	2025-06-11 05:21:47.084829	2025-06-11 05:21:47.084829	\N
22	7	1	\N	\N	hero-basic	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_basic.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-basic"\n     data-block-id="block-d5547c9a-f95f-4e38-af49-f5dc612aa89d"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-block text-center px-4 py-5 ">\n    <!-- Imagen principal -->\n    <img src="https://placehold.co/480x180?text=Banner"\n         alt="Hero Básico"\n         class="mb-4 rounded shadow-sm mx-auto d-block"\n         style="max-width: 400px; width: 100%; height: auto;">\n    \n    <!-- Título -->\n    <h1 class="fw-bold mb-2" style="font-size: 2rem;">\n      Hero Básico\n    </h1>\n    \n    <!-- Texto introductorio -->\n    <p class="text-muted mb-3" style="font-size: 1.08rem;">\n      Imagen, texto y botón\n    </p>\n    \n    <!-- Botón principal -->\n    <a href="#" class="btn btn-success px-4" style="font-size:1.05rem;">\n      Botón\n    </a>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb -->	\N	\N	2025-06-11 05:49:08.684423	2025-06-11 05:49:08.684423	\N
23	7	1	\N	\N	hero-video	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_video.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_video.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-video"\n     data-block-id="block-ecff88f2-a06d-4c48-abd5-2772fa33128e"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-video-block text-center px-4 py-5">\n    <div class="mb-4" style="position: relative; width: 100%; max-width: 440px; margin: 0 auto;">\n      <img src="https://placehold.co/440x220?text=Video+Thumbnail" alt="Video Preview" style="width: 100%; border-radius: 8px;">\n      <span style="position: absolute; left: 50%; top: 50%; transform: translate(-50%, -50%);">\n        <svg width="56" height="56" fill="#19c37d" viewBox="0 0 20 20"><polygon points="8,5 15,10 8,15" /></svg>\n      </span>\n    </div>\n    <h2 class="fw-bold mb-2">Hero Video</h2>\n    <p class="text-muted mb-3">\n      Video embebido\n    </p>\n    <a href="#" class="btn btn-primary px-4">\n      Botón\n    </a>\n  </div>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_video.html.erb -->	\N	\N	2025-06-11 05:59:59.27242	2025-06-11 05:59:59.27242	\N
24	7	1	\N	\N	hero-overlay	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_overlay.html.erb --><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_overlay.html.erb -->	\N	\N	2025-06-11 06:00:18.068065	2025-06-11 06:00:18.068065	\N
25	7	1	\N	\N	hero-icon	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_icon.html.erb --><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_icon.html.erb -->	\N	\N	2025-06-11 06:00:35.272804	2025-06-11 06:00:35.272804	\N
26	7	1	\N	\N	hero-image	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_image.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_image.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-image"\n     data-block-id="block-d53b8beb-e7c0-4ca5-9dbd-fb9ed011340c"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-image-block text-center px-4 py-5">\n    <img src="https://placehold.co/480x220?text=Main+Image"\n         alt="Hero con Imagen"\n         class="mb-4 rounded shadow mx-auto d-block"\n         style="max-width: 460px; width: 100%; height: auto;">\n    <h2 class="fw-bold mb-2" style="font-size: 1.65rem;">\n      Hero con Imagen\n    </h2>\n    <p class="text-muted mb-3">\n      Imagen grande + texto\n    </p>\n    <a href="#" class="btn btn-primary px-4">\n      Botón\n    </a>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_image.html.erb -->	\N	\N	2025-06-11 06:00:56.481536	2025-06-11 06:00:56.481536	\N
27	7	1	\N	\N	hero-bg	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_bg.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_bg.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-bg"\n     data-block-id="block-3261eff3-a4e8-4211-99ff-62193af5e975"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-bg-block text-center px-4 py-5" style="background: linear-gradient(90deg, #e0eafc, #cfdef3); border-radius: 8px;">\n    <h2 class="fw-bold mb-2" style="font-size: 1.6rem;">\n      Hero con Fondo\n    </h2>\n    <p class="mb-3">\n      Fondo de color o gradiente\n    </p>\n    <a href="#" class="btn btn-info px-4">\n      Botón\n    </a>\n  </div>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_bg.html.erb -->	\N	\N	2025-06-11 06:01:06.483024	2025-06-11 06:01:06.483024	\N
28	7	1	\N	\N	hero-center	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_center.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_center.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-center"\n     data-block-id="block-711507e0-6c19-4423-94e2-e52464fd07a9"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-center-block text-center px-4 py-5" style="background: #fafbfc; border-radius: 8px;">\n    <h2 class="fw-bold mb-2" style="font-size: 2rem;">\n      Hero Centrado\n    </h2>\n    <p class="mb-3 text-muted">\n      Contenido alineado al centro\n    </p>\n    <a href="#" class="btn btn-success px-4">\n      Botón\n    </a>\n  </div>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_center.html.erb -->	\N	\N	2025-06-11 06:01:17.475443	2025-06-11 06:01:17.475443	\N
29	7	1	\N	\N	logo	<div>Bloque no disponible aún</div>	\N	\N	2025-06-11 06:01:58.637515	2025-06-11 06:01:58.637515	\N
30	7	1	\N	\N	nav_main	<div>Bloque no disponible aún</div>	\N	\N	2025-06-11 06:04:43.225192	2025-06-11 06:04:43.225192	\N
31	7	1	\N	\N	logo_nav	<div>Bloque no disponible aún</div>	\N	\N	2025-06-11 06:04:50.570881	2025-06-11 06:04:50.570881	\N
32	7	1	\N	\N	logo_button	<div>Bloque no disponible aún</div>	\N	\N	2025-06-11 06:04:58.544198	2025-06-11 06:04:58.544198	\N
33	7	1	\N	\N	hero-basic	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_basic.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-basic"\n     data-block-id="block-ec42eee2-f076-429a-955d-ded18615eaff"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-block text-center px-4 py-5 ">\n    <!-- Imagen principal -->\n    <img src="https://placehold.co/480x180?text=Banner"\n         alt="Hero Básico"\n         class="mb-4 rounded shadow-sm mx-auto d-block"\n         style="max-width: 400px; width: 100%; height: auto;">\n    \n    <!-- Título -->\n    <h1 class="fw-bold mb-2" style="font-size: 2rem;">\n      Hero Básico\n    </h1>\n    \n    <!-- Texto introductorio -->\n    <p class="text-muted mb-3" style="font-size: 1.08rem;">\n      Imagen, texto y botón\n    </p>\n    \n    <!-- Botón principal -->\n    <a href="#" class="btn btn-success px-4" style="font-size:1.05rem;">\n      Botón\n    </a>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_basic.html.erb -->	\N	\N	2025-06-11 06:05:56.004383	2025-06-11 06:05:56.004383	\N
34	7	1	\N	\N	navigation-logo	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="navigation-logo"\n     data-block-id="block-4f5f8ce9-53d7-4227-a9c0-eebfcd5d3896"\n     data-category="navigation">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  <div class="email-block-logo d-flex align-items-center border rounded p-2" style="min-height:48px;">\n    <img src="https://placehold.co/32x32?text=Logo" alt="Company Logo" class="me-2" style="height:32px;">\n    <span class="fw-semibold text-muted">Company</span>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb -->	\N	\N	2025-06-11 06:34:15.399153	2025-06-11 06:34:15.399153	\N
35	7	1	\N	\N	navigation-nav_main	<div>Bloque no disponible aún</div>	\N	\N	2025-06-11 06:35:21.108754	2025-06-11 06:35:21.108754	\N
36	7	1	\N	\N	navigation-logo_nav	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_nav.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_logo_nav.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="navigation_nav"\n     data-block-id="block-79c9aeb2-5392-434d-a331-8a5afa282620"\n     data-category="navigation">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  <div class="email-block-logo-nav d-flex align-items-center border rounded p-2" style="min-height:48px;">\n    <img src="https://placehold.co/32x32?text=Logo" alt="Company Logo" class="me-2" style="height:32px;">\n    <span class="fw-semibold text-muted me-4">Company</span>\n    <ul class="d-flex gap-4 list-unstyled mb-0 align-items-center">\n      <li><a href="#" class="text-muted text-decoration-none">About</a></li>\n      <li><a href="#" class="text-muted text-decoration-none">Work</a></li>\n      <li><a href="#" class="text-muted text-decoration-none">Blog</a></li>\n    </ul>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_nav.html.erb -->	\N	\N	2025-06-11 06:35:30.027573	2025-06-11 06:35:30.027573	\N
37	7	1	\N	\N	navigation-logo_center_nav	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_center_nav.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_logo_center_nav.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="navigation-logo_center_nav"\n     data-block-id="block-d0d5dc6d-36a9-40c5-8f75-41828feeadfb"\n     data-category="navigation">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  <div class="email-block-logo-center-nav d-flex flex-column align-items-center border rounded p-2" style="min-height:48px;">\n    <img src="https://placehold.co/32x32?text=Logo" alt="Company Logo" class="mb-1" style="height:32px;">\n    <span class="fw-semibold text-muted mb-2">Company</span>\n    <ul class="d-flex gap-4 list-unstyled mb-0 align-items-center justify-content-center">\n      <li><a href="#" class="text-muted text-decoration-none">About</a></li>\n      <li><a href="#" class="text-muted text-decoration-none">Work</a></li>\n      <li><a href="#" class="text-muted text-decoration-none">Blog</a></li>\n    </ul>\n  </div>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_center_nav.html.erb -->	\N	\N	2025-06-11 06:35:47.523579	2025-06-11 06:35:47.523579	\N
38	7	1	\N	\N	navigation-logo_nav_compact	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_nav_compact.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_logo_nav_compact.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="navigation_logo_nav_compact"\n     data-block-id="block-7a4613da-5a86-4e71-aefc-4d9a95c70633"\n     data-category="navigation">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  <div class="email-block-logo-nav-compact d-flex align-items-center border rounded p-2 justify-content-between" style="min-height:48px;">\n    <img src="https://placehold.co/32x32?text=Logo" alt="Company Logo" class="me-2" style="height:32px;">\n    <span class="fw-semibold text-muted">Company</span>\n    <ul class="d-flex gap-3 list-unstyled mb-0 align-items-center ms-auto">\n      <li><a href="#" class="text-muted text-decoration-none">About</a></li>\n      <li><a href="#" class="text-muted text-decoration-none">Work</a></li>\n      <li><a href="#" class="text-muted text-decoration-none">Blog</a></li>\n    </ul>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_nav_compact.html.erb -->	\N	\N	2025-06-11 06:35:59.074993	2025-06-11 06:35:59.074993	\N
39	7	1	\N	\N	navigation-logo_button	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_button.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_logo_button.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="navigation-logo_button"\n     data-block-id="block-4289b7af-0bea-4773-aaec-1bfbe19f20c7"\n     data-category="navigation">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  <div class="email-block-logo-btn d-flex align-items-center border rounded p-2 justify-content-between" style="min-height:48px;">\n    <div class="d-flex align-items-center">\n      <img src="https://placehold.co/32x32?text=Logo" alt="Company Logo" class="me-2" style="height:32px;">\n      <span class="fw-semibold text-muted">Company</span>\n    </div>\n    <a href="#" class="btn btn-dark btn-sm ms-auto">Button</a>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_button.html.erb -->	\N	\N	2025-06-11 06:36:09.977168	2025-06-11 06:36:09.977168	\N
40	7	1	\N	\N	navigation-logo_social	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_social.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_logo_social.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="navigation-logo_social"\n     data-block-id="block-6a2caee0-0d09-4e0e-bbee-d8e512e92f4b"\n     data-category="navigation">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  <div class="email-block-logo-social d-flex align-items-center border rounded p-2 justify-content-between" style="min-height:48px;">\n    <div class="d-flex align-items-center">\n      <img src="https://placehold.co/32x32?text=Logo" alt="Company Logo" class="me-2" style="height:32px;">\n      <span class="fw-semibold text-muted">Company</span>\n    </div>\n    <div class="d-flex align-items-center ms-auto gap-2">\n      <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>\n      <a href="#" title="Facebook"><i class="fab fa-facebook"></i></a>\n      <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>\n    </div>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo_social.html.erb -->	\N	\N	2025-06-11 06:36:25.691186	2025-06-11 06:36:25.691186	\N
41	7	1	\N	\N	hero-video	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_video.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_video.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="hero-video"\n     data-block-id="block-37b3a62a-9f48-494b-937b-63536f87fc80"\n     data-category="hero">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  \n  <div class="email-hero-video-block text-center px-4 py-5">\n    <div class="mb-4" style="position: relative; width: 100%; max-width: 440px; margin: 0 auto;">\n      <img src="https://placehold.co/440x220?text=Video+Thumbnail" alt="Video Preview" style="width: 100%; border-radius: 8px;">\n      <span style="position: absolute; left: 50%; top: 50%; transform: translate(-50%, -50%);">\n        <svg width="56" height="56" fill="#19c37d" viewBox="0 0 20 20"><polygon points="8,5 15,10 8,15" /></svg>\n      </span>\n    </div>\n    <h2 class="fw-bold mb-2">Hero Video</h2>\n    <p class="text-muted mb-3">\n      Video embebido\n    </p>\n    <a href="#" class="btn btn-primary px-4">\n      Botón\n    </a>\n  </div>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/hero/_hero_video.html.erb -->	\N	\N	2025-06-11 06:36:40.972135	2025-06-11 06:36:40.972135	\N
42	7	1	\N	\N	navigation-logo	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="navigation-logo"\n     data-block-id="block-010e0bd6-f908-455b-97bb-e306ba328dea"\n     data-category="navigation">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  <div class="email-block-logo d-flex align-items-center border rounded p-2" style="min-height:48px;">\n    <img src="https://placehold.co/32x32?text=Logo" alt="Company Logo" class="me-2" style="height:32px;">\n    <span class="fw-semibold text-muted">Company</span>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb -->	\N	\N	2025-06-11 07:16:40.352408	2025-06-11 07:16:40.352408	\N
43	7	1	\N	\N	navigation-logo	<!-- BEGIN app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb --><!-- app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb -->\n<div class="email-block"\n     data-controller="block"\n     data-block-type="navigation-logo"\n     data-block-id="block-4009b239-4fc2-479a-ac19-79fc209e4035"\n     data-category="navigation">\n  <!-- BEGIN app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb --><!-- app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n<div class="block-actions d-flex gap-1 position-absolute p-1" style="z-index:3;">\n  <!-- Arrastrar (sólo el handle activa el drag) -->\n  <button type="button"\n          class="btn btn-xs btn-light drag-handle"\n          title="Arrastra para mover"\n          data-action="mousedown->block#enableDrag mouseup->block#disableDrag mouseleave->block#disableDrag">\n    <i class="bx bx-move"></i>\n  </button>\n\n\n  <!-- Mover arriba -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover arriba"\n          data-action="click->block#moveUp">\n    <i class="bx bx-chevron-up"></i>\n  </button>\n\n\n  <!-- Mover abajo -->\n  <button type="button"\n          class="btn btn-xs btn-light"\n          title="Mover abajo"\n          data-action="click->block#moveDown">\n    <i class="bx bx-chevron-down"></i>\n  </button>\n\n\n    <button type="button"\n        class="btn btn-xs btn-light"\n        title="Editar"\n        data-action="click->block#editProperties">\n        <i class="bx bx-edit-alt"></i>\n    </button>\n\n\n\n\n    <button type="button" \n            class="btn btn-xs btn-light" \n            title="Duplicar" \n            data-action="click->block#duplicate">\n      <i class="bx bx-duplicate"></i>\n    </button>\n\n\n\n    <button type="button" class="btn btn-xs btn-danger" \n            title="Eliminar" \n            data-action="click->block#remove">\n      <i class="bx bx-trash"></i>\n    </button>\n</div>\n<!-- END app/views/web/dashboard/campaigns/shared/_block_toolbar.html.erb -->\n  <div class="email-block-logo d-flex align-items-center border rounded p-2" style="min-height:48px;">\n    <img src="https://placehold.co/32x32?text=Logo" alt="Company Logo" class="me-2" style="height:32px;">\n    <span class="fw-semibold text-muted">Company</span>\n  </div>\n</div><!-- END app/views/web/dashboard/campaigns/shared/sidebar_blocks/navigation/_navigation_logo.html.erb -->	\N	\N	2025-06-11 07:27:42.977475	2025-06-11 07:27:42.977475	\N
\.


--
-- Data for Name: email_error_logs; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.email_error_logs (id, email, campaign_id, error, created_at, updated_at, campaign_uuid) FROM stdin;
1	test0@example.com	6	Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com	2025-03-26 03:29:02.144643	2025-03-26 03:29:02.144643	0f32ec4d-470d-4829-8bcd-048957a5e185
2	test1@example.com	6	Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com	2025-03-26 03:29:02.212899	2025-03-26 03:29:02.212899	0f32ec4d-470d-4829-8bcd-048957a5e185
3	test2@example.com	6	Email address is not verified. The following identities failed the check in region US-EAST-1: test2@example.com	2025-03-26 03:29:02.275231	2025-03-26 03:29:02.275231	0f32ec4d-470d-4829-8bcd-048957a5e185
4	test0@example.com	2	Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com	2025-03-28 17:17:33.844824	2025-03-28 17:17:33.844824	b4570b6b-9283-4956-8371-2c88ba49d56b
5	test0@example.com	5	Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com	2025-03-28 17:32:02.098505	2025-03-28 17:32:02.098505	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
6	test1@example.com	5	Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com	2025-03-28 17:32:02.223336	2025-03-28 17:32:02.223336	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
7	test2@example.com	5	Email address is not verified. The following identities failed the check in region US-EAST-1: test2@example.com	2025-03-28 17:32:02.298739	2025-03-28 17:32:02.298739	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
8	test0@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com	2025-03-29 02:02:56.878833	2025-03-29 02:02:56.878833	8196a156-67eb-4f2f-b387-c5444a6deb59
9	test0@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com	2025-03-29 03:46:41.104125	2025-03-29 03:46:41.104125	8196a156-67eb-4f2f-b387-c5444a6deb59
10	test1@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com	2025-03-29 03:46:41.193969	2025-03-29 03:46:41.193969	8196a156-67eb-4f2f-b387-c5444a6deb59
11	test2@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test2@example.com	2025-03-29 03:46:41.271933	2025-03-29 03:46:41.271933	8196a156-67eb-4f2f-b387-c5444a6deb59
12	test3@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test3@example.com	2025-03-29 03:46:41.345511	2025-03-29 03:46:41.345511	8196a156-67eb-4f2f-b387-c5444a6deb59
13	test4@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test4@example.com	2025-03-29 03:46:41.429435	2025-03-29 03:46:41.429435	8196a156-67eb-4f2f-b387-c5444a6deb59
14	test5@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test5@example.com	2025-03-29 03:46:41.492491	2025-03-29 03:46:41.492491	8196a156-67eb-4f2f-b387-c5444a6deb59
15	test6@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test6@example.com	2025-03-29 03:46:41.566084	2025-03-29 03:46:41.566084	8196a156-67eb-4f2f-b387-c5444a6deb59
16	test7@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test7@example.com	2025-03-29 03:46:41.633158	2025-03-29 03:46:41.633158	8196a156-67eb-4f2f-b387-c5444a6deb59
17	test8@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test8@example.com	2025-03-29 03:46:41.696478	2025-03-29 03:46:41.696478	8196a156-67eb-4f2f-b387-c5444a6deb59
18	test9@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test9@example.com	2025-03-29 03:46:41.759387	2025-03-29 03:46:41.759387	8196a156-67eb-4f2f-b387-c5444a6deb59
19	test_user_19@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_19@example.com	2025-03-29 03:46:41.825838	2025-03-29 03:46:41.825838	8196a156-67eb-4f2f-b387-c5444a6deb59
20	jenine_schuppe@ziemann-gleichner.example	7	Email address is not verified. The following identities failed the check in region US-EAST-1: jenine_schuppe@ziemann-gleichner.example	2025-03-29 03:46:41.889196	2025-03-29 03:46:41.889196	8196a156-67eb-4f2f-b387-c5444a6deb59
21	enoch@rice.test	7	Email address is not verified. The following identities failed the check in region US-EAST-1: enoch@rice.test	2025-03-29 03:46:41.947362	2025-03-29 03:46:41.947362	8196a156-67eb-4f2f-b387-c5444a6deb59
22	yang@beier.example	7	Email address is not verified. The following identities failed the check in region US-EAST-1: yang@beier.example	2025-03-29 03:46:42.013786	2025-03-29 03:46:42.013786	8196a156-67eb-4f2f-b387-c5444a6deb59
23	johana@green.test	7	Email address is not verified. The following identities failed the check in region US-EAST-1: johana@green.test	2025-03-29 03:46:42.074061	2025-03-29 03:46:42.074061	8196a156-67eb-4f2f-b387-c5444a6deb59
24	vanetta.bechtelar@dietrich.test	7	Email address is not verified. The following identities failed the check in region US-EAST-1: vanetta.bechtelar@dietrich.test	2025-03-29 03:46:42.148225	2025-03-29 03:46:42.148225	8196a156-67eb-4f2f-b387-c5444a6deb59
25	merissa_kohler@fahey-mueller.example	7	Email address is not verified. The following identities failed the check in region US-EAST-1: merissa_kohler@fahey-mueller.example	2025-03-29 03:46:42.216377	2025-03-29 03:46:42.216377	8196a156-67eb-4f2f-b387-c5444a6deb59
26	bounce@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: bounce@example.com	2025-03-29 03:46:42.282997	2025-03-29 03:46:42.282997	8196a156-67eb-4f2f-b387-c5444a6deb59
27	cliente1@ejemplo.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: cliente1@ejemplo.com	2025-03-29 03:46:42.345357	2025-03-29 03:46:42.345357	8196a156-67eb-4f2f-b387-c5444a6deb59
28	test_user_20@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_20@example.com	2025-03-29 03:46:42.406481	2025-03-29 03:46:42.406481	8196a156-67eb-4f2f-b387-c5444a6deb59
29	test_user_21@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_21@example.com	2025-03-29 03:46:42.47157	2025-03-29 03:46:42.47157	8196a156-67eb-4f2f-b387-c5444a6deb59
30	test_user_0@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_0@example.com	2025-03-29 03:46:42.528567	2025-03-29 03:46:42.528567	8196a156-67eb-4f2f-b387-c5444a6deb59
31	test_user_1@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_1@example.com	2025-03-29 03:46:42.594762	2025-03-29 03:46:42.594762	8196a156-67eb-4f2f-b387-c5444a6deb59
32	test_user_2@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_2@example.com	2025-03-29 03:46:42.65636	2025-03-29 03:46:42.65636	8196a156-67eb-4f2f-b387-c5444a6deb59
33	test_user_3@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_3@example.com	2025-03-29 03:46:42.718883	2025-03-29 03:46:42.718883	8196a156-67eb-4f2f-b387-c5444a6deb59
34	test_user_4@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_4@example.com	2025-03-29 03:46:42.78687	2025-03-29 03:46:42.78687	8196a156-67eb-4f2f-b387-c5444a6deb59
35	test_user_5@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_5@example.com	2025-03-29 03:46:42.858581	2025-03-29 03:46:42.858581	8196a156-67eb-4f2f-b387-c5444a6deb59
36	test_user_6@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_6@example.com	2025-03-29 03:46:42.922286	2025-03-29 03:46:42.922286	8196a156-67eb-4f2f-b387-c5444a6deb59
37	test_user_7@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_7@example.com	2025-03-29 03:46:42.988363	2025-03-29 03:46:42.988363	8196a156-67eb-4f2f-b387-c5444a6deb59
38	test_user_8@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_8@example.com	2025-03-29 03:46:43.065701	2025-03-29 03:46:43.065701	8196a156-67eb-4f2f-b387-c5444a6deb59
39	test_user_9@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_9@example.com	2025-03-29 03:46:43.135466	2025-03-29 03:46:43.135466	8196a156-67eb-4f2f-b387-c5444a6deb59
40	test_user_10@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_10@example.com	2025-03-29 03:46:43.199696	2025-03-29 03:46:43.199696	8196a156-67eb-4f2f-b387-c5444a6deb59
41	test_user_11@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_11@example.com	2025-03-29 03:46:43.263078	2025-03-29 03:46:43.263078	8196a156-67eb-4f2f-b387-c5444a6deb59
42	test_user_12@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_12@example.com	2025-03-29 03:46:43.327031	2025-03-29 03:46:43.327031	8196a156-67eb-4f2f-b387-c5444a6deb59
43	test_user_13@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_13@example.com	2025-03-29 03:46:43.394457	2025-03-29 03:46:43.394457	8196a156-67eb-4f2f-b387-c5444a6deb59
44	test_user_14@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_14@example.com	2025-03-29 03:46:43.461401	2025-03-29 03:46:43.461401	8196a156-67eb-4f2f-b387-c5444a6deb59
45	test_user_15@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_15@example.com	2025-03-29 03:46:43.546825	2025-03-29 03:46:43.546825	8196a156-67eb-4f2f-b387-c5444a6deb59
46	test_user_16@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_16@example.com	2025-03-29 03:46:43.637145	2025-03-29 03:46:43.637145	8196a156-67eb-4f2f-b387-c5444a6deb59
47	test_user_17@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_17@example.com	2025-03-29 03:46:43.696181	2025-03-29 03:46:43.696181	8196a156-67eb-4f2f-b387-c5444a6deb59
48	test_user_18@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_18@example.com	2025-03-29 03:46:43.765106	2025-03-29 03:46:43.765106	8196a156-67eb-4f2f-b387-c5444a6deb59
49	test_user_22@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_22@example.com	2025-03-29 03:46:43.84008	2025-03-29 03:46:43.84008	8196a156-67eb-4f2f-b387-c5444a6deb59
50	test_user_23@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_23@example.com	2025-03-29 03:46:43.916752	2025-03-29 03:46:43.916752	8196a156-67eb-4f2f-b387-c5444a6deb59
51	test_user_24@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_24@example.com	2025-03-29 03:46:44.01039	2025-03-29 03:46:44.01039	8196a156-67eb-4f2f-b387-c5444a6deb59
52	test_user_25@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_25@example.com	2025-03-29 03:46:44.074467	2025-03-29 03:46:44.074467	8196a156-67eb-4f2f-b387-c5444a6deb59
53	test_user_26@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_26@example.com	2025-03-29 03:46:44.138171	2025-03-29 03:46:44.138171	8196a156-67eb-4f2f-b387-c5444a6deb59
54	test_user_27@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_27@example.com	2025-03-29 03:46:44.196336	2025-03-29 03:46:44.196336	8196a156-67eb-4f2f-b387-c5444a6deb59
55	test_user_28@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_28@example.com	2025-03-29 03:46:44.254709	2025-03-29 03:46:44.254709	8196a156-67eb-4f2f-b387-c5444a6deb59
56	test_user_29@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_29@example.com	2025-03-29 03:46:44.319439	2025-03-29 03:46:44.319439	8196a156-67eb-4f2f-b387-c5444a6deb59
57	test_user_30@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_30@example.com	2025-03-29 03:46:44.383075	2025-03-29 03:46:44.383075	8196a156-67eb-4f2f-b387-c5444a6deb59
58	test_user_31@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_31@example.com	2025-03-29 03:46:44.445097	2025-03-29 03:46:44.445097	8196a156-67eb-4f2f-b387-c5444a6deb59
59	test_user_32@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_32@example.com	2025-03-29 03:46:44.507901	2025-03-29 03:46:44.507901	8196a156-67eb-4f2f-b387-c5444a6deb59
60	test_user_33@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_33@example.com	2025-03-29 03:46:44.568992	2025-03-29 03:46:44.568992	8196a156-67eb-4f2f-b387-c5444a6deb59
61	test_user_34@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_34@example.com	2025-03-29 03:46:44.624188	2025-03-29 03:46:44.624188	8196a156-67eb-4f2f-b387-c5444a6deb59
62	test_user_35@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_35@example.com	2025-03-29 03:46:44.683673	2025-03-29 03:46:44.683673	8196a156-67eb-4f2f-b387-c5444a6deb59
63	test_user_36@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_36@example.com	2025-03-29 03:46:44.747889	2025-03-29 03:46:44.747889	8196a156-67eb-4f2f-b387-c5444a6deb59
64	test_user_37@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_37@example.com	2025-03-29 03:46:44.806977	2025-03-29 03:46:44.806977	8196a156-67eb-4f2f-b387-c5444a6deb59
65	test_user_38@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_38@example.com	2025-03-29 03:46:44.870518	2025-03-29 03:46:44.870518	8196a156-67eb-4f2f-b387-c5444a6deb59
66	test_user_39@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_39@example.com	2025-03-29 03:46:44.91032	2025-03-29 03:46:44.91032	8196a156-67eb-4f2f-b387-c5444a6deb59
67	test_user_40@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_40@example.com	2025-03-29 03:46:44.976224	2025-03-29 03:46:44.976224	8196a156-67eb-4f2f-b387-c5444a6deb59
68	test_user_41@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_41@example.com	2025-03-29 03:46:45.044759	2025-03-29 03:46:45.044759	8196a156-67eb-4f2f-b387-c5444a6deb59
69	test_user_42@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_42@example.com	2025-03-29 03:46:45.10982	2025-03-29 03:46:45.10982	8196a156-67eb-4f2f-b387-c5444a6deb59
70	test_user_43@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_43@example.com	2025-03-29 03:46:45.178225	2025-03-29 03:46:45.178225	8196a156-67eb-4f2f-b387-c5444a6deb59
71	test_user_44@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_44@example.com	2025-03-29 03:46:45.240813	2025-03-29 03:46:45.240813	8196a156-67eb-4f2f-b387-c5444a6deb59
72	test_user_45@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_45@example.com	2025-03-29 03:46:45.30041	2025-03-29 03:46:45.30041	8196a156-67eb-4f2f-b387-c5444a6deb59
73	test_user_46@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:46:47.47623	2025-03-29 03:46:47.47623	8196a156-67eb-4f2f-b387-c5444a6deb59
74	test_user_47@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:46:49.67869	2025-03-29 03:46:49.67869	8196a156-67eb-4f2f-b387-c5444a6deb59
75	test_user_48@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:46:51.837856	2025-03-29 03:46:51.837856	8196a156-67eb-4f2f-b387-c5444a6deb59
76	test_user_49@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:46:54.037435	2025-03-29 03:46:54.037435	8196a156-67eb-4f2f-b387-c5444a6deb59
77	test_user_50@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:46:56.23203	2025-03-29 03:46:56.23203	8196a156-67eb-4f2f-b387-c5444a6deb59
78	test_user_51@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_51@example.com	2025-03-29 03:46:57.235267	2025-03-29 03:46:57.235267	8196a156-67eb-4f2f-b387-c5444a6deb59
79	test_user_52@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_52@example.com	2025-03-29 03:46:57.295293	2025-03-29 03:46:57.295293	8196a156-67eb-4f2f-b387-c5444a6deb59
80	test_user_53@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_53@example.com	2025-03-29 03:46:57.352018	2025-03-29 03:46:57.352018	8196a156-67eb-4f2f-b387-c5444a6deb59
81	test_user_54@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_54@example.com	2025-03-29 03:46:57.420245	2025-03-29 03:46:57.420245	8196a156-67eb-4f2f-b387-c5444a6deb59
82	test_user_55@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:46:59.600774	2025-03-29 03:46:59.600774	8196a156-67eb-4f2f-b387-c5444a6deb59
83	test_user_56@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_56@example.com	2025-03-29 03:47:01.819823	2025-03-29 03:47:01.819823	8196a156-67eb-4f2f-b387-c5444a6deb59
84	test_user_57@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_57@example.com	2025-03-29 03:47:01.854209	2025-03-29 03:47:01.854209	8196a156-67eb-4f2f-b387-c5444a6deb59
85	test_user_58@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_58@example.com	2025-03-29 03:47:01.929247	2025-03-29 03:47:01.929247	8196a156-67eb-4f2f-b387-c5444a6deb59
86	test_user_59@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_59@example.com	2025-03-29 03:47:01.990931	2025-03-29 03:47:01.990931	8196a156-67eb-4f2f-b387-c5444a6deb59
87	test_user_60@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_60@example.com	2025-03-29 03:47:02.055189	2025-03-29 03:47:02.055189	8196a156-67eb-4f2f-b387-c5444a6deb59
88	test_user_61@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_61@example.com	2025-03-29 03:47:02.116002	2025-03-29 03:47:02.116002	8196a156-67eb-4f2f-b387-c5444a6deb59
89	test_user_62@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_62@example.com	2025-03-29 03:47:02.171595	2025-03-29 03:47:02.171595	8196a156-67eb-4f2f-b387-c5444a6deb59
90	test_user_63@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_63@example.com	2025-03-29 03:47:02.228032	2025-03-29 03:47:02.228032	8196a156-67eb-4f2f-b387-c5444a6deb59
91	test_user_64@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_64@example.com	2025-03-29 03:47:02.282045	2025-03-29 03:47:02.282045	8196a156-67eb-4f2f-b387-c5444a6deb59
92	test_user_65@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_65@example.com	2025-03-29 03:47:02.370096	2025-03-29 03:47:02.370096	8196a156-67eb-4f2f-b387-c5444a6deb59
93	test_user_66@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_66@example.com	2025-03-29 03:47:02.413291	2025-03-29 03:47:02.413291	8196a156-67eb-4f2f-b387-c5444a6deb59
94	test_user_67@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_67@example.com	2025-03-29 03:47:02.484843	2025-03-29 03:47:02.484843	8196a156-67eb-4f2f-b387-c5444a6deb59
95	test_user_68@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:47:04.67776	2025-03-29 03:47:04.67776	8196a156-67eb-4f2f-b387-c5444a6deb59
96	test_user_69@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:47:06.858015	2025-03-29 03:47:06.858015	8196a156-67eb-4f2f-b387-c5444a6deb59
97	test_user_70@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:47:09.017813	2025-03-29 03:47:09.017813	8196a156-67eb-4f2f-b387-c5444a6deb59
98	test_user_71@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:47:11.194201	2025-03-29 03:47:11.194201	8196a156-67eb-4f2f-b387-c5444a6deb59
99	test_user_72@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_72@example.com	2025-03-29 03:47:13.396665	2025-03-29 03:47:13.396665	8196a156-67eb-4f2f-b387-c5444a6deb59
100	test_user_73@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_73@example.com	2025-03-29 03:47:13.450628	2025-03-29 03:47:13.450628	8196a156-67eb-4f2f-b387-c5444a6deb59
101	test_user_74@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_74@example.com	2025-03-29 03:47:13.505953	2025-03-29 03:47:13.505953	8196a156-67eb-4f2f-b387-c5444a6deb59
102	test_user_75@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_75@example.com	2025-03-29 03:47:13.878986	2025-03-29 03:47:13.878986	8196a156-67eb-4f2f-b387-c5444a6deb59
103	test_user_76@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_76@example.com	2025-03-29 03:47:14.264587	2025-03-29 03:47:14.264587	8196a156-67eb-4f2f-b387-c5444a6deb59
104	test_user_77@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_77@example.com	2025-03-29 03:47:14.632319	2025-03-29 03:47:14.632319	8196a156-67eb-4f2f-b387-c5444a6deb59
105	test_user_78@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:47:16.805219	2025-03-29 03:47:16.805219	8196a156-67eb-4f2f-b387-c5444a6deb59
106	test_user_79@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:47:18.972582	2025-03-29 03:47:18.972582	8196a156-67eb-4f2f-b387-c5444a6deb59
107	test_user_80@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_80@example.com	2025-03-29 03:47:19.018934	2025-03-29 03:47:19.018934	8196a156-67eb-4f2f-b387-c5444a6deb59
108	test_user_81@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_81@example.com	2025-03-29 03:47:19.084848	2025-03-29 03:47:19.084848	8196a156-67eb-4f2f-b387-c5444a6deb59
109	test1@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com	2025-03-29 03:56:03.583313	2025-03-29 03:56:03.583313	8196a156-67eb-4f2f-b387-c5444a6deb59
110	test2@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test2@example.com	2025-03-29 03:56:03.658304	2025-03-29 03:56:03.658304	8196a156-67eb-4f2f-b387-c5444a6deb59
111	test3@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test3@example.com	2025-03-29 03:56:03.718825	2025-03-29 03:56:03.718825	8196a156-67eb-4f2f-b387-c5444a6deb59
112	test4@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test4@example.com	2025-03-29 03:56:03.82972	2025-03-29 03:56:03.82972	8196a156-67eb-4f2f-b387-c5444a6deb59
113	test5@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test5@example.com	2025-03-29 03:56:03.926006	2025-03-29 03:56:03.926006	8196a156-67eb-4f2f-b387-c5444a6deb59
114	test6@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test6@example.com	2025-03-29 03:56:04.024692	2025-03-29 03:56:04.024692	8196a156-67eb-4f2f-b387-c5444a6deb59
115	test7@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test7@example.com	2025-03-29 03:56:04.113848	2025-03-29 03:56:04.113848	8196a156-67eb-4f2f-b387-c5444a6deb59
116	test8@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test8@example.com	2025-03-29 03:56:04.186921	2025-03-29 03:56:04.186921	8196a156-67eb-4f2f-b387-c5444a6deb59
117	test9@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test9@example.com	2025-03-29 03:56:04.296448	2025-03-29 03:56:04.296448	8196a156-67eb-4f2f-b387-c5444a6deb59
118	test_user_19@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_19@example.com	2025-03-29 03:56:04.380862	2025-03-29 03:56:04.380862	8196a156-67eb-4f2f-b387-c5444a6deb59
119	enoch@rice.test	7	Email address is not verified. The following identities failed the check in region US-EAST-1: enoch@rice.test	2025-03-29 03:56:04.44765	2025-03-29 03:56:04.44765	8196a156-67eb-4f2f-b387-c5444a6deb59
120	yang@beier.example	7	Email address is not verified. The following identities failed the check in region US-EAST-1: yang@beier.example	2025-03-29 03:56:04.529495	2025-03-29 03:56:04.529495	8196a156-67eb-4f2f-b387-c5444a6deb59
121	johana@green.test	7	Email address is not verified. The following identities failed the check in region US-EAST-1: johana@green.test	2025-03-29 03:56:04.595845	2025-03-29 03:56:04.595845	8196a156-67eb-4f2f-b387-c5444a6deb59
122	vanetta.bechtelar@dietrich.test	7	Email address is not verified. The following identities failed the check in region US-EAST-1: vanetta.bechtelar@dietrich.test	2025-03-29 03:56:04.669584	2025-03-29 03:56:04.669584	8196a156-67eb-4f2f-b387-c5444a6deb59
123	merissa_kohler@fahey-mueller.example	7	Email address is not verified. The following identities failed the check in region US-EAST-1: merissa_kohler@fahey-mueller.example	2025-03-29 03:56:04.738149	2025-03-29 03:56:04.738149	8196a156-67eb-4f2f-b387-c5444a6deb59
124	bounce@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: bounce@example.com	2025-03-29 03:56:04.802464	2025-03-29 03:56:04.802464	8196a156-67eb-4f2f-b387-c5444a6deb59
125	cliente1@ejemplo.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: cliente1@ejemplo.com	2025-03-29 03:56:04.864586	2025-03-29 03:56:04.864586	8196a156-67eb-4f2f-b387-c5444a6deb59
126	test_user_20@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_20@example.com	2025-03-29 03:56:04.943544	2025-03-29 03:56:04.943544	8196a156-67eb-4f2f-b387-c5444a6deb59
127	jenine_schuppe@ziemann-gleichner.example	7	Email address is not verified. The following identities failed the check in region US-EAST-1: jenine_schuppe@ziemann-gleichner.example	2025-03-29 03:56:05.131372	2025-03-29 03:56:05.131372	8196a156-67eb-4f2f-b387-c5444a6deb59
128	test_user_21@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_21@example.com	2025-03-29 03:56:05.211995	2025-03-29 03:56:05.211995	8196a156-67eb-4f2f-b387-c5444a6deb59
129	test_user_0@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_0@example.com	2025-03-29 03:56:05.277836	2025-03-29 03:56:05.277836	8196a156-67eb-4f2f-b387-c5444a6deb59
130	test_user_1@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_1@example.com	2025-03-29 03:56:05.341605	2025-03-29 03:56:05.341605	8196a156-67eb-4f2f-b387-c5444a6deb59
131	test_user_2@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_2@example.com	2025-03-29 03:56:05.435369	2025-03-29 03:56:05.435369	8196a156-67eb-4f2f-b387-c5444a6deb59
132	test_user_3@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_3@example.com	2025-03-29 03:56:05.527165	2025-03-29 03:56:05.527165	8196a156-67eb-4f2f-b387-c5444a6deb59
133	test_user_4@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_4@example.com	2025-03-29 03:56:05.582449	2025-03-29 03:56:05.582449	8196a156-67eb-4f2f-b387-c5444a6deb59
134	test_user_5@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_5@example.com	2025-03-29 03:56:05.647106	2025-03-29 03:56:05.647106	8196a156-67eb-4f2f-b387-c5444a6deb59
135	test_user_6@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_6@example.com	2025-03-29 03:56:05.70515	2025-03-29 03:56:05.70515	8196a156-67eb-4f2f-b387-c5444a6deb59
136	test_user_7@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_7@example.com	2025-03-29 03:56:05.76931	2025-03-29 03:56:05.76931	8196a156-67eb-4f2f-b387-c5444a6deb59
137	test_user_8@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_8@example.com	2025-03-29 03:56:05.847102	2025-03-29 03:56:05.847102	8196a156-67eb-4f2f-b387-c5444a6deb59
138	test_user_9@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_9@example.com	2025-03-29 03:56:05.938969	2025-03-29 03:56:05.938969	8196a156-67eb-4f2f-b387-c5444a6deb59
139	test_user_10@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_10@example.com	2025-03-29 03:56:05.99622	2025-03-29 03:56:05.99622	8196a156-67eb-4f2f-b387-c5444a6deb59
140	test_user_11@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_11@example.com	2025-03-29 03:56:06.05106	2025-03-29 03:56:06.05106	8196a156-67eb-4f2f-b387-c5444a6deb59
141	test_user_12@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_12@example.com	2025-03-29 03:56:06.131678	2025-03-29 03:56:06.131678	8196a156-67eb-4f2f-b387-c5444a6deb59
142	test_user_13@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_13@example.com	2025-03-29 03:56:06.191455	2025-03-29 03:56:06.191455	8196a156-67eb-4f2f-b387-c5444a6deb59
143	test_user_14@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_14@example.com	2025-03-29 03:56:06.266739	2025-03-29 03:56:06.266739	8196a156-67eb-4f2f-b387-c5444a6deb59
144	test_user_15@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_15@example.com	2025-03-29 03:56:06.321259	2025-03-29 03:56:06.321259	8196a156-67eb-4f2f-b387-c5444a6deb59
145	test_user_16@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_16@example.com	2025-03-29 03:56:06.396976	2025-03-29 03:56:06.396976	8196a156-67eb-4f2f-b387-c5444a6deb59
146	test_user_17@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_17@example.com	2025-03-29 03:56:06.429712	2025-03-29 03:56:06.429712	8196a156-67eb-4f2f-b387-c5444a6deb59
147	test_user_18@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_18@example.com	2025-03-29 03:56:06.488206	2025-03-29 03:56:06.488206	8196a156-67eb-4f2f-b387-c5444a6deb59
148	test_user_22@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_22@example.com	2025-03-29 03:56:06.556008	2025-03-29 03:56:06.556008	8196a156-67eb-4f2f-b387-c5444a6deb59
149	test_user_23@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_23@example.com	2025-03-29 03:56:06.627845	2025-03-29 03:56:06.627845	8196a156-67eb-4f2f-b387-c5444a6deb59
150	test_user_24@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_24@example.com	2025-03-29 03:56:06.673926	2025-03-29 03:56:06.673926	8196a156-67eb-4f2f-b387-c5444a6deb59
151	test_user_26@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_26@example.com	2025-03-29 03:56:06.758979	2025-03-29 03:56:06.758979	8196a156-67eb-4f2f-b387-c5444a6deb59
152	test_user_27@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_27@example.com	2025-03-29 03:56:06.794337	2025-03-29 03:56:06.794337	8196a156-67eb-4f2f-b387-c5444a6deb59
153	test_user_28@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_28@example.com	2025-03-29 03:56:06.850669	2025-03-29 03:56:06.850669	8196a156-67eb-4f2f-b387-c5444a6deb59
154	test_user_29@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_29@example.com	2025-03-29 03:56:06.939426	2025-03-29 03:56:06.939426	8196a156-67eb-4f2f-b387-c5444a6deb59
155	test_user_30@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_30@example.com	2025-03-29 03:56:07.022795	2025-03-29 03:56:07.022795	8196a156-67eb-4f2f-b387-c5444a6deb59
156	test_user_31@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_31@example.com	2025-03-29 03:56:07.076859	2025-03-29 03:56:07.076859	8196a156-67eb-4f2f-b387-c5444a6deb59
157	test_user_32@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_32@example.com	2025-03-29 03:56:07.133634	2025-03-29 03:56:07.133634	8196a156-67eb-4f2f-b387-c5444a6deb59
158	test_user_33@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_33@example.com	2025-03-29 03:56:07.201839	2025-03-29 03:56:07.201839	8196a156-67eb-4f2f-b387-c5444a6deb59
159	test_user_34@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_34@example.com	2025-03-29 03:56:07.294477	2025-03-29 03:56:07.294477	8196a156-67eb-4f2f-b387-c5444a6deb59
160	test_user_35@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_35@example.com	2025-03-29 03:56:07.347473	2025-03-29 03:56:07.347473	8196a156-67eb-4f2f-b387-c5444a6deb59
161	test_user_36@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_36@example.com	2025-03-29 03:56:07.418476	2025-03-29 03:56:07.418476	8196a156-67eb-4f2f-b387-c5444a6deb59
162	test_user_37@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_37@example.com	2025-03-29 03:56:07.47825	2025-03-29 03:56:07.47825	8196a156-67eb-4f2f-b387-c5444a6deb59
163	test_user_38@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_38@example.com	2025-03-29 03:56:07.534345	2025-03-29 03:56:07.534345	8196a156-67eb-4f2f-b387-c5444a6deb59
164	test_user_39@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_39@example.com	2025-03-29 03:56:07.566613	2025-03-29 03:56:07.566613	8196a156-67eb-4f2f-b387-c5444a6deb59
165	test_user_40@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_40@example.com	2025-03-29 03:56:07.622766	2025-03-29 03:56:07.622766	8196a156-67eb-4f2f-b387-c5444a6deb59
166	test_user_41@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_41@example.com	2025-03-29 03:56:07.692082	2025-03-29 03:56:07.692082	8196a156-67eb-4f2f-b387-c5444a6deb59
167	test_user_42@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_42@example.com	2025-03-29 03:56:07.772716	2025-03-29 03:56:07.772716	8196a156-67eb-4f2f-b387-c5444a6deb59
168	test_user_43@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_43@example.com	2025-03-29 03:56:07.856576	2025-03-29 03:56:07.856576	8196a156-67eb-4f2f-b387-c5444a6deb59
169	test_user_44@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_44@example.com	2025-03-29 03:56:07.889083	2025-03-29 03:56:07.889083	8196a156-67eb-4f2f-b387-c5444a6deb59
170	test_user_45@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_45@example.com	2025-03-29 03:56:07.923093	2025-03-29 03:56:07.923093	8196a156-67eb-4f2f-b387-c5444a6deb59
171	test_user_46@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_46@example.com	2025-03-29 03:56:07.958696	2025-03-29 03:56:07.958696	8196a156-67eb-4f2f-b387-c5444a6deb59
172	test_user_47@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_47@example.com	2025-03-29 03:56:07.993197	2025-03-29 03:56:07.993197	8196a156-67eb-4f2f-b387-c5444a6deb59
173	test_user_48@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_48@example.com	2025-03-29 03:56:08.050285	2025-03-29 03:56:08.050285	8196a156-67eb-4f2f-b387-c5444a6deb59
174	test_user_49@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_49@example.com	2025-03-29 03:56:08.115458	2025-03-29 03:56:08.115458	8196a156-67eb-4f2f-b387-c5444a6deb59
175	test_user_82@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_82@example.com	2025-03-29 03:56:08.166175	2025-03-29 03:56:08.166175	8196a156-67eb-4f2f-b387-c5444a6deb59
176	test_user_83@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_83@example.com	2025-03-29 03:56:08.225265	2025-03-29 03:56:08.225265	8196a156-67eb-4f2f-b387-c5444a6deb59
177	test_user_84@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_84@example.com	2025-03-29 03:56:08.323537	2025-03-29 03:56:08.323537	8196a156-67eb-4f2f-b387-c5444a6deb59
178	test_user_85@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_85@example.com	2025-03-29 03:56:08.365862	2025-03-29 03:56:08.365862	8196a156-67eb-4f2f-b387-c5444a6deb59
179	test_user_86@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_86@example.com	2025-03-29 03:56:08.447496	2025-03-29 03:56:08.447496	8196a156-67eb-4f2f-b387-c5444a6deb59
180	test_user_87@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_87@example.com	2025-03-29 03:56:08.50043	2025-03-29 03:56:08.50043	8196a156-67eb-4f2f-b387-c5444a6deb59
181	test_user_88@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_88@example.com	2025-03-29 03:56:08.587582	2025-03-29 03:56:08.587582	8196a156-67eb-4f2f-b387-c5444a6deb59
182	test_user_89@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_89@example.com	2025-03-29 03:56:08.647583	2025-03-29 03:56:08.647583	8196a156-67eb-4f2f-b387-c5444a6deb59
183	test_user_90@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_90@example.com	2025-03-29 03:56:08.702075	2025-03-29 03:56:08.702075	8196a156-67eb-4f2f-b387-c5444a6deb59
184	test_user_91@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_91@example.com	2025-03-29 03:56:09.106204	2025-03-29 03:56:09.106204	8196a156-67eb-4f2f-b387-c5444a6deb59
185	test_user_92@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_92@example.com	2025-03-29 03:56:09.16747	2025-03-29 03:56:09.16747	8196a156-67eb-4f2f-b387-c5444a6deb59
186	test_user_93@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_93@example.com	2025-03-29 03:56:09.237716	2025-03-29 03:56:09.237716	8196a156-67eb-4f2f-b387-c5444a6deb59
187	test_user_94@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_94@example.com	2025-03-29 03:56:09.296289	2025-03-29 03:56:09.296289	8196a156-67eb-4f2f-b387-c5444a6deb59
188	test_user_95@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_95@example.com	2025-03-29 03:56:09.350241	2025-03-29 03:56:09.350241	8196a156-67eb-4f2f-b387-c5444a6deb59
189	test_user_96@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_96@example.com	2025-03-29 03:56:09.716554	2025-03-29 03:56:09.716554	8196a156-67eb-4f2f-b387-c5444a6deb59
190	test_user_97@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_97@example.com	2025-03-29 03:56:09.821038	2025-03-29 03:56:09.821038	8196a156-67eb-4f2f-b387-c5444a6deb59
191	test_user_98@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_98@example.com	2025-03-29 03:56:10.767436	2025-03-29 03:56:10.767436	8196a156-67eb-4f2f-b387-c5444a6deb59
192	test_user_99@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_99@example.com	2025-03-29 03:56:10.803766	2025-03-29 03:56:10.803766	8196a156-67eb-4f2f-b387-c5444a6deb59
193	test_user_100@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_100@example.com	2025-03-29 03:56:11.174388	2025-03-29 03:56:11.174388	8196a156-67eb-4f2f-b387-c5444a6deb59
194	test_user_101@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_101@example.com	2025-03-29 03:56:11.254464	2025-03-29 03:56:11.254464	8196a156-67eb-4f2f-b387-c5444a6deb59
195	test_user_102@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_102@example.com	2025-03-29 03:56:11.659152	2025-03-29 03:56:11.659152	8196a156-67eb-4f2f-b387-c5444a6deb59
196	test_user_103@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_103@example.com	2025-03-29 03:56:12.012269	2025-03-29 03:56:12.012269	8196a156-67eb-4f2f-b387-c5444a6deb59
197	test_user_104@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_104@example.com	2025-03-29 03:56:12.092731	2025-03-29 03:56:12.092731	8196a156-67eb-4f2f-b387-c5444a6deb59
198	test_user_105@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_105@example.com	2025-03-29 03:56:12.154136	2025-03-29 03:56:12.154136	8196a156-67eb-4f2f-b387-c5444a6deb59
199	test_user_106@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_106@example.com	2025-03-29 03:56:12.240675	2025-03-29 03:56:12.240675	8196a156-67eb-4f2f-b387-c5444a6deb59
200	test_user_107@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_107@example.com	2025-03-29 03:56:13.190938	2025-03-29 03:56:13.190938	8196a156-67eb-4f2f-b387-c5444a6deb59
201	test_user_108@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_108@example.com	2025-03-29 03:56:13.247068	2025-03-29 03:56:13.247068	8196a156-67eb-4f2f-b387-c5444a6deb59
202	test_user_109@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_109@example.com	2025-03-29 03:56:13.302627	2025-03-29 03:56:13.302627	8196a156-67eb-4f2f-b387-c5444a6deb59
203	test_user_110@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_110@example.com	2025-03-29 03:56:13.358577	2025-03-29 03:56:13.358577	8196a156-67eb-4f2f-b387-c5444a6deb59
204	test_user_111@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_111@example.com	2025-03-29 03:56:13.75758	2025-03-29 03:56:13.75758	8196a156-67eb-4f2f-b387-c5444a6deb59
205	test_user_112@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_112@example.com	2025-03-29 03:56:13.790399	2025-03-29 03:56:13.790399	8196a156-67eb-4f2f-b387-c5444a6deb59
206	test_user_113@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_113@example.com	2025-03-29 03:56:13.888098	2025-03-29 03:56:13.888098	8196a156-67eb-4f2f-b387-c5444a6deb59
207	test_user_114@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_114@example.com	2025-03-29 03:56:13.970144	2025-03-29 03:56:13.970144	8196a156-67eb-4f2f-b387-c5444a6deb59
208	test_user_76@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_76@example.com	2025-03-29 03:56:44.087251	2025-03-29 03:56:44.087251	8196a156-67eb-4f2f-b387-c5444a6deb59
209	test_user_77@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_77@example.com	2025-03-29 03:56:44.177756	2025-03-29 03:56:44.177756	8196a156-67eb-4f2f-b387-c5444a6deb59
210	test_user_78@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_78@example.com	2025-03-29 03:56:44.241798	2025-03-29 03:56:44.241798	8196a156-67eb-4f2f-b387-c5444a6deb59
211	test_user_79@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_79@example.com	2025-03-29 03:56:44.303103	2025-03-29 03:56:44.303103	8196a156-67eb-4f2f-b387-c5444a6deb59
212	test_user_80@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_80@example.com	2025-03-29 03:56:44.363976	2025-03-29 03:56:44.363976	8196a156-67eb-4f2f-b387-c5444a6deb59
213	test_user_81@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_81@example.com	2025-03-29 03:56:44.435507	2025-03-29 03:56:44.435507	8196a156-67eb-4f2f-b387-c5444a6deb59
214	test_user_82@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_82@example.com	2025-03-29 03:56:44.476439	2025-03-29 03:56:44.476439	8196a156-67eb-4f2f-b387-c5444a6deb59
215	test_user_83@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_83@example.com	2025-03-29 03:56:44.547372	2025-03-29 03:56:44.547372	8196a156-67eb-4f2f-b387-c5444a6deb59
216	test_user_84@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_84@example.com	2025-03-29 03:56:44.61637	2025-03-29 03:56:44.61637	8196a156-67eb-4f2f-b387-c5444a6deb59
217	test_user_85@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_85@example.com	2025-03-29 03:56:44.647471	2025-03-29 03:56:44.647471	8196a156-67eb-4f2f-b387-c5444a6deb59
218	test_user_86@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_86@example.com	2025-03-29 03:56:44.703327	2025-03-29 03:56:44.703327	8196a156-67eb-4f2f-b387-c5444a6deb59
219	test_user_87@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_87@example.com	2025-03-29 03:56:45.050362	2025-03-29 03:56:45.050362	8196a156-67eb-4f2f-b387-c5444a6deb59
220	test_user_88@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_88@example.com	2025-03-29 03:56:45.087357	2025-03-29 03:56:45.087357	8196a156-67eb-4f2f-b387-c5444a6deb59
221	test_user_89@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_89@example.com	2025-03-29 03:56:45.166356	2025-03-29 03:56:45.166356	8196a156-67eb-4f2f-b387-c5444a6deb59
222	test_user_90@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_90@example.com	2025-03-29 03:56:45.255498	2025-03-29 03:56:45.255498	8196a156-67eb-4f2f-b387-c5444a6deb59
223	test_user_91@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_91@example.com	2025-03-29 03:56:45.320099	2025-03-29 03:56:45.320099	8196a156-67eb-4f2f-b387-c5444a6deb59
224	test_user_92@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_92@example.com	2025-03-29 03:56:45.379493	2025-03-29 03:56:45.379493	8196a156-67eb-4f2f-b387-c5444a6deb59
225	test_user_93@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_93@example.com	2025-03-29 03:56:45.760581	2025-03-29 03:56:45.760581	8196a156-67eb-4f2f-b387-c5444a6deb59
226	test_user_94@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_94@example.com	2025-03-29 03:56:45.847346	2025-03-29 03:56:45.847346	8196a156-67eb-4f2f-b387-c5444a6deb59
227	test_user_96@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_96@example.com	2025-03-29 03:56:46.803773	2025-03-29 03:56:46.803773	8196a156-67eb-4f2f-b387-c5444a6deb59
228	test_user_97@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_97@example.com	2025-03-29 03:56:46.868869	2025-03-29 03:56:46.868869	8196a156-67eb-4f2f-b387-c5444a6deb59
229	test_user_98@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_98@example.com	2025-03-29 03:56:46.926527	2025-03-29 03:56:46.926527	8196a156-67eb-4f2f-b387-c5444a6deb59
230	test_user_99@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_99@example.com	2025-03-29 03:56:47.015507	2025-03-29 03:56:47.015507	8196a156-67eb-4f2f-b387-c5444a6deb59
231	test_user_100@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_100@example.com	2025-03-29 03:56:47.069843	2025-03-29 03:56:47.069843	8196a156-67eb-4f2f-b387-c5444a6deb59
232	test_user_101@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_101@example.com	2025-03-29 03:56:47.126826	2025-03-29 03:56:47.126826	8196a156-67eb-4f2f-b387-c5444a6deb59
233	test_user_102@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_102@example.com	2025-03-29 03:56:47.182163	2025-03-29 03:56:47.182163	8196a156-67eb-4f2f-b387-c5444a6deb59
234	test_user_103@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_103@example.com	2025-03-29 03:56:47.258182	2025-03-29 03:56:47.258182	8196a156-67eb-4f2f-b387-c5444a6deb59
235	test_user_104@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_104@example.com	2025-03-29 03:56:47.320213	2025-03-29 03:56:47.320213	8196a156-67eb-4f2f-b387-c5444a6deb59
236	test_user_105@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_105@example.com	2025-03-29 03:56:47.355796	2025-03-29 03:56:47.355796	8196a156-67eb-4f2f-b387-c5444a6deb59
237	test_user_106@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_106@example.com	2025-03-29 03:56:47.420229	2025-03-29 03:56:47.420229	8196a156-67eb-4f2f-b387-c5444a6deb59
238	test_user_107@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_107@example.com	2025-03-29 03:56:48.383403	2025-03-29 03:56:48.383403	8196a156-67eb-4f2f-b387-c5444a6deb59
239	test_user_108@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_108@example.com	2025-03-29 03:56:48.435061	2025-03-29 03:56:48.435061	8196a156-67eb-4f2f-b387-c5444a6deb59
240	test_user_109@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_109@example.com	2025-03-29 03:56:48.465937	2025-03-29 03:56:48.465937	8196a156-67eb-4f2f-b387-c5444a6deb59
241	test_user_110@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_110@example.com	2025-03-29 03:56:48.523191	2025-03-29 03:56:48.523191	8196a156-67eb-4f2f-b387-c5444a6deb59
242	test_user_111@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_111@example.com	2025-03-29 03:56:48.555423	2025-03-29 03:56:48.555423	8196a156-67eb-4f2f-b387-c5444a6deb59
243	test_user_112@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_112@example.com	2025-03-29 03:56:48.917111	2025-03-29 03:56:48.917111	8196a156-67eb-4f2f-b387-c5444a6deb59
244	test_user_113@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_113@example.com	2025-03-29 03:56:48.950737	2025-03-29 03:56:48.950737	8196a156-67eb-4f2f-b387-c5444a6deb59
245	test_user_114@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_114@example.com	2025-03-29 03:56:48.976252	2025-03-29 03:56:48.976252	8196a156-67eb-4f2f-b387-c5444a6deb59
246	test_user_125@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_125@example.com	2025-03-29 03:56:49.344056	2025-03-29 03:56:49.344056	8196a156-67eb-4f2f-b387-c5444a6deb59
247	test_user_126@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_126@example.com	2025-03-29 03:56:49.436105	2025-03-29 03:56:49.436105	8196a156-67eb-4f2f-b387-c5444a6deb59
248	test_user_127@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_127@example.com	2025-03-29 03:56:49.468556	2025-03-29 03:56:49.468556	8196a156-67eb-4f2f-b387-c5444a6deb59
249	test_user_128@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_128@example.com	2025-03-29 03:56:49.498883	2025-03-29 03:56:49.498883	8196a156-67eb-4f2f-b387-c5444a6deb59
250	test_user_129@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_129@example.com	2025-03-29 03:56:49.837569	2025-03-29 03:56:49.837569	8196a156-67eb-4f2f-b387-c5444a6deb59
251	test_user_130@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_130@example.com	2025-03-29 03:56:49.866751	2025-03-29 03:56:49.866751	8196a156-67eb-4f2f-b387-c5444a6deb59
252	test_user_131@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_131@example.com	2025-03-29 03:56:50.258392	2025-03-29 03:56:50.258392	8196a156-67eb-4f2f-b387-c5444a6deb59
253	test_user_132@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_132@example.com	2025-03-29 03:56:50.288845	2025-03-29 03:56:50.288845	8196a156-67eb-4f2f-b387-c5444a6deb59
254	test_user_133@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_133@example.com	2025-03-29 03:56:50.320477	2025-03-29 03:56:50.320477	8196a156-67eb-4f2f-b387-c5444a6deb59
255	test_user_134@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_134@example.com	2025-03-29 03:56:50.37703	2025-03-29 03:56:50.37703	8196a156-67eb-4f2f-b387-c5444a6deb59
256	test_user_135@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:56:52.514766	2025-03-29 03:56:52.514766	8196a156-67eb-4f2f-b387-c5444a6deb59
257	test_user_136@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_136@example.com	2025-03-29 03:56:52.580038	2025-03-29 03:56:52.580038	8196a156-67eb-4f2f-b387-c5444a6deb59
258	test_user_137@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_137@example.com	2025-03-29 03:56:52.613634	2025-03-29 03:56:52.613634	8196a156-67eb-4f2f-b387-c5444a6deb59
259	test_user_138@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_138@example.com	2025-03-29 03:56:52.670593	2025-03-29 03:56:52.670593	8196a156-67eb-4f2f-b387-c5444a6deb59
260	test_user_139@example.com	7	Maximum sending rate exceeded.	2025-03-29 03:56:54.812207	2025-03-29 03:56:54.812207	8196a156-67eb-4f2f-b387-c5444a6deb59
261	test_user_140@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_140@example.com	2025-03-29 03:56:54.874292	2025-03-29 03:56:54.874292	8196a156-67eb-4f2f-b387-c5444a6deb59
262	test_user_141@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_141@example.com	2025-03-29 03:56:55.257785	2025-03-29 03:56:55.257785	8196a156-67eb-4f2f-b387-c5444a6deb59
263	test_user_142@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_142@example.com	2025-03-29 03:56:55.320225	2025-03-29 03:56:55.320225	8196a156-67eb-4f2f-b387-c5444a6deb59
264	test_user_143@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_143@example.com	2025-03-29 03:56:55.391378	2025-03-29 03:56:55.391378	8196a156-67eb-4f2f-b387-c5444a6deb59
265	test_user_144@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_144@example.com	2025-03-29 03:56:55.450975	2025-03-29 03:56:55.450975	8196a156-67eb-4f2f-b387-c5444a6deb59
266	test_user_145@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_145@example.com	2025-03-29 03:56:55.813431	2025-03-29 03:56:55.813431	8196a156-67eb-4f2f-b387-c5444a6deb59
267	test_user_146@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_146@example.com	2025-03-29 03:56:56.154512	2025-03-29 03:56:56.154512	8196a156-67eb-4f2f-b387-c5444a6deb59
268	test_user_147@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_147@example.com	2025-03-29 03:56:56.184534	2025-03-29 03:56:56.184534	8196a156-67eb-4f2f-b387-c5444a6deb59
269	test_user_148@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_148@example.com	2025-03-29 03:56:56.240874	2025-03-29 03:56:56.240874	8196a156-67eb-4f2f-b387-c5444a6deb59
270	test_user_149@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_149@example.com	2025-03-29 03:56:56.300671	2025-03-29 03:56:56.300671	8196a156-67eb-4f2f-b387-c5444a6deb59
271	test0@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com	2025-03-29 03:56:56.355818	2025-03-29 03:56:56.355818	8196a156-67eb-4f2f-b387-c5444a6deb59
272	test_user_25@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_25@example.com	2025-03-29 03:56:56.440569	2025-03-29 03:56:56.440569	8196a156-67eb-4f2f-b387-c5444a6deb59
273	test_user_50@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_50@example.com	2025-03-29 03:56:56.473467	2025-03-29 03:56:56.473467	8196a156-67eb-4f2f-b387-c5444a6deb59
274	test_user_68@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_68@example.com	2025-03-29 03:56:56.52768	2025-03-29 03:56:56.52768	8196a156-67eb-4f2f-b387-c5444a6deb59
275	test1@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com	2025-03-29 03:56:56.887226	2025-03-29 03:56:56.887226	8196a156-67eb-4f2f-b387-c5444a6deb59
276	test_user_95@example.com	7	Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_95@example.com	2025-03-29 03:56:56.948694	2025-03-29 03:56:56.948694	8196a156-67eb-4f2f-b387-c5444a6deb59
\.


--
-- Data for Name: email_event_logs; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.email_event_logs (id, email, event_type, metadata, campaign_id, created_at, updated_at, campaign_uuid) FROM stdin;
1	info@maileraction.com	open	{}	1	2025-03-27 20:03:35.210394	2025-03-27 20:03:35.210394	024eba05-3608-4a52-ac71-5a569d4daebf
2	info@maileraction.com	click	{}	1	2025-03-27 20:08:53.290248	2025-03-27 20:08:53.290248	024eba05-3608-4a52-ac71-5a569d4daebf
3	info@maileraction.com	click	{}	1	2025-03-28 15:26:36.008235	2025-03-28 15:26:36.008235	024eba05-3608-4a52-ac71-5a569d4daebf
4	test0@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com"}	2	2025-03-28 17:17:33.85691	2025-03-28 17:17:33.85691	b4570b6b-9283-4956-8371-2c88ba49d56b
5	test0@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com"}	5	2025-03-28 17:32:02.109202	2025-03-28 17:32:02.109202	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
6	test1@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com"}	5	2025-03-28 17:32:02.225395	2025-03-28 17:32:02.225395	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
7	test2@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test2@example.com"}	5	2025-03-28 17:32:02.301409	2025-03-28 17:32:02.301409	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
8	test0@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com"}	7	2025-03-29 02:02:56.892134	2025-03-29 02:02:56.892134	8196a156-67eb-4f2f-b387-c5444a6deb59
9	test0@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com"}	7	2025-03-29 03:46:41.121457	2025-03-29 03:46:41.121457	8196a156-67eb-4f2f-b387-c5444a6deb59
10	test1@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com"}	7	2025-03-29 03:46:41.197654	2025-03-29 03:46:41.197654	8196a156-67eb-4f2f-b387-c5444a6deb59
11	test2@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test2@example.com"}	7	2025-03-29 03:46:41.276212	2025-03-29 03:46:41.276212	8196a156-67eb-4f2f-b387-c5444a6deb59
12	test3@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test3@example.com"}	7	2025-03-29 03:46:41.347916	2025-03-29 03:46:41.347916	8196a156-67eb-4f2f-b387-c5444a6deb59
13	test4@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test4@example.com"}	7	2025-03-29 03:46:41.431722	2025-03-29 03:46:41.431722	8196a156-67eb-4f2f-b387-c5444a6deb59
14	test5@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test5@example.com"}	7	2025-03-29 03:46:41.494718	2025-03-29 03:46:41.494718	8196a156-67eb-4f2f-b387-c5444a6deb59
15	test6@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test6@example.com"}	7	2025-03-29 03:46:41.568465	2025-03-29 03:46:41.568465	8196a156-67eb-4f2f-b387-c5444a6deb59
16	test7@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test7@example.com"}	7	2025-03-29 03:46:41.643639	2025-03-29 03:46:41.643639	8196a156-67eb-4f2f-b387-c5444a6deb59
17	test8@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test8@example.com"}	7	2025-03-29 03:46:41.699308	2025-03-29 03:46:41.699308	8196a156-67eb-4f2f-b387-c5444a6deb59
18	test9@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test9@example.com"}	7	2025-03-29 03:46:41.763657	2025-03-29 03:46:41.763657	8196a156-67eb-4f2f-b387-c5444a6deb59
19	test_user_19@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_19@example.com"}	7	2025-03-29 03:46:41.830451	2025-03-29 03:46:41.830451	8196a156-67eb-4f2f-b387-c5444a6deb59
20	jenine_schuppe@ziemann-gleichner.example	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: jenine_schuppe@ziemann-gleichner.example"}	7	2025-03-29 03:46:41.891579	2025-03-29 03:46:41.891579	8196a156-67eb-4f2f-b387-c5444a6deb59
21	enoch@rice.test	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: enoch@rice.test"}	7	2025-03-29 03:46:41.949535	2025-03-29 03:46:41.949535	8196a156-67eb-4f2f-b387-c5444a6deb59
22	yang@beier.example	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: yang@beier.example"}	7	2025-03-29 03:46:42.016386	2025-03-29 03:46:42.016386	8196a156-67eb-4f2f-b387-c5444a6deb59
23	johana@green.test	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: johana@green.test"}	7	2025-03-29 03:46:42.07663	2025-03-29 03:46:42.07663	8196a156-67eb-4f2f-b387-c5444a6deb59
24	vanetta.bechtelar@dietrich.test	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: vanetta.bechtelar@dietrich.test"}	7	2025-03-29 03:46:42.150822	2025-03-29 03:46:42.150822	8196a156-67eb-4f2f-b387-c5444a6deb59
25	merissa_kohler@fahey-mueller.example	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: merissa_kohler@fahey-mueller.example"}	7	2025-03-29 03:46:42.219042	2025-03-29 03:46:42.219042	8196a156-67eb-4f2f-b387-c5444a6deb59
26	bounce@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: bounce@example.com"}	7	2025-03-29 03:46:42.285743	2025-03-29 03:46:42.285743	8196a156-67eb-4f2f-b387-c5444a6deb59
27	cliente1@ejemplo.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: cliente1@ejemplo.com"}	7	2025-03-29 03:46:42.347715	2025-03-29 03:46:42.347715	8196a156-67eb-4f2f-b387-c5444a6deb59
28	test_user_20@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_20@example.com"}	7	2025-03-29 03:46:42.40868	2025-03-29 03:46:42.40868	8196a156-67eb-4f2f-b387-c5444a6deb59
29	test_user_21@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_21@example.com"}	7	2025-03-29 03:46:42.473568	2025-03-29 03:46:42.473568	8196a156-67eb-4f2f-b387-c5444a6deb59
30	test_user_0@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_0@example.com"}	7	2025-03-29 03:46:42.530658	2025-03-29 03:46:42.530658	8196a156-67eb-4f2f-b387-c5444a6deb59
31	test_user_1@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_1@example.com"}	7	2025-03-29 03:46:42.596779	2025-03-29 03:46:42.596779	8196a156-67eb-4f2f-b387-c5444a6deb59
32	test_user_2@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_2@example.com"}	7	2025-03-29 03:46:42.658691	2025-03-29 03:46:42.658691	8196a156-67eb-4f2f-b387-c5444a6deb59
33	test_user_3@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_3@example.com"}	7	2025-03-29 03:46:42.722412	2025-03-29 03:46:42.722412	8196a156-67eb-4f2f-b387-c5444a6deb59
34	test_user_4@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_4@example.com"}	7	2025-03-29 03:46:42.788941	2025-03-29 03:46:42.788941	8196a156-67eb-4f2f-b387-c5444a6deb59
35	test_user_5@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_5@example.com"}	7	2025-03-29 03:46:42.861279	2025-03-29 03:46:42.861279	8196a156-67eb-4f2f-b387-c5444a6deb59
36	test_user_6@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_6@example.com"}	7	2025-03-29 03:46:42.923986	2025-03-29 03:46:42.923986	8196a156-67eb-4f2f-b387-c5444a6deb59
37	test_user_7@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_7@example.com"}	7	2025-03-29 03:46:42.9921	2025-03-29 03:46:42.9921	8196a156-67eb-4f2f-b387-c5444a6deb59
38	test_user_8@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_8@example.com"}	7	2025-03-29 03:46:43.068461	2025-03-29 03:46:43.068461	8196a156-67eb-4f2f-b387-c5444a6deb59
39	test_user_9@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_9@example.com"}	7	2025-03-29 03:46:43.137606	2025-03-29 03:46:43.137606	8196a156-67eb-4f2f-b387-c5444a6deb59
40	test_user_10@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_10@example.com"}	7	2025-03-29 03:46:43.201992	2025-03-29 03:46:43.201992	8196a156-67eb-4f2f-b387-c5444a6deb59
41	test_user_11@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_11@example.com"}	7	2025-03-29 03:46:43.265657	2025-03-29 03:46:43.265657	8196a156-67eb-4f2f-b387-c5444a6deb59
42	test_user_12@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_12@example.com"}	7	2025-03-29 03:46:43.329086	2025-03-29 03:46:43.329086	8196a156-67eb-4f2f-b387-c5444a6deb59
43	test_user_13@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_13@example.com"}	7	2025-03-29 03:46:43.39898	2025-03-29 03:46:43.39898	8196a156-67eb-4f2f-b387-c5444a6deb59
44	test_user_14@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_14@example.com"}	7	2025-03-29 03:46:43.466204	2025-03-29 03:46:43.466204	8196a156-67eb-4f2f-b387-c5444a6deb59
45	test_user_15@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_15@example.com"}	7	2025-03-29 03:46:43.579502	2025-03-29 03:46:43.579502	8196a156-67eb-4f2f-b387-c5444a6deb59
46	test_user_16@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_16@example.com"}	7	2025-03-29 03:46:43.639703	2025-03-29 03:46:43.639703	8196a156-67eb-4f2f-b387-c5444a6deb59
47	test_user_17@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_17@example.com"}	7	2025-03-29 03:46:43.698444	2025-03-29 03:46:43.698444	8196a156-67eb-4f2f-b387-c5444a6deb59
48	test_user_18@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_18@example.com"}	7	2025-03-29 03:46:43.768771	2025-03-29 03:46:43.768771	8196a156-67eb-4f2f-b387-c5444a6deb59
49	test_user_22@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_22@example.com"}	7	2025-03-29 03:46:43.84462	2025-03-29 03:46:43.84462	8196a156-67eb-4f2f-b387-c5444a6deb59
50	test_user_23@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_23@example.com"}	7	2025-03-29 03:46:43.920372	2025-03-29 03:46:43.920372	8196a156-67eb-4f2f-b387-c5444a6deb59
51	test_user_24@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_24@example.com"}	7	2025-03-29 03:46:44.014398	2025-03-29 03:46:44.014398	8196a156-67eb-4f2f-b387-c5444a6deb59
52	test_user_25@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_25@example.com"}	7	2025-03-29 03:46:44.076442	2025-03-29 03:46:44.076442	8196a156-67eb-4f2f-b387-c5444a6deb59
53	test_user_26@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_26@example.com"}	7	2025-03-29 03:46:44.142778	2025-03-29 03:46:44.142778	8196a156-67eb-4f2f-b387-c5444a6deb59
54	test_user_27@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_27@example.com"}	7	2025-03-29 03:46:44.198541	2025-03-29 03:46:44.198541	8196a156-67eb-4f2f-b387-c5444a6deb59
55	test_user_28@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_28@example.com"}	7	2025-03-29 03:46:44.257237	2025-03-29 03:46:44.257237	8196a156-67eb-4f2f-b387-c5444a6deb59
56	test_user_29@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_29@example.com"}	7	2025-03-29 03:46:44.322035	2025-03-29 03:46:44.322035	8196a156-67eb-4f2f-b387-c5444a6deb59
57	test_user_30@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_30@example.com"}	7	2025-03-29 03:46:44.385833	2025-03-29 03:46:44.385833	8196a156-67eb-4f2f-b387-c5444a6deb59
58	test_user_31@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_31@example.com"}	7	2025-03-29 03:46:44.447678	2025-03-29 03:46:44.447678	8196a156-67eb-4f2f-b387-c5444a6deb59
59	test_user_32@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_32@example.com"}	7	2025-03-29 03:46:44.51033	2025-03-29 03:46:44.51033	8196a156-67eb-4f2f-b387-c5444a6deb59
60	test_user_33@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_33@example.com"}	7	2025-03-29 03:46:44.571458	2025-03-29 03:46:44.571458	8196a156-67eb-4f2f-b387-c5444a6deb59
61	test_user_34@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_34@example.com"}	7	2025-03-29 03:46:44.626453	2025-03-29 03:46:44.626453	8196a156-67eb-4f2f-b387-c5444a6deb59
62	test_user_35@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_35@example.com"}	7	2025-03-29 03:46:44.68604	2025-03-29 03:46:44.68604	8196a156-67eb-4f2f-b387-c5444a6deb59
63	test_user_36@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_36@example.com"}	7	2025-03-29 03:46:44.75031	2025-03-29 03:46:44.75031	8196a156-67eb-4f2f-b387-c5444a6deb59
64	test_user_37@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_37@example.com"}	7	2025-03-29 03:46:44.810325	2025-03-29 03:46:44.810325	8196a156-67eb-4f2f-b387-c5444a6deb59
65	test_user_38@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_38@example.com"}	7	2025-03-29 03:46:44.874326	2025-03-29 03:46:44.874326	8196a156-67eb-4f2f-b387-c5444a6deb59
66	test_user_39@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_39@example.com"}	7	2025-03-29 03:46:44.913791	2025-03-29 03:46:44.913791	8196a156-67eb-4f2f-b387-c5444a6deb59
67	test_user_40@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_40@example.com"}	7	2025-03-29 03:46:44.980065	2025-03-29 03:46:44.980065	8196a156-67eb-4f2f-b387-c5444a6deb59
68	test_user_41@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_41@example.com"}	7	2025-03-29 03:46:45.049667	2025-03-29 03:46:45.049667	8196a156-67eb-4f2f-b387-c5444a6deb59
69	test_user_42@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_42@example.com"}	7	2025-03-29 03:46:45.113647	2025-03-29 03:46:45.113647	8196a156-67eb-4f2f-b387-c5444a6deb59
70	test_user_43@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_43@example.com"}	7	2025-03-29 03:46:45.182192	2025-03-29 03:46:45.182192	8196a156-67eb-4f2f-b387-c5444a6deb59
71	test_user_44@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_44@example.com"}	7	2025-03-29 03:46:45.244463	2025-03-29 03:46:45.244463	8196a156-67eb-4f2f-b387-c5444a6deb59
72	test_user_45@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_45@example.com"}	7	2025-03-29 03:46:45.303627	2025-03-29 03:46:45.303627	8196a156-67eb-4f2f-b387-c5444a6deb59
73	test_user_46@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:46:47.478526	2025-03-29 03:46:47.478526	8196a156-67eb-4f2f-b387-c5444a6deb59
74	test_user_47@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:46:49.68106	2025-03-29 03:46:49.68106	8196a156-67eb-4f2f-b387-c5444a6deb59
75	test_user_48@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:46:51.841367	2025-03-29 03:46:51.841367	8196a156-67eb-4f2f-b387-c5444a6deb59
76	test_user_49@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:46:54.041491	2025-03-29 03:46:54.041491	8196a156-67eb-4f2f-b387-c5444a6deb59
77	test_user_50@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:46:56.234348	2025-03-29 03:46:56.234348	8196a156-67eb-4f2f-b387-c5444a6deb59
78	test_user_51@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_51@example.com"}	7	2025-03-29 03:46:57.238172	2025-03-29 03:46:57.238172	8196a156-67eb-4f2f-b387-c5444a6deb59
79	test_user_52@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_52@example.com"}	7	2025-03-29 03:46:57.297884	2025-03-29 03:46:57.297884	8196a156-67eb-4f2f-b387-c5444a6deb59
80	test_user_53@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_53@example.com"}	7	2025-03-29 03:46:57.354454	2025-03-29 03:46:57.354454	8196a156-67eb-4f2f-b387-c5444a6deb59
81	test_user_54@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_54@example.com"}	7	2025-03-29 03:46:57.422477	2025-03-29 03:46:57.422477	8196a156-67eb-4f2f-b387-c5444a6deb59
82	test_user_55@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:46:59.602908	2025-03-29 03:46:59.602908	8196a156-67eb-4f2f-b387-c5444a6deb59
83	test_user_56@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_56@example.com"}	7	2025-03-29 03:47:01.822466	2025-03-29 03:47:01.822466	8196a156-67eb-4f2f-b387-c5444a6deb59
84	test_user_57@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_57@example.com"}	7	2025-03-29 03:47:01.856801	2025-03-29 03:47:01.856801	8196a156-67eb-4f2f-b387-c5444a6deb59
85	test_user_58@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_58@example.com"}	7	2025-03-29 03:47:01.931818	2025-03-29 03:47:01.931818	8196a156-67eb-4f2f-b387-c5444a6deb59
86	test_user_59@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_59@example.com"}	7	2025-03-29 03:47:01.993794	2025-03-29 03:47:01.993794	8196a156-67eb-4f2f-b387-c5444a6deb59
87	test_user_60@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_60@example.com"}	7	2025-03-29 03:47:02.057481	2025-03-29 03:47:02.057481	8196a156-67eb-4f2f-b387-c5444a6deb59
88	test_user_61@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_61@example.com"}	7	2025-03-29 03:47:02.118156	2025-03-29 03:47:02.118156	8196a156-67eb-4f2f-b387-c5444a6deb59
89	test_user_62@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_62@example.com"}	7	2025-03-29 03:47:02.17367	2025-03-29 03:47:02.17367	8196a156-67eb-4f2f-b387-c5444a6deb59
90	test_user_63@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_63@example.com"}	7	2025-03-29 03:47:02.230483	2025-03-29 03:47:02.230483	8196a156-67eb-4f2f-b387-c5444a6deb59
91	test_user_64@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_64@example.com"}	7	2025-03-29 03:47:02.285243	2025-03-29 03:47:02.285243	8196a156-67eb-4f2f-b387-c5444a6deb59
92	test_user_65@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_65@example.com"}	7	2025-03-29 03:47:02.372645	2025-03-29 03:47:02.372645	8196a156-67eb-4f2f-b387-c5444a6deb59
93	test_user_66@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_66@example.com"}	7	2025-03-29 03:47:02.416773	2025-03-29 03:47:02.416773	8196a156-67eb-4f2f-b387-c5444a6deb59
94	test_user_67@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_67@example.com"}	7	2025-03-29 03:47:02.487846	2025-03-29 03:47:02.487846	8196a156-67eb-4f2f-b387-c5444a6deb59
95	test_user_68@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:47:04.680473	2025-03-29 03:47:04.680473	8196a156-67eb-4f2f-b387-c5444a6deb59
96	test_user_69@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:47:06.860754	2025-03-29 03:47:06.860754	8196a156-67eb-4f2f-b387-c5444a6deb59
97	test_user_70@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:47:09.019779	2025-03-29 03:47:09.019779	8196a156-67eb-4f2f-b387-c5444a6deb59
98	test_user_71@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:47:11.196324	2025-03-29 03:47:11.196324	8196a156-67eb-4f2f-b387-c5444a6deb59
99	test_user_72@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_72@example.com"}	7	2025-03-29 03:47:13.398839	2025-03-29 03:47:13.398839	8196a156-67eb-4f2f-b387-c5444a6deb59
100	test_user_73@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_73@example.com"}	7	2025-03-29 03:47:13.45321	2025-03-29 03:47:13.45321	8196a156-67eb-4f2f-b387-c5444a6deb59
101	test_user_74@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_74@example.com"}	7	2025-03-29 03:47:13.508457	2025-03-29 03:47:13.508457	8196a156-67eb-4f2f-b387-c5444a6deb59
102	test_user_75@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_75@example.com"}	7	2025-03-29 03:47:13.884387	2025-03-29 03:47:13.884387	8196a156-67eb-4f2f-b387-c5444a6deb59
103	test_user_76@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_76@example.com"}	7	2025-03-29 03:47:14.266674	2025-03-29 03:47:14.266674	8196a156-67eb-4f2f-b387-c5444a6deb59
104	test_user_77@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_77@example.com"}	7	2025-03-29 03:47:14.634848	2025-03-29 03:47:14.634848	8196a156-67eb-4f2f-b387-c5444a6deb59
105	test_user_78@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:47:16.80843	2025-03-29 03:47:16.80843	8196a156-67eb-4f2f-b387-c5444a6deb59
106	test_user_79@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:47:18.976054	2025-03-29 03:47:18.976054	8196a156-67eb-4f2f-b387-c5444a6deb59
107	test_user_80@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_80@example.com"}	7	2025-03-29 03:47:19.022629	2025-03-29 03:47:19.022629	8196a156-67eb-4f2f-b387-c5444a6deb59
108	test_user_81@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_81@example.com"}	7	2025-03-29 03:47:19.087147	2025-03-29 03:47:19.087147	8196a156-67eb-4f2f-b387-c5444a6deb59
109	test1@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com"}	7	2025-03-29 03:56:03.594477	2025-03-29 03:56:03.594477	8196a156-67eb-4f2f-b387-c5444a6deb59
110	test2@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test2@example.com"}	7	2025-03-29 03:56:03.660843	2025-03-29 03:56:03.660843	8196a156-67eb-4f2f-b387-c5444a6deb59
111	test3@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test3@example.com"}	7	2025-03-29 03:56:03.722101	2025-03-29 03:56:03.722101	8196a156-67eb-4f2f-b387-c5444a6deb59
112	test4@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test4@example.com"}	7	2025-03-29 03:56:03.833758	2025-03-29 03:56:03.833758	8196a156-67eb-4f2f-b387-c5444a6deb59
113	test5@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test5@example.com"}	7	2025-03-29 03:56:03.929564	2025-03-29 03:56:03.929564	8196a156-67eb-4f2f-b387-c5444a6deb59
114	test6@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test6@example.com"}	7	2025-03-29 03:56:04.028526	2025-03-29 03:56:04.028526	8196a156-67eb-4f2f-b387-c5444a6deb59
115	test7@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test7@example.com"}	7	2025-03-29 03:56:04.1179	2025-03-29 03:56:04.1179	8196a156-67eb-4f2f-b387-c5444a6deb59
116	test8@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test8@example.com"}	7	2025-03-29 03:56:04.190649	2025-03-29 03:56:04.190649	8196a156-67eb-4f2f-b387-c5444a6deb59
117	test9@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test9@example.com"}	7	2025-03-29 03:56:04.300167	2025-03-29 03:56:04.300167	8196a156-67eb-4f2f-b387-c5444a6deb59
118	test_user_19@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_19@example.com"}	7	2025-03-29 03:56:04.384499	2025-03-29 03:56:04.384499	8196a156-67eb-4f2f-b387-c5444a6deb59
119	enoch@rice.test	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: enoch@rice.test"}	7	2025-03-29 03:56:04.449795	2025-03-29 03:56:04.449795	8196a156-67eb-4f2f-b387-c5444a6deb59
120	yang@beier.example	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: yang@beier.example"}	7	2025-03-29 03:56:04.532121	2025-03-29 03:56:04.532121	8196a156-67eb-4f2f-b387-c5444a6deb59
121	johana@green.test	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: johana@green.test"}	7	2025-03-29 03:56:04.59794	2025-03-29 03:56:04.59794	8196a156-67eb-4f2f-b387-c5444a6deb59
122	vanetta.bechtelar@dietrich.test	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: vanetta.bechtelar@dietrich.test"}	7	2025-03-29 03:56:04.673052	2025-03-29 03:56:04.673052	8196a156-67eb-4f2f-b387-c5444a6deb59
123	merissa_kohler@fahey-mueller.example	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: merissa_kohler@fahey-mueller.example"}	7	2025-03-29 03:56:04.74185	2025-03-29 03:56:04.74185	8196a156-67eb-4f2f-b387-c5444a6deb59
124	bounce@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: bounce@example.com"}	7	2025-03-29 03:56:04.807171	2025-03-29 03:56:04.807171	8196a156-67eb-4f2f-b387-c5444a6deb59
125	cliente1@ejemplo.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: cliente1@ejemplo.com"}	7	2025-03-29 03:56:04.866516	2025-03-29 03:56:04.866516	8196a156-67eb-4f2f-b387-c5444a6deb59
126	test_user_20@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_20@example.com"}	7	2025-03-29 03:56:04.94581	2025-03-29 03:56:04.94581	8196a156-67eb-4f2f-b387-c5444a6deb59
127	info@maileraction.com	sent	{"message_id": "01000195e00ae3f1-a5177c06-2626-4b94-aecc-0a8b787e5666-000000"}	7	2025-03-29 03:56:05.076373	2025-03-29 03:56:05.076373	8196a156-67eb-4f2f-b387-c5444a6deb59
128	jenine_schuppe@ziemann-gleichner.example	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: jenine_schuppe@ziemann-gleichner.example"}	7	2025-03-29 03:56:05.133987	2025-03-29 03:56:05.133987	8196a156-67eb-4f2f-b387-c5444a6deb59
129	test_user_21@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_21@example.com"}	7	2025-03-29 03:56:05.214015	2025-03-29 03:56:05.214015	8196a156-67eb-4f2f-b387-c5444a6deb59
130	test_user_0@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_0@example.com"}	7	2025-03-29 03:56:05.27996	2025-03-29 03:56:05.27996	8196a156-67eb-4f2f-b387-c5444a6deb59
131	test_user_1@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_1@example.com"}	7	2025-03-29 03:56:05.345474	2025-03-29 03:56:05.345474	8196a156-67eb-4f2f-b387-c5444a6deb59
132	test_user_2@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_2@example.com"}	7	2025-03-29 03:56:05.438227	2025-03-29 03:56:05.438227	8196a156-67eb-4f2f-b387-c5444a6deb59
133	test_user_3@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_3@example.com"}	7	2025-03-29 03:56:05.530404	2025-03-29 03:56:05.530404	8196a156-67eb-4f2f-b387-c5444a6deb59
134	test_user_4@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_4@example.com"}	7	2025-03-29 03:56:05.584451	2025-03-29 03:56:05.584451	8196a156-67eb-4f2f-b387-c5444a6deb59
135	test_user_5@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_5@example.com"}	7	2025-03-29 03:56:05.649596	2025-03-29 03:56:05.649596	8196a156-67eb-4f2f-b387-c5444a6deb59
136	test_user_6@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_6@example.com"}	7	2025-03-29 03:56:05.707952	2025-03-29 03:56:05.707952	8196a156-67eb-4f2f-b387-c5444a6deb59
137	test_user_7@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_7@example.com"}	7	2025-03-29 03:56:05.771279	2025-03-29 03:56:05.771279	8196a156-67eb-4f2f-b387-c5444a6deb59
138	test_user_8@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_8@example.com"}	7	2025-03-29 03:56:05.849373	2025-03-29 03:56:05.849373	8196a156-67eb-4f2f-b387-c5444a6deb59
139	test_user_9@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_9@example.com"}	7	2025-03-29 03:56:05.941067	2025-03-29 03:56:05.941067	8196a156-67eb-4f2f-b387-c5444a6deb59
140	test_user_10@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_10@example.com"}	7	2025-03-29 03:56:05.998374	2025-03-29 03:56:05.998374	8196a156-67eb-4f2f-b387-c5444a6deb59
141	test_user_11@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_11@example.com"}	7	2025-03-29 03:56:06.053212	2025-03-29 03:56:06.053212	8196a156-67eb-4f2f-b387-c5444a6deb59
142	test_user_12@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_12@example.com"}	7	2025-03-29 03:56:06.134201	2025-03-29 03:56:06.134201	8196a156-67eb-4f2f-b387-c5444a6deb59
143	test_user_13@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_13@example.com"}	7	2025-03-29 03:56:06.193679	2025-03-29 03:56:06.193679	8196a156-67eb-4f2f-b387-c5444a6deb59
144	test_user_14@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_14@example.com"}	7	2025-03-29 03:56:06.268761	2025-03-29 03:56:06.268761	8196a156-67eb-4f2f-b387-c5444a6deb59
145	test_user_15@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_15@example.com"}	7	2025-03-29 03:56:06.323806	2025-03-29 03:56:06.323806	8196a156-67eb-4f2f-b387-c5444a6deb59
146	test_user_16@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_16@example.com"}	7	2025-03-29 03:56:06.399054	2025-03-29 03:56:06.399054	8196a156-67eb-4f2f-b387-c5444a6deb59
147	test_user_17@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_17@example.com"}	7	2025-03-29 03:56:06.431809	2025-03-29 03:56:06.431809	8196a156-67eb-4f2f-b387-c5444a6deb59
148	test_user_18@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_18@example.com"}	7	2025-03-29 03:56:06.490455	2025-03-29 03:56:06.490455	8196a156-67eb-4f2f-b387-c5444a6deb59
149	test_user_22@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_22@example.com"}	7	2025-03-29 03:56:06.559927	2025-03-29 03:56:06.559927	8196a156-67eb-4f2f-b387-c5444a6deb59
150	test_user_23@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_23@example.com"}	7	2025-03-29 03:56:06.631678	2025-03-29 03:56:06.631678	8196a156-67eb-4f2f-b387-c5444a6deb59
151	test_user_24@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_24@example.com"}	7	2025-03-29 03:56:06.708015	2025-03-29 03:56:06.708015	8196a156-67eb-4f2f-b387-c5444a6deb59
152	test_user_26@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_26@example.com"}	7	2025-03-29 03:56:06.761338	2025-03-29 03:56:06.761338	8196a156-67eb-4f2f-b387-c5444a6deb59
153	test_user_27@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_27@example.com"}	7	2025-03-29 03:56:06.796558	2025-03-29 03:56:06.796558	8196a156-67eb-4f2f-b387-c5444a6deb59
154	test_user_28@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_28@example.com"}	7	2025-03-29 03:56:06.853023	2025-03-29 03:56:06.853023	8196a156-67eb-4f2f-b387-c5444a6deb59
155	test_user_29@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_29@example.com"}	7	2025-03-29 03:56:06.943464	2025-03-29 03:56:06.943464	8196a156-67eb-4f2f-b387-c5444a6deb59
156	test_user_30@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_30@example.com"}	7	2025-03-29 03:56:07.025046	2025-03-29 03:56:07.025046	8196a156-67eb-4f2f-b387-c5444a6deb59
157	test_user_31@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_31@example.com"}	7	2025-03-29 03:56:07.079064	2025-03-29 03:56:07.079064	8196a156-67eb-4f2f-b387-c5444a6deb59
158	test_user_32@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_32@example.com"}	7	2025-03-29 03:56:07.135716	2025-03-29 03:56:07.135716	8196a156-67eb-4f2f-b387-c5444a6deb59
159	test_user_33@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_33@example.com"}	7	2025-03-29 03:56:07.204337	2025-03-29 03:56:07.204337	8196a156-67eb-4f2f-b387-c5444a6deb59
160	test_user_34@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_34@example.com"}	7	2025-03-29 03:56:07.296607	2025-03-29 03:56:07.296607	8196a156-67eb-4f2f-b387-c5444a6deb59
161	test_user_35@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_35@example.com"}	7	2025-03-29 03:56:07.349805	2025-03-29 03:56:07.349805	8196a156-67eb-4f2f-b387-c5444a6deb59
162	test_user_36@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_36@example.com"}	7	2025-03-29 03:56:07.420787	2025-03-29 03:56:07.420787	8196a156-67eb-4f2f-b387-c5444a6deb59
163	test_user_37@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_37@example.com"}	7	2025-03-29 03:56:07.480925	2025-03-29 03:56:07.480925	8196a156-67eb-4f2f-b387-c5444a6deb59
164	test_user_38@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_38@example.com"}	7	2025-03-29 03:56:07.536442	2025-03-29 03:56:07.536442	8196a156-67eb-4f2f-b387-c5444a6deb59
165	test_user_39@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_39@example.com"}	7	2025-03-29 03:56:07.568521	2025-03-29 03:56:07.568521	8196a156-67eb-4f2f-b387-c5444a6deb59
166	test_user_40@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_40@example.com"}	7	2025-03-29 03:56:07.624796	2025-03-29 03:56:07.624796	8196a156-67eb-4f2f-b387-c5444a6deb59
167	test_user_41@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_41@example.com"}	7	2025-03-29 03:56:07.694185	2025-03-29 03:56:07.694185	8196a156-67eb-4f2f-b387-c5444a6deb59
168	test_user_42@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_42@example.com"}	7	2025-03-29 03:56:07.774698	2025-03-29 03:56:07.774698	8196a156-67eb-4f2f-b387-c5444a6deb59
169	test_user_43@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_43@example.com"}	7	2025-03-29 03:56:07.858645	2025-03-29 03:56:07.858645	8196a156-67eb-4f2f-b387-c5444a6deb59
170	test_user_44@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_44@example.com"}	7	2025-03-29 03:56:07.89159	2025-03-29 03:56:07.89159	8196a156-67eb-4f2f-b387-c5444a6deb59
171	test_user_45@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_45@example.com"}	7	2025-03-29 03:56:07.925105	2025-03-29 03:56:07.925105	8196a156-67eb-4f2f-b387-c5444a6deb59
172	test_user_46@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_46@example.com"}	7	2025-03-29 03:56:07.960741	2025-03-29 03:56:07.960741	8196a156-67eb-4f2f-b387-c5444a6deb59
173	test_user_47@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_47@example.com"}	7	2025-03-29 03:56:07.99541	2025-03-29 03:56:07.99541	8196a156-67eb-4f2f-b387-c5444a6deb59
174	test_user_48@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_48@example.com"}	7	2025-03-29 03:56:08.05373	2025-03-29 03:56:08.05373	8196a156-67eb-4f2f-b387-c5444a6deb59
175	test_user_49@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_49@example.com"}	7	2025-03-29 03:56:08.117344	2025-03-29 03:56:08.117344	8196a156-67eb-4f2f-b387-c5444a6deb59
176	test_user_82@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_82@example.com"}	7	2025-03-29 03:56:08.168376	2025-03-29 03:56:08.168376	8196a156-67eb-4f2f-b387-c5444a6deb59
177	test_user_83@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_83@example.com"}	7	2025-03-29 03:56:08.227933	2025-03-29 03:56:08.227933	8196a156-67eb-4f2f-b387-c5444a6deb59
178	test_user_84@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_84@example.com"}	7	2025-03-29 03:56:08.326302	2025-03-29 03:56:08.326302	8196a156-67eb-4f2f-b387-c5444a6deb59
179	test_user_85@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_85@example.com"}	7	2025-03-29 03:56:08.368639	2025-03-29 03:56:08.368639	8196a156-67eb-4f2f-b387-c5444a6deb59
180	test_user_86@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_86@example.com"}	7	2025-03-29 03:56:08.449929	2025-03-29 03:56:08.449929	8196a156-67eb-4f2f-b387-c5444a6deb59
181	test_user_87@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_87@example.com"}	7	2025-03-29 03:56:08.502721	2025-03-29 03:56:08.502721	8196a156-67eb-4f2f-b387-c5444a6deb59
182	test_user_88@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_88@example.com"}	7	2025-03-29 03:56:08.589812	2025-03-29 03:56:08.589812	8196a156-67eb-4f2f-b387-c5444a6deb59
183	test_user_89@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_89@example.com"}	7	2025-03-29 03:56:08.649405	2025-03-29 03:56:08.649405	8196a156-67eb-4f2f-b387-c5444a6deb59
184	test_user_90@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_90@example.com"}	7	2025-03-29 03:56:08.704176	2025-03-29 03:56:08.704176	8196a156-67eb-4f2f-b387-c5444a6deb59
185	test_user_91@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_91@example.com"}	7	2025-03-29 03:56:09.108601	2025-03-29 03:56:09.108601	8196a156-67eb-4f2f-b387-c5444a6deb59
186	test_user_92@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_92@example.com"}	7	2025-03-29 03:56:09.169967	2025-03-29 03:56:09.169967	8196a156-67eb-4f2f-b387-c5444a6deb59
187	test_user_93@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_93@example.com"}	7	2025-03-29 03:56:09.242081	2025-03-29 03:56:09.242081	8196a156-67eb-4f2f-b387-c5444a6deb59
188	test_user_94@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_94@example.com"}	7	2025-03-29 03:56:09.29843	2025-03-29 03:56:09.29843	8196a156-67eb-4f2f-b387-c5444a6deb59
189	test_user_95@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_95@example.com"}	7	2025-03-29 03:56:09.352941	2025-03-29 03:56:09.352941	8196a156-67eb-4f2f-b387-c5444a6deb59
190	test_user_96@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_96@example.com"}	7	2025-03-29 03:56:09.720973	2025-03-29 03:56:09.720973	8196a156-67eb-4f2f-b387-c5444a6deb59
191	test_user_97@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_97@example.com"}	7	2025-03-29 03:56:09.82336	2025-03-29 03:56:09.82336	8196a156-67eb-4f2f-b387-c5444a6deb59
192	test_user_98@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_98@example.com"}	7	2025-03-29 03:56:10.769671	2025-03-29 03:56:10.769671	8196a156-67eb-4f2f-b387-c5444a6deb59
193	test_user_99@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_99@example.com"}	7	2025-03-29 03:56:10.80775	2025-03-29 03:56:10.80775	8196a156-67eb-4f2f-b387-c5444a6deb59
194	test_user_100@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_100@example.com"}	7	2025-03-29 03:56:11.176515	2025-03-29 03:56:11.176515	8196a156-67eb-4f2f-b387-c5444a6deb59
195	test_user_101@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_101@example.com"}	7	2025-03-29 03:56:11.257678	2025-03-29 03:56:11.257678	8196a156-67eb-4f2f-b387-c5444a6deb59
196	test_user_102@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_102@example.com"}	7	2025-03-29 03:56:11.663289	2025-03-29 03:56:11.663289	8196a156-67eb-4f2f-b387-c5444a6deb59
197	test_user_103@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_103@example.com"}	7	2025-03-29 03:56:12.014291	2025-03-29 03:56:12.014291	8196a156-67eb-4f2f-b387-c5444a6deb59
198	test_user_104@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_104@example.com"}	7	2025-03-29 03:56:12.096529	2025-03-29 03:56:12.096529	8196a156-67eb-4f2f-b387-c5444a6deb59
199	test_user_105@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_105@example.com"}	7	2025-03-29 03:56:12.157727	2025-03-29 03:56:12.157727	8196a156-67eb-4f2f-b387-c5444a6deb59
200	test_user_106@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_106@example.com"}	7	2025-03-29 03:56:12.244624	2025-03-29 03:56:12.244624	8196a156-67eb-4f2f-b387-c5444a6deb59
201	test_user_107@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_107@example.com"}	7	2025-03-29 03:56:13.192645	2025-03-29 03:56:13.192645	8196a156-67eb-4f2f-b387-c5444a6deb59
202	test_user_108@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_108@example.com"}	7	2025-03-29 03:56:13.24886	2025-03-29 03:56:13.24886	8196a156-67eb-4f2f-b387-c5444a6deb59
203	test_user_109@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_109@example.com"}	7	2025-03-29 03:56:13.305353	2025-03-29 03:56:13.305353	8196a156-67eb-4f2f-b387-c5444a6deb59
204	test_user_110@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_110@example.com"}	7	2025-03-29 03:56:13.361613	2025-03-29 03:56:13.361613	8196a156-67eb-4f2f-b387-c5444a6deb59
205	test_user_111@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_111@example.com"}	7	2025-03-29 03:56:13.760324	2025-03-29 03:56:13.760324	8196a156-67eb-4f2f-b387-c5444a6deb59
206	test_user_112@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_112@example.com"}	7	2025-03-29 03:56:13.792607	2025-03-29 03:56:13.792607	8196a156-67eb-4f2f-b387-c5444a6deb59
207	test_user_113@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_113@example.com"}	7	2025-03-29 03:56:13.890099	2025-03-29 03:56:13.890099	8196a156-67eb-4f2f-b387-c5444a6deb59
208	test_user_114@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_114@example.com"}	7	2025-03-29 03:56:13.972101	2025-03-29 03:56:13.972101	8196a156-67eb-4f2f-b387-c5444a6deb59
209	test_user_76@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_76@example.com"}	7	2025-03-29 03:56:44.089592	2025-03-29 03:56:44.089592	8196a156-67eb-4f2f-b387-c5444a6deb59
210	test_user_77@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_77@example.com"}	7	2025-03-29 03:56:44.182236	2025-03-29 03:56:44.182236	8196a156-67eb-4f2f-b387-c5444a6deb59
211	test_user_78@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_78@example.com"}	7	2025-03-29 03:56:44.245408	2025-03-29 03:56:44.245408	8196a156-67eb-4f2f-b387-c5444a6deb59
212	test_user_79@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_79@example.com"}	7	2025-03-29 03:56:44.305197	2025-03-29 03:56:44.305197	8196a156-67eb-4f2f-b387-c5444a6deb59
213	test_user_80@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_80@example.com"}	7	2025-03-29 03:56:44.36746	2025-03-29 03:56:44.36746	8196a156-67eb-4f2f-b387-c5444a6deb59
214	test_user_81@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_81@example.com"}	7	2025-03-29 03:56:44.439357	2025-03-29 03:56:44.439357	8196a156-67eb-4f2f-b387-c5444a6deb59
215	test_user_82@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_82@example.com"}	7	2025-03-29 03:56:44.480355	2025-03-29 03:56:44.480355	8196a156-67eb-4f2f-b387-c5444a6deb59
216	test_user_83@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_83@example.com"}	7	2025-03-29 03:56:44.549298	2025-03-29 03:56:44.549298	8196a156-67eb-4f2f-b387-c5444a6deb59
217	test_user_84@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_84@example.com"}	7	2025-03-29 03:56:44.619917	2025-03-29 03:56:44.619917	8196a156-67eb-4f2f-b387-c5444a6deb59
218	test_user_85@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_85@example.com"}	7	2025-03-29 03:56:44.649332	2025-03-29 03:56:44.649332	8196a156-67eb-4f2f-b387-c5444a6deb59
219	test_user_86@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_86@example.com"}	7	2025-03-29 03:56:44.705272	2025-03-29 03:56:44.705272	8196a156-67eb-4f2f-b387-c5444a6deb59
220	test_user_87@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_87@example.com"}	7	2025-03-29 03:56:45.053292	2025-03-29 03:56:45.053292	8196a156-67eb-4f2f-b387-c5444a6deb59
221	test_user_88@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_88@example.com"}	7	2025-03-29 03:56:45.089999	2025-03-29 03:56:45.089999	8196a156-67eb-4f2f-b387-c5444a6deb59
222	test_user_89@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_89@example.com"}	7	2025-03-29 03:56:45.168912	2025-03-29 03:56:45.168912	8196a156-67eb-4f2f-b387-c5444a6deb59
223	test_user_90@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_90@example.com"}	7	2025-03-29 03:56:45.2585	2025-03-29 03:56:45.2585	8196a156-67eb-4f2f-b387-c5444a6deb59
224	test_user_91@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_91@example.com"}	7	2025-03-29 03:56:45.323495	2025-03-29 03:56:45.323495	8196a156-67eb-4f2f-b387-c5444a6deb59
225	test_user_92@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_92@example.com"}	7	2025-03-29 03:56:45.383741	2025-03-29 03:56:45.383741	8196a156-67eb-4f2f-b387-c5444a6deb59
226	test_user_93@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_93@example.com"}	7	2025-03-29 03:56:45.763531	2025-03-29 03:56:45.763531	8196a156-67eb-4f2f-b387-c5444a6deb59
227	test_user_94@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_94@example.com"}	7	2025-03-29 03:56:45.851941	2025-03-29 03:56:45.851941	8196a156-67eb-4f2f-b387-c5444a6deb59
228	test_user_96@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_96@example.com"}	7	2025-03-29 03:56:46.807434	2025-03-29 03:56:46.807434	8196a156-67eb-4f2f-b387-c5444a6deb59
229	test_user_97@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_97@example.com"}	7	2025-03-29 03:56:46.872837	2025-03-29 03:56:46.872837	8196a156-67eb-4f2f-b387-c5444a6deb59
230	test_user_98@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_98@example.com"}	7	2025-03-29 03:56:46.928887	2025-03-29 03:56:46.928887	8196a156-67eb-4f2f-b387-c5444a6deb59
231	test_user_99@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_99@example.com"}	7	2025-03-29 03:56:47.017731	2025-03-29 03:56:47.017731	8196a156-67eb-4f2f-b387-c5444a6deb59
232	test_user_100@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_100@example.com"}	7	2025-03-29 03:56:47.071789	2025-03-29 03:56:47.071789	8196a156-67eb-4f2f-b387-c5444a6deb59
233	test_user_101@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_101@example.com"}	7	2025-03-29 03:56:47.129033	2025-03-29 03:56:47.129033	8196a156-67eb-4f2f-b387-c5444a6deb59
234	test_user_102@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_102@example.com"}	7	2025-03-29 03:56:47.184202	2025-03-29 03:56:47.184202	8196a156-67eb-4f2f-b387-c5444a6deb59
235	test_user_103@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_103@example.com"}	7	2025-03-29 03:56:47.260763	2025-03-29 03:56:47.260763	8196a156-67eb-4f2f-b387-c5444a6deb59
236	test_user_104@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_104@example.com"}	7	2025-03-29 03:56:47.322565	2025-03-29 03:56:47.322565	8196a156-67eb-4f2f-b387-c5444a6deb59
237	test_user_105@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_105@example.com"}	7	2025-03-29 03:56:47.357862	2025-03-29 03:56:47.357862	8196a156-67eb-4f2f-b387-c5444a6deb59
238	test_user_106@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_106@example.com"}	7	2025-03-29 03:56:47.422302	2025-03-29 03:56:47.422302	8196a156-67eb-4f2f-b387-c5444a6deb59
239	test_user_107@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_107@example.com"}	7	2025-03-29 03:56:48.386337	2025-03-29 03:56:48.386337	8196a156-67eb-4f2f-b387-c5444a6deb59
240	test_user_108@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_108@example.com"}	7	2025-03-29 03:56:48.436759	2025-03-29 03:56:48.436759	8196a156-67eb-4f2f-b387-c5444a6deb59
241	test_user_109@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_109@example.com"}	7	2025-03-29 03:56:48.467879	2025-03-29 03:56:48.467879	8196a156-67eb-4f2f-b387-c5444a6deb59
242	test_user_110@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_110@example.com"}	7	2025-03-29 03:56:48.525153	2025-03-29 03:56:48.525153	8196a156-67eb-4f2f-b387-c5444a6deb59
243	test_user_111@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_111@example.com"}	7	2025-03-29 03:56:48.557317	2025-03-29 03:56:48.557317	8196a156-67eb-4f2f-b387-c5444a6deb59
244	test_user_112@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_112@example.com"}	7	2025-03-29 03:56:48.919339	2025-03-29 03:56:48.919339	8196a156-67eb-4f2f-b387-c5444a6deb59
245	test_user_113@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_113@example.com"}	7	2025-03-29 03:56:48.952801	2025-03-29 03:56:48.952801	8196a156-67eb-4f2f-b387-c5444a6deb59
246	test_user_114@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_114@example.com"}	7	2025-03-29 03:56:48.97821	2025-03-29 03:56:48.97821	8196a156-67eb-4f2f-b387-c5444a6deb59
247	test_user_125@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_125@example.com"}	7	2025-03-29 03:56:49.346278	2025-03-29 03:56:49.346278	8196a156-67eb-4f2f-b387-c5444a6deb59
248	test_user_126@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_126@example.com"}	7	2025-03-29 03:56:49.438515	2025-03-29 03:56:49.438515	8196a156-67eb-4f2f-b387-c5444a6deb59
249	test_user_127@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_127@example.com"}	7	2025-03-29 03:56:49.470656	2025-03-29 03:56:49.470656	8196a156-67eb-4f2f-b387-c5444a6deb59
250	test_user_128@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_128@example.com"}	7	2025-03-29 03:56:49.500854	2025-03-29 03:56:49.500854	8196a156-67eb-4f2f-b387-c5444a6deb59
251	test_user_129@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_129@example.com"}	7	2025-03-29 03:56:49.839993	2025-03-29 03:56:49.839993	8196a156-67eb-4f2f-b387-c5444a6deb59
252	test_user_130@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_130@example.com"}	7	2025-03-29 03:56:49.868903	2025-03-29 03:56:49.868903	8196a156-67eb-4f2f-b387-c5444a6deb59
253	test_user_131@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_131@example.com"}	7	2025-03-29 03:56:50.260642	2025-03-29 03:56:50.260642	8196a156-67eb-4f2f-b387-c5444a6deb59
254	test_user_132@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_132@example.com"}	7	2025-03-29 03:56:50.291478	2025-03-29 03:56:50.291478	8196a156-67eb-4f2f-b387-c5444a6deb59
255	test_user_133@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_133@example.com"}	7	2025-03-29 03:56:50.32265	2025-03-29 03:56:50.32265	8196a156-67eb-4f2f-b387-c5444a6deb59
256	test_user_134@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_134@example.com"}	7	2025-03-29 03:56:50.379406	2025-03-29 03:56:50.379406	8196a156-67eb-4f2f-b387-c5444a6deb59
257	test_user_135@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:56:52.51781	2025-03-29 03:56:52.51781	8196a156-67eb-4f2f-b387-c5444a6deb59
258	test_user_136@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_136@example.com"}	7	2025-03-29 03:56:52.582808	2025-03-29 03:56:52.582808	8196a156-67eb-4f2f-b387-c5444a6deb59
259	test_user_137@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_137@example.com"}	7	2025-03-29 03:56:52.61568	2025-03-29 03:56:52.61568	8196a156-67eb-4f2f-b387-c5444a6deb59
260	test_user_138@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_138@example.com"}	7	2025-03-29 03:56:52.672772	2025-03-29 03:56:52.672772	8196a156-67eb-4f2f-b387-c5444a6deb59
261	test_user_139@example.com	error	{"error_message": "Maximum sending rate exceeded."}	7	2025-03-29 03:56:54.81544	2025-03-29 03:56:54.81544	8196a156-67eb-4f2f-b387-c5444a6deb59
262	test_user_140@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_140@example.com"}	7	2025-03-29 03:56:54.876665	2025-03-29 03:56:54.876665	8196a156-67eb-4f2f-b387-c5444a6deb59
263	test_user_141@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_141@example.com"}	7	2025-03-29 03:56:55.261205	2025-03-29 03:56:55.261205	8196a156-67eb-4f2f-b387-c5444a6deb59
264	test_user_142@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_142@example.com"}	7	2025-03-29 03:56:55.322726	2025-03-29 03:56:55.322726	8196a156-67eb-4f2f-b387-c5444a6deb59
265	test_user_143@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_143@example.com"}	7	2025-03-29 03:56:55.394679	2025-03-29 03:56:55.394679	8196a156-67eb-4f2f-b387-c5444a6deb59
266	test_user_144@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_144@example.com"}	7	2025-03-29 03:56:55.453039	2025-03-29 03:56:55.453039	8196a156-67eb-4f2f-b387-c5444a6deb59
267	test_user_145@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_145@example.com"}	7	2025-03-29 03:56:55.815505	2025-03-29 03:56:55.815505	8196a156-67eb-4f2f-b387-c5444a6deb59
268	test_user_146@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_146@example.com"}	7	2025-03-29 03:56:56.15662	2025-03-29 03:56:56.15662	8196a156-67eb-4f2f-b387-c5444a6deb59
269	test_user_147@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_147@example.com"}	7	2025-03-29 03:56:56.186637	2025-03-29 03:56:56.186637	8196a156-67eb-4f2f-b387-c5444a6deb59
270	test_user_148@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_148@example.com"}	7	2025-03-29 03:56:56.243109	2025-03-29 03:56:56.243109	8196a156-67eb-4f2f-b387-c5444a6deb59
271	test_user_149@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_149@example.com"}	7	2025-03-29 03:56:56.303226	2025-03-29 03:56:56.303226	8196a156-67eb-4f2f-b387-c5444a6deb59
272	test0@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test0@example.com"}	7	2025-03-29 03:56:56.358083	2025-03-29 03:56:56.358083	8196a156-67eb-4f2f-b387-c5444a6deb59
273	test_user_25@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_25@example.com"}	7	2025-03-29 03:56:56.443156	2025-03-29 03:56:56.443156	8196a156-67eb-4f2f-b387-c5444a6deb59
274	test_user_50@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_50@example.com"}	7	2025-03-29 03:56:56.475609	2025-03-29 03:56:56.475609	8196a156-67eb-4f2f-b387-c5444a6deb59
275	test_user_68@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_68@example.com"}	7	2025-03-29 03:56:56.52984	2025-03-29 03:56:56.52984	8196a156-67eb-4f2f-b387-c5444a6deb59
276	test1@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test1@example.com"}	7	2025-03-29 03:56:56.889474	2025-03-29 03:56:56.889474	8196a156-67eb-4f2f-b387-c5444a6deb59
277	test_user_95@example.com	error	{"error_message": "Email address is not verified. The following identities failed the check in region US-EAST-1: test_user_95@example.com"}	7	2025-03-29 03:56:56.951271	2025-03-29 03:56:56.951271	8196a156-67eb-4f2f-b387-c5444a6deb59
\.


--
-- Data for Name: email_logs; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.email_logs (id, status, opened_at, clicked_at, campaign_id, email_record_id, created_at, updated_at, credit_refunded, attempts_count, campaign_uuid) FROM stdin;
15	error	\N	\N	6	22	2025-03-26 03:24:25.5696	2025-03-26 03:27:25.594772	f	\N	0f32ec4d-470d-4829-8bcd-048957a5e185
16	error	\N	\N	6	19	2025-03-26 03:25:46.983738	2025-03-26 03:28:46.984467	f	\N	0f32ec4d-470d-4829-8bcd-048957a5e185
17	error	\N	\N	6	20	2025-03-26 03:25:46.987499	2025-03-26 03:28:46.988166	f	\N	0f32ec4d-470d-4829-8bcd-048957a5e185
18	error	\N	\N	6	21	2025-03-26 03:25:46.99069	2025-03-26 03:28:46.991206	f	\N	0f32ec4d-470d-4829-8bcd-048957a5e185
19	error	\N	\N	6	1	2025-03-26 03:29:02.134503	2025-03-26 03:29:02.134503	f	\N	0f32ec4d-470d-4829-8bcd-048957a5e185
20	error	\N	\N	6	2	2025-03-26 03:29:02.209768	2025-03-26 03:29:02.209768	f	\N	0f32ec4d-470d-4829-8bcd-048957a5e185
21	error	\N	\N	6	3	2025-03-26 03:29:02.271978	2025-03-26 03:29:02.271978	f	\N	0f32ec4d-470d-4829-8bcd-048957a5e185
22	delivered	2025-03-27 20:03:35.193575	2025-03-28 15:26:35.991124	1	11	2025-03-27 19:59:57.056784	2025-03-28 15:26:35.991735	f	\N	024eba05-3608-4a52-ac71-5a569d4daebf
23	error	\N	\N	2	1	2025-03-28 17:17:33.833449	2025-03-28 17:17:33.833449	f	\N	b4570b6b-9283-4956-8371-2c88ba49d56b
24	error	\N	\N	5	1	2025-03-28 17:32:02.086306	2025-03-28 17:32:02.086306	f	3	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
25	error	\N	\N	5	2	2025-03-28 17:32:02.220335	2025-03-28 17:32:02.220335	f	3	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
26	error	\N	\N	5	3	2025-03-28 17:32:02.295365	2025-03-28 17:32:02.295365	f	3	344200ac-2c83-4a99-bbf6-3f78cc21e0c8
27	error	\N	\N	7	1	2025-03-29 02:02:56.865396	2025-03-29 02:02:56.865396	f	1	8196a156-67eb-4f2f-b387-c5444a6deb59
32	error	\N	\N	7	11	2025-03-29 03:07:32.216489	2025-03-29 03:07:32.216489	f	3	8196a156-67eb-4f2f-b387-c5444a6deb59
33	error	\N	\N	7	1	2025-03-29 03:46:41.088707	2025-03-29 03:46:41.088707	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
34	error	\N	\N	7	2	2025-03-29 03:46:41.189035	2025-03-29 03:46:41.189035	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
35	error	\N	\N	7	3	2025-03-29 03:46:41.26653	2025-03-29 03:46:41.26653	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
36	error	\N	\N	7	4	2025-03-29 03:46:41.342057	2025-03-29 03:46:41.342057	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
37	error	\N	\N	7	5	2025-03-29 03:46:41.426055	2025-03-29 03:46:41.426055	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
38	error	\N	\N	7	6	2025-03-29 03:46:41.489127	2025-03-29 03:46:41.489127	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
39	error	\N	\N	7	7	2025-03-29 03:46:41.562881	2025-03-29 03:46:41.562881	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
40	error	\N	\N	7	8	2025-03-29 03:46:41.630112	2025-03-29 03:46:41.630112	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
41	error	\N	\N	7	9	2025-03-29 03:46:41.693502	2025-03-29 03:46:41.693502	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
42	error	\N	\N	7	10	2025-03-29 03:46:41.754926	2025-03-29 03:46:41.754926	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
43	error	\N	\N	7	44	2025-03-29 03:46:41.82101	2025-03-29 03:46:41.82101	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
44	error	\N	\N	7	13	2025-03-29 03:46:41.885759	2025-03-29 03:46:41.885759	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
45	error	\N	\N	7	14	2025-03-29 03:46:41.944329	2025-03-29 03:46:41.944329	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
46	error	\N	\N	7	15	2025-03-29 03:46:42.010464	2025-03-29 03:46:42.010464	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
47	error	\N	\N	7	19	2025-03-29 03:46:42.070929	2025-03-29 03:46:42.070929	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
48	error	\N	\N	7	20	2025-03-29 03:46:42.144972	2025-03-29 03:46:42.144972	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
49	error	\N	\N	7	21	2025-03-29 03:46:42.212934	2025-03-29 03:46:42.212934	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
50	error	\N	\N	7	23	2025-03-29 03:46:42.279816	2025-03-29 03:46:42.279816	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
51	error	\N	\N	7	24	2025-03-29 03:46:42.342212	2025-03-29 03:46:42.342212	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
52	error	\N	\N	7	45	2025-03-29 03:46:42.403632	2025-03-29 03:46:42.403632	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
53	error	\N	\N	7	46	2025-03-29 03:46:42.468438	2025-03-29 03:46:42.468438	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
54	error	\N	\N	7	25	2025-03-29 03:46:42.525686	2025-03-29 03:46:42.525686	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
55	error	\N	\N	7	26	2025-03-29 03:46:42.592083	2025-03-29 03:46:42.592083	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
56	error	\N	\N	7	27	2025-03-29 03:46:42.653129	2025-03-29 03:46:42.653129	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
57	error	\N	\N	7	28	2025-03-29 03:46:42.714588	2025-03-29 03:46:42.714588	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
58	error	\N	\N	7	29	2025-03-29 03:46:42.7839	2025-03-29 03:46:42.7839	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
59	error	\N	\N	7	30	2025-03-29 03:46:42.854892	2025-03-29 03:46:42.854892	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
60	error	\N	\N	7	31	2025-03-29 03:46:42.919742	2025-03-29 03:46:42.919742	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
61	error	\N	\N	7	32	2025-03-29 03:46:42.984295	2025-03-29 03:46:42.984295	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
62	error	\N	\N	7	33	2025-03-29 03:46:43.062448	2025-03-29 03:46:43.062448	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
63	error	\N	\N	7	34	2025-03-29 03:46:43.132511	2025-03-29 03:46:43.132511	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
64	error	\N	\N	7	35	2025-03-29 03:46:43.196585	2025-03-29 03:46:43.196585	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
65	error	\N	\N	7	36	2025-03-29 03:46:43.259918	2025-03-29 03:46:43.259918	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
66	error	\N	\N	7	37	2025-03-29 03:46:43.323709	2025-03-29 03:46:43.323709	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
67	error	\N	\N	7	38	2025-03-29 03:46:43.389972	2025-03-29 03:46:43.389972	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
68	error	\N	\N	7	39	2025-03-29 03:46:43.456154	2025-03-29 03:46:43.456154	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
69	error	\N	\N	7	40	2025-03-29 03:46:43.541499	2025-03-29 03:46:43.541499	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
70	error	\N	\N	7	41	2025-03-29 03:46:43.633025	2025-03-29 03:46:43.633025	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
71	error	\N	\N	7	42	2025-03-29 03:46:43.692818	2025-03-29 03:46:43.692818	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
72	error	\N	\N	7	43	2025-03-29 03:46:43.760331	2025-03-29 03:46:43.760331	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
73	error	\N	\N	7	47	2025-03-29 03:46:43.835578	2025-03-29 03:46:43.835578	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
74	error	\N	\N	7	48	2025-03-29 03:46:43.912148	2025-03-29 03:46:43.912148	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
75	error	\N	\N	7	49	2025-03-29 03:46:44.004876	2025-03-29 03:46:44.004876	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
76	error	\N	\N	7	50	2025-03-29 03:46:44.071317	2025-03-29 03:46:44.071317	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
77	error	\N	\N	7	51	2025-03-29 03:46:44.133412	2025-03-29 03:46:44.133412	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
78	error	\N	\N	7	52	2025-03-29 03:46:44.193232	2025-03-29 03:46:44.193232	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
79	error	\N	\N	7	53	2025-03-29 03:46:44.250851	2025-03-29 03:46:44.250851	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
80	error	\N	\N	7	54	2025-03-29 03:46:44.315105	2025-03-29 03:46:44.315105	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
81	error	\N	\N	7	55	2025-03-29 03:46:44.379117	2025-03-29 03:46:44.379117	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
82	error	\N	\N	7	56	2025-03-29 03:46:44.441992	2025-03-29 03:46:44.441992	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
83	error	\N	\N	7	57	2025-03-29 03:46:44.50467	2025-03-29 03:46:44.50467	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
84	error	\N	\N	7	58	2025-03-29 03:46:44.56606	2025-03-29 03:46:44.56606	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
85	error	\N	\N	7	59	2025-03-29 03:46:44.621121	2025-03-29 03:46:44.621121	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
86	error	\N	\N	7	60	2025-03-29 03:46:44.680742	2025-03-29 03:46:44.680742	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
87	error	\N	\N	7	61	2025-03-29 03:46:44.74475	2025-03-29 03:46:44.74475	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
88	error	\N	\N	7	62	2025-03-29 03:46:44.802808	2025-03-29 03:46:44.802808	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
89	error	\N	\N	7	63	2025-03-29 03:46:44.86636	2025-03-29 03:46:44.86636	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
90	error	\N	\N	7	64	2025-03-29 03:46:44.906506	2025-03-29 03:46:44.906506	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
91	error	\N	\N	7	65	2025-03-29 03:46:44.971853	2025-03-29 03:46:44.971853	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
92	error	\N	\N	7	66	2025-03-29 03:46:45.039899	2025-03-29 03:46:45.039899	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
93	error	\N	\N	7	67	2025-03-29 03:46:45.10497	2025-03-29 03:46:45.10497	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
94	error	\N	\N	7	68	2025-03-29 03:46:45.174227	2025-03-29 03:46:45.174227	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
95	error	\N	\N	7	69	2025-03-29 03:46:45.23671	2025-03-29 03:46:45.23671	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
96	error	\N	\N	7	70	2025-03-29 03:46:45.296281	2025-03-29 03:46:45.296281	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
97	error	\N	\N	7	71	2025-03-29 03:46:47.472934	2025-03-29 03:46:47.472934	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
98	error	\N	\N	7	72	2025-03-29 03:46:49.675558	2025-03-29 03:46:49.675558	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
99	error	\N	\N	7	73	2025-03-29 03:46:51.833818	2025-03-29 03:46:51.833818	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
100	error	\N	\N	7	74	2025-03-29 03:46:54.032659	2025-03-29 03:46:54.032659	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
101	error	\N	\N	7	75	2025-03-29 03:46:56.22884	2025-03-29 03:46:56.22884	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
102	error	\N	\N	7	76	2025-03-29 03:46:57.231726	2025-03-29 03:46:57.231726	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
103	error	\N	\N	7	77	2025-03-29 03:46:57.291962	2025-03-29 03:46:57.291962	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
104	error	\N	\N	7	78	2025-03-29 03:46:57.348586	2025-03-29 03:46:57.348586	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
105	error	\N	\N	7	79	2025-03-29 03:46:57.417053	2025-03-29 03:46:57.417053	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
106	error	\N	\N	7	80	2025-03-29 03:46:59.597615	2025-03-29 03:46:59.597615	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
107	error	\N	\N	7	81	2025-03-29 03:47:01.816424	2025-03-29 03:47:01.816424	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
108	error	\N	\N	7	82	2025-03-29 03:47:01.850968	2025-03-29 03:47:01.850968	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
109	error	\N	\N	7	83	2025-03-29 03:47:01.925668	2025-03-29 03:47:01.925668	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
110	error	\N	\N	7	84	2025-03-29 03:47:01.987314	2025-03-29 03:47:01.987314	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
111	error	\N	\N	7	85	2025-03-29 03:47:02.051763	2025-03-29 03:47:02.051763	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
112	error	\N	\N	7	86	2025-03-29 03:47:02.113229	2025-03-29 03:47:02.113229	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
113	error	\N	\N	7	87	2025-03-29 03:47:02.168838	2025-03-29 03:47:02.168838	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
114	error	\N	\N	7	88	2025-03-29 03:47:02.224697	2025-03-29 03:47:02.224697	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
115	error	\N	\N	7	89	2025-03-29 03:47:02.278374	2025-03-29 03:47:02.278374	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
116	error	\N	\N	7	90	2025-03-29 03:47:02.365832	2025-03-29 03:47:02.365832	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
117	error	\N	\N	7	91	2025-03-29 03:47:02.404933	2025-03-29 03:47:02.404933	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
118	error	\N	\N	7	92	2025-03-29 03:47:02.477215	2025-03-29 03:47:02.477215	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
119	error	\N	\N	7	93	2025-03-29 03:47:04.674145	2025-03-29 03:47:04.674145	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
120	error	\N	\N	7	94	2025-03-29 03:47:06.854849	2025-03-29 03:47:06.854849	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
121	error	\N	\N	7	95	2025-03-29 03:47:09.014437	2025-03-29 03:47:09.014437	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
122	error	\N	\N	7	96	2025-03-29 03:47:11.190896	2025-03-29 03:47:11.190896	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
123	error	\N	\N	7	97	2025-03-29 03:47:13.3931	2025-03-29 03:47:13.3931	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
124	error	\N	\N	7	98	2025-03-29 03:47:13.446966	2025-03-29 03:47:13.446966	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
125	error	\N	\N	7	99	2025-03-29 03:47:13.502338	2025-03-29 03:47:13.502338	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
126	error	\N	\N	7	100	2025-03-29 03:47:13.875438	2025-03-29 03:47:13.875438	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
127	error	\N	\N	7	101	2025-03-29 03:47:14.261448	2025-03-29 03:47:14.261448	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
128	error	\N	\N	7	102	2025-03-29 03:47:14.628622	2025-03-29 03:47:14.628622	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
129	error	\N	\N	7	103	2025-03-29 03:47:16.802091	2025-03-29 03:47:16.802091	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
130	error	\N	\N	7	104	2025-03-29 03:47:18.967568	2025-03-29 03:47:18.967568	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
131	error	\N	\N	7	105	2025-03-29 03:47:19.0145	2025-03-29 03:47:19.0145	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
132	error	\N	\N	7	106	2025-03-29 03:47:19.081761	2025-03-29 03:47:19.081761	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
133	error	\N	\N	7	2	2025-03-29 03:56:03.571664	2025-03-29 03:56:03.571664	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
134	error	\N	\N	7	3	2025-03-29 03:56:03.65396	2025-03-29 03:56:03.65396	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
135	error	\N	\N	7	4	2025-03-29 03:56:03.715115	2025-03-29 03:56:03.715115	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
136	error	\N	\N	7	5	2025-03-29 03:56:03.824712	2025-03-29 03:56:03.824712	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
137	error	\N	\N	7	6	2025-03-29 03:56:03.921117	2025-03-29 03:56:03.921117	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
138	error	\N	\N	7	7	2025-03-29 03:56:04.019417	2025-03-29 03:56:04.019417	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
139	error	\N	\N	7	8	2025-03-29 03:56:04.108656	2025-03-29 03:56:04.108656	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
140	error	\N	\N	7	9	2025-03-29 03:56:04.182326	2025-03-29 03:56:04.182326	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
141	error	\N	\N	7	10	2025-03-29 03:56:04.291562	2025-03-29 03:56:04.291562	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
142	error	\N	\N	7	44	2025-03-29 03:56:04.375822	2025-03-29 03:56:04.375822	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
143	error	\N	\N	7	14	2025-03-29 03:56:04.444638	2025-03-29 03:56:04.444638	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
144	error	\N	\N	7	15	2025-03-29 03:56:04.52578	2025-03-29 03:56:04.52578	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
145	error	\N	\N	7	19	2025-03-29 03:56:04.592532	2025-03-29 03:56:04.592532	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
146	error	\N	\N	7	20	2025-03-29 03:56:04.665457	2025-03-29 03:56:04.665457	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
147	error	\N	\N	7	21	2025-03-29 03:56:04.733564	2025-03-29 03:56:04.733564	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
148	error	\N	\N	7	23	2025-03-29 03:56:04.798124	2025-03-29 03:56:04.798124	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
149	error	\N	\N	7	24	2025-03-29 03:56:04.862185	2025-03-29 03:56:04.862185	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
150	error	\N	\N	7	45	2025-03-29 03:56:04.940574	2025-03-29 03:56:04.940574	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
151	success	\N	\N	7	11	2025-03-29 03:56:05.072683	2025-03-29 03:56:05.072683	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
152	error	\N	\N	7	13	2025-03-29 03:56:05.128142	2025-03-29 03:56:05.128142	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
153	error	\N	\N	7	46	2025-03-29 03:56:05.20927	2025-03-29 03:56:05.20927	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
154	error	\N	\N	7	25	2025-03-29 03:56:05.274873	2025-03-29 03:56:05.274873	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
155	error	\N	\N	7	26	2025-03-29 03:56:05.336738	2025-03-29 03:56:05.336738	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
156	error	\N	\N	7	27	2025-03-29 03:56:05.431498	2025-03-29 03:56:05.431498	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
157	error	\N	\N	7	28	2025-03-29 03:56:05.522729	2025-03-29 03:56:05.522729	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
158	error	\N	\N	7	29	2025-03-29 03:56:05.579529	2025-03-29 03:56:05.579529	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
159	error	\N	\N	7	30	2025-03-29 03:56:05.643778	2025-03-29 03:56:05.643778	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
160	error	\N	\N	7	31	2025-03-29 03:56:05.700329	2025-03-29 03:56:05.700329	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
161	error	\N	\N	7	32	2025-03-29 03:56:05.766203	2025-03-29 03:56:05.766203	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
162	error	\N	\N	7	33	2025-03-29 03:56:05.843727	2025-03-29 03:56:05.843727	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
163	error	\N	\N	7	34	2025-03-29 03:56:05.935798	2025-03-29 03:56:05.935798	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
164	error	\N	\N	7	35	2025-03-29 03:56:05.993152	2025-03-29 03:56:05.993152	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
165	error	\N	\N	7	36	2025-03-29 03:56:06.047945	2025-03-29 03:56:06.047945	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
166	error	\N	\N	7	37	2025-03-29 03:56:06.128846	2025-03-29 03:56:06.128846	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
167	error	\N	\N	7	38	2025-03-29 03:56:06.188333	2025-03-29 03:56:06.188333	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
168	error	\N	\N	7	39	2025-03-29 03:56:06.263657	2025-03-29 03:56:06.263657	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
169	error	\N	\N	7	40	2025-03-29 03:56:06.31797	2025-03-29 03:56:06.31797	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
170	error	\N	\N	7	41	2025-03-29 03:56:06.393896	2025-03-29 03:56:06.393896	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
171	error	\N	\N	7	42	2025-03-29 03:56:06.427259	2025-03-29 03:56:06.427259	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
172	error	\N	\N	7	43	2025-03-29 03:56:06.484948	2025-03-29 03:56:06.484948	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
173	error	\N	\N	7	47	2025-03-29 03:56:06.551571	2025-03-29 03:56:06.551571	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
174	error	\N	\N	7	48	2025-03-29 03:56:06.623173	2025-03-29 03:56:06.623173	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
175	error	\N	\N	7	49	2025-03-29 03:56:06.670677	2025-03-29 03:56:06.670677	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
176	error	\N	\N	7	51	2025-03-29 03:56:06.756331	2025-03-29 03:56:06.756331	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
177	error	\N	\N	7	52	2025-03-29 03:56:06.791575	2025-03-29 03:56:06.791575	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
178	error	\N	\N	7	53	2025-03-29 03:56:06.847238	2025-03-29 03:56:06.847238	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
179	error	\N	\N	7	54	2025-03-29 03:56:06.934631	2025-03-29 03:56:06.934631	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
180	error	\N	\N	7	55	2025-03-29 03:56:07.019536	2025-03-29 03:56:07.019536	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
181	error	\N	\N	7	56	2025-03-29 03:56:07.073551	2025-03-29 03:56:07.073551	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
182	error	\N	\N	7	57	2025-03-29 03:56:07.130542	2025-03-29 03:56:07.130542	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
183	error	\N	\N	7	58	2025-03-29 03:56:07.198559	2025-03-29 03:56:07.198559	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
184	error	\N	\N	7	59	2025-03-29 03:56:07.291506	2025-03-29 03:56:07.291506	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
185	error	\N	\N	7	60	2025-03-29 03:56:07.344405	2025-03-29 03:56:07.344405	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
186	error	\N	\N	7	61	2025-03-29 03:56:07.415401	2025-03-29 03:56:07.415401	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
187	error	\N	\N	7	62	2025-03-29 03:56:07.47513	2025-03-29 03:56:07.47513	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
188	error	\N	\N	7	63	2025-03-29 03:56:07.531476	2025-03-29 03:56:07.531476	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
189	error	\N	\N	7	64	2025-03-29 03:56:07.563879	2025-03-29 03:56:07.563879	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
190	error	\N	\N	7	65	2025-03-29 03:56:07.61986	2025-03-29 03:56:07.61986	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
191	error	\N	\N	7	66	2025-03-29 03:56:07.689126	2025-03-29 03:56:07.689126	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
192	error	\N	\N	7	67	2025-03-29 03:56:07.769857	2025-03-29 03:56:07.769857	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
193	error	\N	\N	7	68	2025-03-29 03:56:07.853424	2025-03-29 03:56:07.853424	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
194	error	\N	\N	7	69	2025-03-29 03:56:07.88622	2025-03-29 03:56:07.88622	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
195	error	\N	\N	7	70	2025-03-29 03:56:07.92065	2025-03-29 03:56:07.92065	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
196	error	\N	\N	7	71	2025-03-29 03:56:07.955979	2025-03-29 03:56:07.955979	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
197	error	\N	\N	7	72	2025-03-29 03:56:07.990449	2025-03-29 03:56:07.990449	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
198	error	\N	\N	7	73	2025-03-29 03:56:08.046702	2025-03-29 03:56:08.046702	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
199	error	\N	\N	7	74	2025-03-29 03:56:08.112593	2025-03-29 03:56:08.112593	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
200	error	\N	\N	7	107	2025-03-29 03:56:08.163237	2025-03-29 03:56:08.163237	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
201	error	\N	\N	7	108	2025-03-29 03:56:08.221728	2025-03-29 03:56:08.221728	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
202	error	\N	\N	7	109	2025-03-29 03:56:08.320421	2025-03-29 03:56:08.320421	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
203	error	\N	\N	7	110	2025-03-29 03:56:08.362066	2025-03-29 03:56:08.362066	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
204	error	\N	\N	7	111	2025-03-29 03:56:08.44433	2025-03-29 03:56:08.44433	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
205	error	\N	\N	7	112	2025-03-29 03:56:08.496964	2025-03-29 03:56:08.496964	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
206	error	\N	\N	7	113	2025-03-29 03:56:08.584339	2025-03-29 03:56:08.584339	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
207	error	\N	\N	7	114	2025-03-29 03:56:08.644798	2025-03-29 03:56:08.644798	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
208	error	\N	\N	7	115	2025-03-29 03:56:08.699048	2025-03-29 03:56:08.699048	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
209	error	\N	\N	7	116	2025-03-29 03:56:09.10275	2025-03-29 03:56:09.10275	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
210	error	\N	\N	7	117	2025-03-29 03:56:09.163883	2025-03-29 03:56:09.163883	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
211	error	\N	\N	7	118	2025-03-29 03:56:09.234676	2025-03-29 03:56:09.234676	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
212	error	\N	\N	7	119	2025-03-29 03:56:09.293213	2025-03-29 03:56:09.293213	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
213	error	\N	\N	7	120	2025-03-29 03:56:09.347199	2025-03-29 03:56:09.347199	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
214	error	\N	\N	7	121	2025-03-29 03:56:09.711873	2025-03-29 03:56:09.711873	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
215	error	\N	\N	7	122	2025-03-29 03:56:09.817827	2025-03-29 03:56:09.817827	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
216	error	\N	\N	7	123	2025-03-29 03:56:10.764234	2025-03-29 03:56:10.764234	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
217	error	\N	\N	7	124	2025-03-29 03:56:10.797417	2025-03-29 03:56:10.797417	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
218	error	\N	\N	7	125	2025-03-29 03:56:11.171157	2025-03-29 03:56:11.171157	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
219	error	\N	\N	7	126	2025-03-29 03:56:11.251222	2025-03-29 03:56:11.251222	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
220	error	\N	\N	7	127	2025-03-29 03:56:11.653978	2025-03-29 03:56:11.653978	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
221	error	\N	\N	7	128	2025-03-29 03:56:12.007577	2025-03-29 03:56:12.007577	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
222	error	\N	\N	7	129	2025-03-29 03:56:12.087696	2025-03-29 03:56:12.087696	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
223	error	\N	\N	7	130	2025-03-29 03:56:12.148862	2025-03-29 03:56:12.148862	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
224	error	\N	\N	7	131	2025-03-29 03:56:12.235703	2025-03-29 03:56:12.235703	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
225	error	\N	\N	7	132	2025-03-29 03:56:13.188167	2025-03-29 03:56:13.188167	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
226	error	\N	\N	7	133	2025-03-29 03:56:13.244378	2025-03-29 03:56:13.244378	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
227	error	\N	\N	7	134	2025-03-29 03:56:13.299802	2025-03-29 03:56:13.299802	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
228	error	\N	\N	7	135	2025-03-29 03:56:13.355423	2025-03-29 03:56:13.355423	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
229	error	\N	\N	7	136	2025-03-29 03:56:13.754003	2025-03-29 03:56:13.754003	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
230	error	\N	\N	7	137	2025-03-29 03:56:13.787517	2025-03-29 03:56:13.787517	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
231	error	\N	\N	7	138	2025-03-29 03:56:13.885151	2025-03-29 03:56:13.885151	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
232	error	\N	\N	7	139	2025-03-29 03:56:13.96714	2025-03-29 03:56:13.96714	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
233	error	\N	\N	7	101	2025-03-29 03:56:44.083711	2025-03-29 03:56:44.083711	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
234	error	\N	\N	7	102	2025-03-29 03:56:44.172764	2025-03-29 03:56:44.172764	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
235	error	\N	\N	7	103	2025-03-29 03:56:44.237719	2025-03-29 03:56:44.237719	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
236	error	\N	\N	7	104	2025-03-29 03:56:44.300037	2025-03-29 03:56:44.300037	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
237	error	\N	\N	7	105	2025-03-29 03:56:44.359522	2025-03-29 03:56:44.359522	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
238	error	\N	\N	7	106	2025-03-29 03:56:44.431215	2025-03-29 03:56:44.431215	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
239	error	\N	\N	7	107	2025-03-29 03:56:44.472485	2025-03-29 03:56:44.472485	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
240	error	\N	\N	7	108	2025-03-29 03:56:44.544514	2025-03-29 03:56:44.544514	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
241	error	\N	\N	7	109	2025-03-29 03:56:44.612822	2025-03-29 03:56:44.612822	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
242	error	\N	\N	7	110	2025-03-29 03:56:44.645149	2025-03-29 03:56:44.645149	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
243	error	\N	\N	7	111	2025-03-29 03:56:44.700539	2025-03-29 03:56:44.700539	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
244	error	\N	\N	7	112	2025-03-29 03:56:45.046876	2025-03-29 03:56:45.046876	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
245	error	\N	\N	7	113	2025-03-29 03:56:45.08267	2025-03-29 03:56:45.08267	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
246	error	\N	\N	7	114	2025-03-29 03:56:45.162373	2025-03-29 03:56:45.162373	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
247	error	\N	\N	7	115	2025-03-29 03:56:45.251283	2025-03-29 03:56:45.251283	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
248	error	\N	\N	7	116	2025-03-29 03:56:45.316212	2025-03-29 03:56:45.316212	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
249	error	\N	\N	7	117	2025-03-29 03:56:45.374875	2025-03-29 03:56:45.374875	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
250	error	\N	\N	7	118	2025-03-29 03:56:45.756019	2025-03-29 03:56:45.756019	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
251	error	\N	\N	7	119	2025-03-29 03:56:45.842301	2025-03-29 03:56:45.842301	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
252	error	\N	\N	7	121	2025-03-29 03:56:46.799396	2025-03-29 03:56:46.799396	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
253	error	\N	\N	7	122	2025-03-29 03:56:46.86451	2025-03-29 03:56:46.86451	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
254	error	\N	\N	7	123	2025-03-29 03:56:46.923198	2025-03-29 03:56:46.923198	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
255	error	\N	\N	7	124	2025-03-29 03:56:47.012546	2025-03-29 03:56:47.012546	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
256	error	\N	\N	7	125	2025-03-29 03:56:47.06719	2025-03-29 03:56:47.06719	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
257	error	\N	\N	7	126	2025-03-29 03:56:47.122539	2025-03-29 03:56:47.122539	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
258	error	\N	\N	7	127	2025-03-29 03:56:47.179374	2025-03-29 03:56:47.179374	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
259	error	\N	\N	7	128	2025-03-29 03:56:47.254983	2025-03-29 03:56:47.254983	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
260	error	\N	\N	7	129	2025-03-29 03:56:47.316892	2025-03-29 03:56:47.316892	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
261	error	\N	\N	7	130	2025-03-29 03:56:47.352893	2025-03-29 03:56:47.352893	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
262	error	\N	\N	7	131	2025-03-29 03:56:47.417374	2025-03-29 03:56:47.417374	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
263	error	\N	\N	7	132	2025-03-29 03:56:48.37941	2025-03-29 03:56:48.37941	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
264	error	\N	\N	7	133	2025-03-29 03:56:48.432383	2025-03-29 03:56:48.432383	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
265	error	\N	\N	7	134	2025-03-29 03:56:48.463413	2025-03-29 03:56:48.463413	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
266	error	\N	\N	7	135	2025-03-29 03:56:48.520361	2025-03-29 03:56:48.520361	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
267	error	\N	\N	7	136	2025-03-29 03:56:48.552832	2025-03-29 03:56:48.552832	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
268	error	\N	\N	7	137	2025-03-29 03:56:48.91379	2025-03-29 03:56:48.91379	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
269	error	\N	\N	7	138	2025-03-29 03:56:48.948223	2025-03-29 03:56:48.948223	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
270	error	\N	\N	7	139	2025-03-29 03:56:48.974221	2025-03-29 03:56:48.974221	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
271	error	\N	\N	7	150	2025-03-29 03:56:49.340997	2025-03-29 03:56:49.340997	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
272	error	\N	\N	7	151	2025-03-29 03:56:49.432684	2025-03-29 03:56:49.432684	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
273	error	\N	\N	7	152	2025-03-29 03:56:49.466023	2025-03-29 03:56:49.466023	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
274	error	\N	\N	7	153	2025-03-29 03:56:49.496348	2025-03-29 03:56:49.496348	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
275	error	\N	\N	7	154	2025-03-29 03:56:49.834528	2025-03-29 03:56:49.834528	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
276	error	\N	\N	7	155	2025-03-29 03:56:49.864275	2025-03-29 03:56:49.864275	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
277	error	\N	\N	7	156	2025-03-29 03:56:50.255139	2025-03-29 03:56:50.255139	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
278	error	\N	\N	7	157	2025-03-29 03:56:50.285497	2025-03-29 03:56:50.285497	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
279	error	\N	\N	7	158	2025-03-29 03:56:50.317574	2025-03-29 03:56:50.317574	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
280	error	\N	\N	7	159	2025-03-29 03:56:50.374171	2025-03-29 03:56:50.374171	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
281	error	\N	\N	7	160	2025-03-29 03:56:52.511314	2025-03-29 03:56:52.511314	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
282	error	\N	\N	7	161	2025-03-29 03:56:52.576716	2025-03-29 03:56:52.576716	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
283	error	\N	\N	7	162	2025-03-29 03:56:52.610424	2025-03-29 03:56:52.610424	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
284	error	\N	\N	7	163	2025-03-29 03:56:52.667554	2025-03-29 03:56:52.667554	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
285	error	\N	\N	7	164	2025-03-29 03:56:54.807382	2025-03-29 03:56:54.807382	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
286	error	\N	\N	7	165	2025-03-29 03:56:54.871156	2025-03-29 03:56:54.871156	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
287	error	\N	\N	7	166	2025-03-29 03:56:55.254146	2025-03-29 03:56:55.254146	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
288	error	\N	\N	7	167	2025-03-29 03:56:55.316732	2025-03-29 03:56:55.316732	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
289	error	\N	\N	7	168	2025-03-29 03:56:55.386731	2025-03-29 03:56:55.386731	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
290	error	\N	\N	7	169	2025-03-29 03:56:55.448102	2025-03-29 03:56:55.448102	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
291	error	\N	\N	7	170	2025-03-29 03:56:55.81042	2025-03-29 03:56:55.81042	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
292	error	\N	\N	7	171	2025-03-29 03:56:56.151442	2025-03-29 03:56:56.151442	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
293	error	\N	\N	7	172	2025-03-29 03:56:56.181711	2025-03-29 03:56:56.181711	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
294	error	\N	\N	7	173	2025-03-29 03:56:56.237817	2025-03-29 03:56:56.237817	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
295	error	\N	\N	7	174	2025-03-29 03:56:56.297759	2025-03-29 03:56:56.297759	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
296	error	\N	\N	7	1	2025-03-29 03:56:56.352553	2025-03-29 03:56:56.352553	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
297	error	\N	\N	7	50	2025-03-29 03:56:56.43732	2025-03-29 03:56:56.43732	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
298	error	\N	\N	7	75	2025-03-29 03:56:56.470814	2025-03-29 03:56:56.470814	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
299	error	\N	\N	7	93	2025-03-29 03:56:56.524668	2025-03-29 03:56:56.524668	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
300	error	\N	\N	7	2	2025-03-29 03:56:56.88418	2025-03-29 03:56:56.88418	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
301	error	\N	\N	7	120	2025-03-29 03:56:56.945604	2025-03-29 03:56:56.945604	f	\N	8196a156-67eb-4f2f-b387-c5444a6deb59
\.


--
-- Data for Name: email_records; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.email_records (id, email, company, website, industry_id, created_at, updated_at, bounces_count, active) FROM stdin;
3	test2@example.com	Empresa 2	https://empresa2.cl	1	2025-03-12 01:40:34.571603	2025-03-12 01:40:34.571603	2	t
4	test3@example.com	Empresa 3	https://empresa3.cl	1	2025-03-12 01:40:34.578359	2025-03-12 01:40:34.578359	2	t
5	test4@example.com	Empresa 4	https://empresa4.cl	1	2025-03-12 01:40:34.585996	2025-03-12 01:40:34.585996	2	t
6	test5@example.com	Empresa 5	https://empresa5.cl	1	2025-03-12 01:40:34.595435	2025-03-12 01:40:34.595435	2	t
7	test6@example.com	Empresa 6	https://empresa6.cl	1	2025-03-12 01:40:34.602833	2025-03-12 01:40:34.602833	2	t
8	test7@example.com	Empresa 7	https://empresa7.cl	1	2025-03-12 01:40:34.609338	2025-03-12 01:40:34.609338	2	t
9	test8@example.com	Empresa 8	https://empresa8.cl	1	2025-03-12 01:40:34.615828	2025-03-12 01:40:34.615828	2	t
10	test9@example.com	Empresa 9	https://empresa9.cl	1	2025-03-12 01:40:34.623479	2025-03-12 01:40:34.623479	2	t
44	test_user_19@example.com	\N	\N	1	2025-03-29 03:45:09.007058	2025-03-29 03:45:09.007058	2	t
14	enoch@rice.test	\N	\N	1	2025-03-26 03:19:07.91397	2025-03-26 03:19:07.91397	2	t
12	tu-email-verificado@dominio.com	\N	\N	3	2025-03-22 03:42:35.533143	2025-03-22 03:42:35.533143	0	t
15	yang@beier.example	\N	\N	1	2025-03-26 03:19:07.917117	2025-03-26 03:19:07.917117	2	t
19	johana@green.test	\N	\N	1	2025-03-26 03:25:30.271201	2025-03-26 03:25:30.271201	2	t
20	vanetta.bechtelar@dietrich.test	\N	\N	1	2025-03-26 03:25:30.275788	2025-03-26 03:25:30.275788	2	t
16	demetrius_denesik@waters.example	\N	\N	38	2025-03-26 03:19:27.821273	2025-03-26 03:19:27.821273	0	t
17	warner.paucek@blick.test	\N	\N	39	2025-03-26 03:19:27.835738	2025-03-26 03:19:27.835738	0	t
18	rigoberto.bernier@bednar.example	\N	\N	40	2025-03-26 03:19:27.848837	2025-03-26 03:19:27.848837	0	t
21	merissa_kohler@fahey-mueller.example	\N	\N	1	2025-03-26 03:25:30.279162	2025-03-26 03:25:30.279162	2	t
23	bounce@example.com	\N	\N	1	2025-03-27 02:25:51.658436	2025-03-27 02:25:51.658436	2	t
24	cliente1@ejemplo.com	\N	\N	1	2025-03-27 02:25:51.66549	2025-03-27 02:25:51.66549	2	t
22	arthur@veum.example	\N	\N	41	2025-03-26 03:27:25.592308	2025-03-26 03:27:25.592308	0	t
45	test_user_20@example.com	\N	\N	1	2025-03-29 03:45:09.0123	2025-03-29 03:45:09.0123	2	t
13	jenine_schuppe@ziemann-gleichner.example	\N	\N	1	2025-03-26 03:19:07.909807	2025-03-26 03:19:07.909807	2	t
46	test_user_21@example.com	\N	\N	1	2025-03-29 03:45:09.01694	2025-03-29 03:45:09.01694	2	t
25	test_user_0@example.com	\N	\N	1	2025-03-29 03:45:08.926068	2025-03-29 03:45:08.926068	2	t
26	test_user_1@example.com	\N	\N	1	2025-03-29 03:45:08.931756	2025-03-29 03:45:08.931756	2	t
27	test_user_2@example.com	\N	\N	1	2025-03-29 03:45:08.936501	2025-03-29 03:45:08.936501	2	t
28	test_user_3@example.com	\N	\N	1	2025-03-29 03:45:08.940402	2025-03-29 03:45:08.940402	2	t
29	test_user_4@example.com	\N	\N	1	2025-03-29 03:45:08.944046	2025-03-29 03:45:08.944046	2	t
30	test_user_5@example.com	\N	\N	1	2025-03-29 03:45:08.948379	2025-03-29 03:45:08.948379	2	t
31	test_user_6@example.com	\N	\N	1	2025-03-29 03:45:08.952245	2025-03-29 03:45:08.952245	2	t
32	test_user_7@example.com	\N	\N	1	2025-03-29 03:45:08.95596	2025-03-29 03:45:08.95596	2	t
33	test_user_8@example.com	\N	\N	1	2025-03-29 03:45:08.96038	2025-03-29 03:45:08.96038	2	t
34	test_user_9@example.com	\N	\N	1	2025-03-29 03:45:08.965011	2025-03-29 03:45:08.965011	2	t
35	test_user_10@example.com	\N	\N	1	2025-03-29 03:45:08.969514	2025-03-29 03:45:08.969514	2	t
36	test_user_11@example.com	\N	\N	1	2025-03-29 03:45:08.973345	2025-03-29 03:45:08.973345	2	t
37	test_user_12@example.com	\N	\N	1	2025-03-29 03:45:08.977209	2025-03-29 03:45:08.977209	2	t
38	test_user_13@example.com	\N	\N	1	2025-03-29 03:45:08.981779	2025-03-29 03:45:08.981779	2	t
39	test_user_14@example.com	\N	\N	1	2025-03-29 03:45:08.98542	2025-03-29 03:45:08.98542	2	t
40	test_user_15@example.com	\N	\N	1	2025-03-29 03:45:08.989381	2025-03-29 03:45:08.989381	2	t
41	test_user_16@example.com	\N	\N	1	2025-03-29 03:45:08.994519	2025-03-29 03:45:08.994519	2	t
42	test_user_17@example.com	\N	\N	1	2025-03-29 03:45:08.999139	2025-03-29 03:45:08.999139	2	t
43	test_user_18@example.com	\N	\N	1	2025-03-29 03:45:09.002961	2025-03-29 03:45:09.002961	2	t
47	test_user_22@example.com	\N	\N	1	2025-03-29 03:45:09.021697	2025-03-29 03:45:09.021697	2	t
48	test_user_23@example.com	\N	\N	1	2025-03-29 03:45:09.026015	2025-03-29 03:45:09.026015	2	t
49	test_user_24@example.com	\N	\N	1	2025-03-29 03:45:09.030766	2025-03-29 03:45:09.030766	2	t
51	test_user_26@example.com	\N	\N	1	2025-03-29 03:45:09.039735	2025-03-29 03:45:09.039735	2	t
52	test_user_27@example.com	\N	\N	1	2025-03-29 03:45:09.043807	2025-03-29 03:45:09.043807	2	t
53	test_user_28@example.com	\N	\N	1	2025-03-29 03:45:09.047826	2025-03-29 03:45:09.047826	2	t
54	test_user_29@example.com	\N	\N	1	2025-03-29 03:45:09.051665	2025-03-29 03:45:09.051665	2	t
55	test_user_30@example.com	\N	\N	1	2025-03-29 03:45:09.055573	2025-03-29 03:45:09.055573	2	t
56	test_user_31@example.com	\N	\N	1	2025-03-29 03:45:09.059628	2025-03-29 03:45:09.059628	2	t
57	test_user_32@example.com	\N	\N	1	2025-03-29 03:45:09.063307	2025-03-29 03:45:09.063307	2	t
58	test_user_33@example.com	\N	\N	1	2025-03-29 03:45:09.067152	2025-03-29 03:45:09.067152	2	t
59	test_user_34@example.com	\N	\N	1	2025-03-29 03:45:09.070889	2025-03-29 03:45:09.070889	2	t
60	test_user_35@example.com	\N	\N	1	2025-03-29 03:45:09.074738	2025-03-29 03:45:09.074738	2	t
61	test_user_36@example.com	\N	\N	1	2025-03-29 03:45:09.079052	2025-03-29 03:45:09.079052	2	t
62	test_user_37@example.com	\N	\N	1	2025-03-29 03:45:09.083156	2025-03-29 03:45:09.083156	2	t
63	test_user_38@example.com	\N	\N	1	2025-03-29 03:45:09.086896	2025-03-29 03:45:09.086896	2	t
64	test_user_39@example.com	\N	\N	1	2025-03-29 03:45:09.090605	2025-03-29 03:45:09.090605	2	t
65	test_user_40@example.com	\N	\N	1	2025-03-29 03:45:09.094097	2025-03-29 03:45:09.094097	2	t
66	test_user_41@example.com	\N	\N	1	2025-03-29 03:45:09.097421	2025-03-29 03:45:09.097421	2	t
67	test_user_42@example.com	\N	\N	1	2025-03-29 03:45:09.100727	2025-03-29 03:45:09.100727	2	t
68	test_user_43@example.com	\N	\N	1	2025-03-29 03:45:09.103882	2025-03-29 03:45:09.103882	2	t
69	test_user_44@example.com	\N	\N	1	2025-03-29 03:45:09.107215	2025-03-29 03:45:09.107215	2	t
70	test_user_45@example.com	\N	\N	1	2025-03-29 03:45:09.110591	2025-03-29 03:45:09.110591	2	t
71	test_user_46@example.com	\N	\N	1	2025-03-29 03:45:09.113688	2025-03-29 03:45:09.113688	2	t
72	test_user_47@example.com	\N	\N	1	2025-03-29 03:45:09.117363	2025-03-29 03:45:09.117363	2	t
73	test_user_48@example.com	\N	\N	1	2025-03-29 03:45:09.120627	2025-03-29 03:45:09.120627	2	t
74	test_user_49@example.com	\N	\N	1	2025-03-29 03:45:09.123941	2025-03-29 03:45:09.123941	2	t
11	info@maileraction.com	ACME	https://acme.com	1	2025-03-19 04:55:23.24023	2025-03-29 03:12:07.503757	4	f
140	test_user_115@example.com	\N	\N	1	2025-03-29 03:45:09.320489	2025-03-29 03:45:09.320489	0	t
141	test_user_116@example.com	\N	\N	1	2025-03-29 03:45:09.323178	2025-03-29 03:45:09.323178	0	t
142	test_user_117@example.com	\N	\N	1	2025-03-29 03:45:09.325793	2025-03-29 03:45:09.325793	0	t
143	test_user_118@example.com	\N	\N	1	2025-03-29 03:45:09.328472	2025-03-29 03:45:09.328472	0	t
144	test_user_119@example.com	\N	\N	1	2025-03-29 03:45:09.331165	2025-03-29 03:45:09.331165	0	t
145	test_user_120@example.com	\N	\N	1	2025-03-29 03:45:09.546577	2025-03-29 03:45:09.546577	0	t
146	test_user_121@example.com	\N	\N	1	2025-03-29 03:45:09.55061	2025-03-29 03:45:09.55061	0	t
147	test_user_122@example.com	\N	\N	1	2025-03-29 03:45:09.554028	2025-03-29 03:45:09.554028	0	t
148	test_user_123@example.com	\N	\N	1	2025-03-29 03:45:09.557407	2025-03-29 03:45:09.557407	0	t
149	test_user_124@example.com	\N	\N	1	2025-03-29 03:45:09.560713	2025-03-29 03:45:09.560713	0	t
76	test_user_51@example.com	\N	\N	1	2025-03-29 03:45:09.130965	2025-03-29 03:45:09.130965	1	t
77	test_user_52@example.com	\N	\N	1	2025-03-29 03:45:09.134335	2025-03-29 03:45:09.134335	1	t
78	test_user_53@example.com	\N	\N	1	2025-03-29 03:45:09.138497	2025-03-29 03:45:09.138497	1	t
79	test_user_54@example.com	\N	\N	1	2025-03-29 03:45:09.141686	2025-03-29 03:45:09.141686	1	t
80	test_user_55@example.com	\N	\N	1	2025-03-29 03:45:09.144873	2025-03-29 03:45:09.144873	1	t
81	test_user_56@example.com	\N	\N	1	2025-03-29 03:45:09.147735	2025-03-29 03:45:09.147735	1	t
82	test_user_57@example.com	\N	\N	1	2025-03-29 03:45:09.150491	2025-03-29 03:45:09.150491	1	t
83	test_user_58@example.com	\N	\N	1	2025-03-29 03:45:09.153243	2025-03-29 03:45:09.153243	1	t
84	test_user_59@example.com	\N	\N	1	2025-03-29 03:45:09.156057	2025-03-29 03:45:09.156057	1	t
85	test_user_60@example.com	\N	\N	1	2025-03-29 03:45:09.159107	2025-03-29 03:45:09.159107	1	t
86	test_user_61@example.com	\N	\N	1	2025-03-29 03:45:09.162331	2025-03-29 03:45:09.162331	1	t
87	test_user_62@example.com	\N	\N	1	2025-03-29 03:45:09.165754	2025-03-29 03:45:09.165754	1	t
88	test_user_63@example.com	\N	\N	1	2025-03-29 03:45:09.168978	2025-03-29 03:45:09.168978	1	t
89	test_user_64@example.com	\N	\N	1	2025-03-29 03:45:09.171743	2025-03-29 03:45:09.171743	1	t
90	test_user_65@example.com	\N	\N	1	2025-03-29 03:45:09.174563	2025-03-29 03:45:09.174563	1	t
91	test_user_66@example.com	\N	\N	1	2025-03-29 03:45:09.177563	2025-03-29 03:45:09.177563	1	t
92	test_user_67@example.com	\N	\N	1	2025-03-29 03:45:09.181335	2025-03-29 03:45:09.181335	1	t
94	test_user_69@example.com	\N	\N	1	2025-03-29 03:45:09.187362	2025-03-29 03:45:09.187362	1	t
95	test_user_70@example.com	\N	\N	1	2025-03-29 03:45:09.190296	2025-03-29 03:45:09.190296	1	t
96	test_user_71@example.com	\N	\N	1	2025-03-29 03:45:09.19308	2025-03-29 03:45:09.19308	1	t
97	test_user_72@example.com	\N	\N	1	2025-03-29 03:45:09.196042	2025-03-29 03:45:09.196042	1	t
98	test_user_73@example.com	\N	\N	1	2025-03-29 03:45:09.198817	2025-03-29 03:45:09.198817	1	t
99	test_user_74@example.com	\N	\N	1	2025-03-29 03:45:09.201634	2025-03-29 03:45:09.201634	1	t
100	test_user_75@example.com	\N	\N	1	2025-03-29 03:45:09.204433	2025-03-29 03:45:09.204433	1	t
102	test_user_77@example.com	\N	\N	1	2025-03-29 03:45:09.21061	2025-03-29 03:45:09.21061	2	t
103	test_user_78@example.com	\N	\N	1	2025-03-29 03:45:09.213522	2025-03-29 03:45:09.213522	2	t
104	test_user_79@example.com	\N	\N	1	2025-03-29 03:45:09.216488	2025-03-29 03:45:09.216488	2	t
105	test_user_80@example.com	\N	\N	1	2025-03-29 03:45:09.219197	2025-03-29 03:45:09.219197	2	t
106	test_user_81@example.com	\N	\N	1	2025-03-29 03:45:09.221875	2025-03-29 03:45:09.221875	2	t
107	test_user_82@example.com	\N	\N	1	2025-03-29 03:45:09.224563	2025-03-29 03:45:09.224563	2	t
108	test_user_83@example.com	\N	\N	1	2025-03-29 03:45:09.22725	2025-03-29 03:45:09.22725	2	t
109	test_user_84@example.com	\N	\N	1	2025-03-29 03:45:09.229888	2025-03-29 03:45:09.229888	2	t
110	test_user_85@example.com	\N	\N	1	2025-03-29 03:45:09.232644	2025-03-29 03:45:09.232644	2	t
111	test_user_86@example.com	\N	\N	1	2025-03-29 03:45:09.235684	2025-03-29 03:45:09.235684	2	t
112	test_user_87@example.com	\N	\N	1	2025-03-29 03:45:09.238776	2025-03-29 03:45:09.238776	2	t
113	test_user_88@example.com	\N	\N	1	2025-03-29 03:45:09.241522	2025-03-29 03:45:09.241522	2	t
114	test_user_89@example.com	\N	\N	1	2025-03-29 03:45:09.244411	2025-03-29 03:45:09.244411	2	t
115	test_user_90@example.com	\N	\N	1	2025-03-29 03:45:09.247196	2025-03-29 03:45:09.247196	2	t
116	test_user_91@example.com	\N	\N	1	2025-03-29 03:45:09.2499	2025-03-29 03:45:09.2499	2	t
117	test_user_92@example.com	\N	\N	1	2025-03-29 03:45:09.252898	2025-03-29 03:45:09.252898	2	t
118	test_user_93@example.com	\N	\N	1	2025-03-29 03:45:09.255997	2025-03-29 03:45:09.255997	2	t
119	test_user_94@example.com	\N	\N	1	2025-03-29 03:45:09.259003	2025-03-29 03:45:09.259003	2	t
121	test_user_96@example.com	\N	\N	1	2025-03-29 03:45:09.26469	2025-03-29 03:45:09.26469	2	t
122	test_user_97@example.com	\N	\N	1	2025-03-29 03:45:09.267774	2025-03-29 03:45:09.267774	2	t
123	test_user_98@example.com	\N	\N	1	2025-03-29 03:45:09.270771	2025-03-29 03:45:09.270771	2	t
124	test_user_99@example.com	\N	\N	1	2025-03-29 03:45:09.273674	2025-03-29 03:45:09.273674	2	t
125	test_user_100@example.com	\N	\N	1	2025-03-29 03:45:09.276869	2025-03-29 03:45:09.276869	2	t
126	test_user_101@example.com	\N	\N	1	2025-03-29 03:45:09.279774	2025-03-29 03:45:09.279774	2	t
127	test_user_102@example.com	\N	\N	1	2025-03-29 03:45:09.282908	2025-03-29 03:45:09.282908	2	t
128	test_user_103@example.com	\N	\N	1	2025-03-29 03:45:09.285938	2025-03-29 03:45:09.285938	2	t
129	test_user_104@example.com	\N	\N	1	2025-03-29 03:45:09.288962	2025-03-29 03:45:09.288962	2	t
130	test_user_105@example.com	\N	\N	1	2025-03-29 03:45:09.291821	2025-03-29 03:45:09.291821	2	t
131	test_user_106@example.com	\N	\N	1	2025-03-29 03:45:09.294594	2025-03-29 03:45:09.294594	2	t
132	test_user_107@example.com	\N	\N	1	2025-03-29 03:45:09.297341	2025-03-29 03:45:09.297341	2	t
133	test_user_108@example.com	\N	\N	1	2025-03-29 03:45:09.300177	2025-03-29 03:45:09.300177	2	t
134	test_user_109@example.com	\N	\N	1	2025-03-29 03:45:09.302877	2025-03-29 03:45:09.302877	2	t
135	test_user_110@example.com	\N	\N	1	2025-03-29 03:45:09.305564	2025-03-29 03:45:09.305564	2	t
136	test_user_111@example.com	\N	\N	1	2025-03-29 03:45:09.308352	2025-03-29 03:45:09.308352	2	t
137	test_user_112@example.com	\N	\N	1	2025-03-29 03:45:09.311796	2025-03-29 03:45:09.311796	2	t
138	test_user_113@example.com	\N	\N	1	2025-03-29 03:45:09.314931	2025-03-29 03:45:09.314931	2	t
139	test_user_114@example.com	\N	\N	1	2025-03-29 03:45:09.317645	2025-03-29 03:45:09.317645	2	t
101	test_user_76@example.com	\N	\N	1	2025-03-29 03:45:09.20745	2025-03-29 03:45:09.20745	2	t
150	test_user_125@example.com	\N	\N	1	2025-03-29 03:45:09.563873	2025-03-29 03:45:09.563873	1	t
151	test_user_126@example.com	\N	\N	1	2025-03-29 03:45:09.570821	2025-03-29 03:45:09.570821	1	t
152	test_user_127@example.com	\N	\N	1	2025-03-29 03:45:09.574503	2025-03-29 03:45:09.574503	1	t
153	test_user_128@example.com	\N	\N	1	2025-03-29 03:45:09.578216	2025-03-29 03:45:09.578216	1	t
154	test_user_129@example.com	\N	\N	1	2025-03-29 03:45:09.582197	2025-03-29 03:45:09.582197	1	t
155	test_user_130@example.com	\N	\N	1	2025-03-29 03:45:09.585503	2025-03-29 03:45:09.585503	1	t
156	test_user_131@example.com	\N	\N	1	2025-03-29 03:45:09.588848	2025-03-29 03:45:09.588848	1	t
157	test_user_132@example.com	\N	\N	1	2025-03-29 03:45:09.592281	2025-03-29 03:45:09.592281	1	t
158	test_user_133@example.com	\N	\N	1	2025-03-29 03:45:09.595516	2025-03-29 03:45:09.595516	1	t
159	test_user_134@example.com	\N	\N	1	2025-03-29 03:45:09.598797	2025-03-29 03:45:09.598797	1	t
160	test_user_135@example.com	\N	\N	1	2025-03-29 03:45:09.602496	2025-03-29 03:45:09.602496	1	t
161	test_user_136@example.com	\N	\N	1	2025-03-29 03:45:09.605711	2025-03-29 03:45:09.605711	1	t
162	test_user_137@example.com	\N	\N	1	2025-03-29 03:45:09.608863	2025-03-29 03:45:09.608863	1	t
163	test_user_138@example.com	\N	\N	1	2025-03-29 03:45:09.612686	2025-03-29 03:45:09.612686	1	t
164	test_user_139@example.com	\N	\N	1	2025-03-29 03:45:09.616101	2025-03-29 03:45:09.616101	1	t
165	test_user_140@example.com	\N	\N	1	2025-03-29 03:45:09.619523	2025-03-29 03:45:09.619523	1	t
166	test_user_141@example.com	\N	\N	1	2025-03-29 03:45:09.622518	2025-03-29 03:45:09.622518	1	t
167	test_user_142@example.com	\N	\N	1	2025-03-29 03:45:09.625463	2025-03-29 03:45:09.625463	1	t
168	test_user_143@example.com	\N	\N	1	2025-03-29 03:45:09.62867	2025-03-29 03:45:09.62867	1	t
169	test_user_144@example.com	\N	\N	1	2025-03-29 03:45:09.631505	2025-03-29 03:45:09.631505	1	t
170	test_user_145@example.com	\N	\N	1	2025-03-29 03:45:09.63466	2025-03-29 03:45:09.63466	1	t
171	test_user_146@example.com	\N	\N	1	2025-03-29 03:45:09.638054	2025-03-29 03:45:09.638054	1	t
172	test_user_147@example.com	\N	\N	1	2025-03-29 03:45:09.643336	2025-03-29 03:45:09.643336	1	t
173	test_user_148@example.com	\N	\N	1	2025-03-29 03:45:09.64669	2025-03-29 03:45:09.64669	1	t
174	test_user_149@example.com	\N	\N	1	2025-03-29 03:45:09.649692	2025-03-29 03:45:09.649692	1	t
1	test0@example.com	Empresa 0	https://empresa0.cl	1	2025-03-12 01:40:34.515005	2025-03-12 01:40:34.515005	2	t
50	test_user_25@example.com	\N	\N	1	2025-03-29 03:45:09.035309	2025-03-29 03:45:09.035309	2	t
75	test_user_50@example.com	\N	\N	1	2025-03-29 03:45:09.12737	2025-03-29 03:45:09.12737	2	t
93	test_user_68@example.com	\N	\N	1	2025-03-29 03:45:09.184406	2025-03-29 03:45:09.184406	2	t
2	test1@example.com	Empresa 1	https://empresa1.cl	1	2025-03-12 01:40:34.563788	2025-03-29 03:56:56.896919	3	f
120	test_user_95@example.com	\N	\N	1	2025-03-29 03:45:09.261746	2025-03-29 03:45:09.261746	2	t
\.


--
-- Data for Name: industries; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.industries (id, name, email_count, created_at, updated_at, name_en) FROM stdin;
1	Administración de Edificios	1845	2025-03-11 05:01:34.923357	2025-03-11 05:01:34.923357	\N
2	Logística	1243	2025-03-11 05:01:34.932001	2025-03-11 05:01:34.932001	\N
3	Marketing Digital	1301	2025-03-11 05:01:34.939712	2025-03-11 05:01:34.939712	\N
4	Turismo	1258	2025-03-11 05:01:34.947963	2025-03-11 05:01:34.947963	\N
5	Comercio Electrónico	2218	2025-03-11 05:01:34.990428	2025-03-11 05:01:34.990428	\N
6	Contabilidad	2938	2025-03-11 05:01:34.998504	2025-03-11 05:01:34.998504	\N
7	Desarrollo de Software	920	2025-03-11 05:01:35.00562	2025-03-11 05:01:35.00562	\N
8	Veterinarias	1110	2025-03-11 05:01:35.012187	2025-03-11 05:01:35.012187	\N
9	Arquitectura	2786	2025-03-11 05:01:35.019391	2025-03-11 05:01:35.019391	\N
10	Consultorías	410	2025-03-11 05:01:35.02657	2025-03-11 05:01:35.02657	\N
11	Servicios Financieros	2450	2025-03-11 05:01:35.033032	2025-03-11 05:01:35.033032	\N
12	Odontología	2948	2025-03-11 05:01:35.040213	2025-03-11 05:01:35.040213	\N
13	Restaurantes	445	2025-03-11 05:01:35.046428	2025-03-11 05:01:35.046428	\N
14	Constructoras	234	2025-03-11 05:01:35.052931	2025-03-11 05:01:35.052931	\N
15	Servicios Jurídicos	1854	2025-03-11 05:01:35.06266	2025-03-11 05:01:35.06266	\N
16	Ingeniería Eléctrica	488	2025-03-11 05:01:35.071269	2025-03-11 05:01:35.071269	\N
17	Escuelas de Música	1210	2025-03-11 05:01:35.078177	2025-03-11 05:01:35.078177	\N
18	Agencias de Viajes	1029	2025-03-11 05:01:35.085045	2025-03-11 05:01:35.085045	\N
19	Empresas de Seguridad	2466	2025-03-11 05:01:35.091644	2025-03-11 05:01:35.091644	\N
20	Farmacias	2024	2025-03-11 05:01:35.098261	2025-03-11 05:01:35.098261	\N
21	Administración de edificios	1612	2025-03-11 05:19:53.756567	2025-03-11 05:19:53.756567	\N
22	Agencias de publicidad	2699	2025-03-11 05:19:53.766519	2025-03-11 05:19:53.766519	\N
23	Clínicas dentales	4091	2025-03-11 05:19:53.816144	2025-03-11 05:19:53.816144	\N
24	Consultorías TI	4289	2025-03-11 05:19:53.827433	2025-03-11 05:19:53.827433	\N
25	Educación superior	3757	2025-03-11 05:19:53.837665	2025-03-11 05:19:53.837665	\N
26	Escuelas de idiomas	4454	2025-03-11 05:19:53.845418	2025-03-11 05:19:53.845418	\N
27	Gimnasios	3213	2025-03-11 05:19:53.854384	2025-03-11 05:19:53.854384	\N
28	Hoteles	4000	2025-03-11 05:19:53.860797	2025-03-11 05:19:53.860797	\N
29	Ingeniería industrial	4422	2025-03-11 05:19:53.866932	2025-03-11 05:19:53.866932	\N
30	Inmobiliarias	1789	2025-03-11 05:19:53.872888	2025-03-11 05:19:53.872888	\N
31	Jardines infantiles	4576	2025-03-11 05:19:53.880593	2025-03-11 05:19:53.880593	\N
32	Logística y transporte	2277	2025-03-11 05:19:53.887331	2025-03-11 05:19:53.887331	\N
33	Marketing digital	1571	2025-03-11 05:19:53.893579	2025-03-11 05:19:53.893579	\N
34	Notarías	3985	2025-03-11 05:19:53.900096	2025-03-11 05:19:53.900096	\N
35	Odontología estética	4874	2025-03-11 05:19:53.906571	2025-03-11 05:19:53.906571	\N
36	Psicología clínica	3598	2025-03-11 05:19:53.912912	2025-03-11 05:19:53.912912	\N
37	Seguridad privada	1252	2025-03-11 05:19:53.919515	2025-03-11 05:19:53.919515	\N
38	Accounting	\N	2025-03-26 03:19:27.815373	2025-03-26 03:19:27.815373	\N
39	Health, Wellness and Fitness	\N	2025-03-26 03:19:27.831892	2025-03-26 03:19:27.831892	\N
40	Railroad Manufacture	\N	2025-03-26 03:19:27.845237	2025-03-26 03:19:27.845237	\N
41	Maritime	\N	2025-03-26 03:27:25.587109	2025-03-26 03:27:25.587109	\N
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.notifications (id, user_id, title, body, read_at, email_sent_at, created_at, updated_at) FROM stdin;
1	5	✅ Prueba de notificación	¡Este es un correo real enviado desde MailerAction a través de AWS SES!	\N	\N	2025-03-25 04:41:56.86714	2025-03-25 04:41:56.86714
2	5	🚀 Prueba real de notificación por SES	Este es un correo real que estás enviando con Rails 8 + SolidQueue + AWS SES.	\N	\N	2025-03-25 04:49:20.297074	2025-03-25 04:49:20.297074
3	5	📢 Notificación con AWS SES desde Rails	¡Hola Mauricio! Este correo fue enviado con SES usando Rails + SolidQueue + AWS SDK 😎	\N	2025-03-25 06:17:37.19176	2025-03-25 06:17:22.5339	2025-03-25 06:17:37.192452
4	5	✅ Test con puts en job	Este correo debería generar un log visible con puts en consola del worker	\N	2025-03-25 06:35:54.199289	2025-03-25 06:35:37.870534	2025-03-25 06:35:54.200148
5	5	✉️ Test con sender centralizado	Si estás viendo este mensaje, el remitente fue leído desde credentials 😎	\N	2025-03-25 06:59:18.792074	2025-03-25 06:57:39.102985	2025-03-25 06:59:18.79268
7	1	✅ Tu campaña fue enviada con éxito	La campaña "¡Hola desde AWS SES!" fue enviada a 1 destinatarios.\n✅ Éxito: 0 | ❌ Errores: 1 | ⚠️ Tasa de error: 100.0%	\N	\N	2025-03-28 17:17:33.902101	2025-03-28 17:17:33.902101
8	1	⚠️ Campaña procesada sin envíos	La campaña "Falla crítica" no se pudo enviar a ningún destinatario.	\N	\N	2025-03-28 17:32:02.334534	2025-03-28 17:32:02.334534
6	1	✅ Tu campaña fue enviada con éxito	La campaña "Falla crítica" fue enviada a 3 destinatarios.	\N	2025-03-28 18:10:22.721753	2025-03-26 03:29:02.334852	2025-03-28 18:10:22.722909
9	1	⚠️ Campaña procesada sin envíos	La campaña "Sin intentos" no se pudo enviar a ningún destinatario.	\N	\N	2025-03-29 02:02:56.9558	2025-03-29 02:02:56.9558
10	1	📬 Progreso de tu campaña	Tu campaña "Sin intentos" sigue en proceso:\nEnviados: 202\n✅ Éxito: 1 | ❌ Fallos: 201 (Tasa error: 99.5%)	\N	\N	2025-03-29 03:56:14.00248	2025-03-29 03:56:14.00248
11	1	📬 Progreso de tu campaña	Tu campaña "Sin intentos" sigue en proceso:\nEnviados: 271\n✅ Éxito: 1 | ❌ Fallos: 270 (Tasa error: 99.6%)	\N	\N	2025-03-29 03:56:56.958551	2025-03-29 03:56:56.958551
\.


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.plans (id, name, max, campaigna, max_email, created_at, updated_at) FROM stdin;
1	Basic	1	1	3000	2025-03-11 05:19:53.938562	2025-03-11 05:19:53.938562
2	Pro	3	5	10000	2025-03-11 05:19:53.942763	2025-03-11 05:19:53.942763
3	Premium	10	20	50000	2025-03-11 05:19:53.949843	2025-03-11 05:19:53.949843
\.


--
-- Data for Name: public_email_records; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.public_email_records (id, email, website, address, municipality, city, country, company_name, description, created_at, updated_at, industry_id, source_keyword, status) FROM stdin;
1	administrador@bologad.cl	https://www.bologad.cl	\N	\N	\N	Chile	Bologad · Solución Logistica	BOLOGAD es una empresa dedicada principalmente servicios de apoyo a la logística de cargas, administrando estos inventarios y brindando servicios de almacenamiento, reparación y mantención.	2025-03-31 06:00:01.454723	2025-04-02 01:39:49.846198	2	logistica	1
2	contacto@conectalogistica.cl	https://www.conectalogistica.cl/contactanos/	\N	\N	\N	Chile	Conecta Logística	Si necesitas conversar, no dudes en escribirnos, ¡conecta con nosotros ahora!	2025-03-31 06:00:02.655148	2025-04-02 01:39:50.057069	2	logistica	1
3	contacto@pvlogistica.cl	https://pvlogistica.cl	\N	\N	\N	Chile	PVlogística	PVlogística	2025-03-31 06:00:04.289086	2025-04-02 01:39:50.190886	2	logistica	1
4	info@acsiconsultores.cl	https://acsilogistica.cl/contacto/	\N	\N	\N	Chile	Logística de transporte y almacenaje	Empresa logística para soluciones de transporte y almacenaje. Servicio personalizado de alta calidad para tus necesidades logísticas.	2025-03-31 06:00:05.396705	2025-04-02 01:39:50.287749	2	logistica	1
5	contacto@atlogistica.cl	https://www.atlogistica.cl/contacto/	Av. Marta Ossa Ruiz 601"	\N	\N	Chile	AT Logística | Distribución, Almacenaje, Transporte, Contenedores	AT Logística Operadores Logísticos Distribución, Almacenaje de carga, Transporte, Contenedores, Desconsolidación, gestión de inventarios y Supply Chain.	2025-03-31 06:00:16.35448	2025-04-02 01:39:51.593293	2	logistica	1
6	contacto@logisticalk.cl	https://logisticalk.cl	ruta\t\t\t   Contamos con un report personalizado para el seguimiento en linea para cada uno de nuestros clientes	\N	\N	Chile	Logistica LK	Logistica LK	2025-03-31 06:00:19.182572	2025-04-02 01:39:51.813591	2	logistica	1
7	contacto@logisticzeta.cl	https://logisticzeta.cl	\N	\N	\N	Chile	LOGISTIC ZETA SPA	Ofrecemos apoyo logístico para todo tipo de carga cubriendo desde el área metropolitana hasta toda la zona norte del país, cumpliendo con los horarios de recepción y entrega en los tiempos convenidos.	2025-03-31 06:22:08.068541	2025-04-02 01:39:51.839939	2	logistica	1
8	ventas@logisticasbp.cl	https://logisticasbp.cl	\N	\N	\N	Chile	Logistica SBP - \n    Inicio	Logistica SBP - \n    Inicio            \n    	2025-03-31 06:22:08.711034	2025-04-02 01:39:51.863383	2	logistica	1
9	alemana@veterinaria.cl	https://www.veterinaria.cl/contacto	Av. Larraín 6666	\N	\N	Chile	Clinica Veterinaria | Veterinaria.cl | Chile	Contacto | Clinica Veterinaria | Veterinaria.cl | Chile	2025-04-01 03:08:00.356551	2025-04-02 01:39:53.075588	8	veterinarias	1
10	info@veterinariaubo.cl	https://veterinariaubo.cl/contacto/	\N	\N	\N	Chile	Clínica Veterinaria UBO	Contáctanos en Clínica Veterinaria UBO para consultas y citas. Estamos aquí para cuidar de tu mascota con atención profesional y personalizada.	2025-04-01 03:08:03.337237	2025-04-02 01:39:53.121589	8	veterinarias	1
11	contacto@veterinariaeeuu.cl	https://veterinariaeeuu.cl/contacts/	\N	\N	\N	Chile	Contacto – Veterinaria EEUU	Contacto – Veterinaria EEUU	2025-04-01 03:08:10.726796	2025-04-02 01:39:53.375932	8	veterinarias	1
13	contacto@vetdermchile.cl	https://www.vetdermchile.cl/contacto-vetdermchile-dermatologia-veterinaria/	Av. Las Condes 7703 (ver ubicación aquí)	\N	\N	Chile	Vetdermchile	Contacto VetdermChile Dermatología Veterinaria. Encuentra aquí las clínicas donde atendemos. Somos especialistas en gatos, perros y pequeños animales.	2025-04-01 03:08:14.319825	2025-04-02 01:39:53.625077	8	veterinarias	1
12	arica@econovet.cl	https://web.econovet.cl/contact/	Av. Valparaíso #2040QuillotaLocales 4 y 5 HORARIO DE A	\N	\N	Chile	Contacto – EconoVet Veterinarias	Contacto – EconoVet Veterinarias	2025-04-01 03:08:13.572772	2025-04-02 01:39:53.505788	8	veterinarias	1
14	info@veterinariaaltobilbao.cl	https://veterinariaaltobilbao.cl/contact	Av. Francisco Bilbao 6951	\N	Santiago	Chile	Veterinaria Alto Bilbao	Ubicación: Avenida Francisco Bilbao 6951, La Reina (Esquina Monseñor Edwards). Servicios médicos, farmacia, pet store, transporte de mascotas.	2025-04-01 03:08:15.624983	2025-04-02 01:39:53.646058	8	veterinarias	1
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.roles (id, name, created_at, updated_at) FROM stdin;
1	admin	2025-03-11 05:07:02.502137	2025-03-11 05:07:02.502137
2	campaign_manager	2025-03-11 05:07:02.508917	2025-03-11 05:07:02.508917
3	designer	2025-03-11 05:07:02.516115	2025-03-11 05:07:02.516115
4	analyst	2025-03-11 05:07:02.526888	2025-03-11 05:07:02.526888
5	user	2025-03-11 05:07:02.535953	2025-03-11 05:07:02.535953
6	collaborator	2025-03-11 05:07:02.542883	2025-03-11 05:07:02.542883
7	observer	2025-03-11 05:07:02.549405	2025-03-11 05:07:02.549405
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.schema_migrations (version) FROM stdin;
20250309022635
20250309040617
20250310015607
20250310015630
20250310020155
20250310020257
20250310020329
20250310020354
20250310020425
20250310020549
20250310020620
20250310021010
20250310021058
20250311053319
20250312032536
20250312040800
20250312044642
20250315033236
20250319044916
20250322021919
20250322035420
20250322051516
20250322055032
20250322060000
20250323023146
20250323033627
20250323043107
20250325021428
20250325033220
20250325043758
20250327010846
20250327034339
20250328164016
20250329004929
20250330032122
20250330035243
20250330035336
20250330035428
20250330045150
20250330055756
20250330055833
20250330061032
20250330064901
20250331021131
20250331062059
20250401054724
20250401065606
20250402030422
20250411055042
20250411065524
20250412012512
20250412042033
20250503060301
20250506012427
20250506015053
20250524071243
20250524071256
20250530024946
20250530032142
20250530032242
20250530032325
20250530070336
20250607011759
20250607020430
20250607021701
20250607080538
20250610043904
\.


--
-- Data for Name: scrape_targets; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.scrape_targets (id, url, status, last_attempt_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: scraping_sources; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.scraping_sources (id, url, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.sessions (id, user_id, session_token, created_at, updated_at, user_agent, ip_address) FROM stdin;
3	2	ac474c97a5b610904fa3b7e9336197dd897d604aa411e875a34af69c5bbf2ffa	2025-03-12 04:51:57.814042	2025-03-12 04:51:57.814042	curl/7.88.1	127.0.0.1
4	2	db48a39bcb7248cd87eb582101b836c4e88ed780d96ebbc6a05cc968a38c8f2a	2025-03-12 04:54:51.116979	2025-03-12 04:54:51.116979	curl/7.88.1	127.0.0.1
5	2	524156a1fc85a26840f50f964363c76cc5221d98164f3b16b402c29cf038024c	2025-03-12 05:00:18.655509	2025-03-12 05:00:18.655509	curl/7.88.1	127.0.0.1
6	2	baa04072eb8d6c57f87434e99112928010235a76895c2770c20d665ade332b7d	2025-03-12 05:08:11.153396	2025-03-12 05:08:11.153396	curl/7.88.1	127.0.0.1
7	2	67fe0be69a451bbb5bd7da9a417ae20c9d301b18a89a7dc01f07ba0a60aec56f	2025-03-12 05:11:01.400763	2025-03-12 05:11:01.400763	curl/7.88.1	127.0.0.1
8	2	0cb49942fdd803ed10b0905d89b190790c2a1c16206b83315dff7ad1a8dd6b7d	2025-03-12 05:18:45.60877	2025-03-12 05:18:45.60877	curl/7.88.1	127.0.0.1
9	2	93a6a34ca207c4dc593ad29c685c450e02f0335bda26ec38a0b25d03e803b7d0	2025-03-13 03:35:10.539518	2025-03-13 03:35:10.539518	PostmanRuntime/7.39.1	::1
10	2	a506e872f2e9684c8e437728c7b5ca974dfdc7530b9cfc1479ace131a602f58e	2025-03-13 03:41:08.894144	2025-03-13 03:41:08.894144	PostmanRuntime/7.39.1	::1
11	2	e26e3b327237f82ba426ea7bf0ba2683ea9b5d6c13de20e10afb349d8362561c	2025-03-13 03:44:13.182919	2025-03-13 03:44:13.182919	PostmanRuntime/7.39.1	::1
12	2	a4236a8378352254c81b07d222d30086d2dddd7306d478a78ce4195a719fa508	2025-03-13 04:30:50.44135	2025-03-13 04:30:50.44135	PostmanRuntime/7.39.1	::1
13	2	1fab94119b96fe1570f96c9120d3510b57915dff4ea906e78474317096feb75a	2025-03-13 04:40:58.081886	2025-03-13 04:40:58.081886	PostmanRuntime/7.39.1	::1
14	2	63f391939b6ba632b1e4f95c17a231d04d2190e074029bf34ce6c2ffdc9ee04d	2025-03-13 04:45:23.643912	2025-03-13 04:45:23.643912	PostmanRuntime/7.39.1	::1
15	2	b446db2efc75c25e9212bd2eb6fb7a7214964335f1cbc47b767b6282e77db1af	2025-03-14 02:52:08.923152	2025-03-14 02:52:08.923152	curl/7.88.1	127.0.0.1
16	2	ae28a529e23c1243d3038f6a1e37d7fd49a173bdeab36e5c52eb331d1e37f9cc	2025-03-14 02:54:56.205516	2025-03-14 02:54:56.205516	PostmanRuntime/7.39.1	::1
17	2	410b4279738732b433c69f14b229919d0b930b4e937c3197b5ceb877f2973701	2025-03-14 03:45:50.672988	2025-03-14 03:45:50.672988	PostmanRuntime/7.39.1	::1
18	2	43dd2577268aff320e6d0e9a3d0e953c28f01916b71c72b14e3f8eb91840e73b	2025-03-14 03:52:54.946805	2025-03-14 03:52:54.946805	PostmanRuntime/7.39.1	::1
19	2	7d14342823c5e57898868280e2bf83b8ee40cf0872fc6602b50de0d70a6c2f52	2025-03-14 03:55:09.308472	2025-03-14 03:55:09.308472	PostmanRuntime/7.39.1	::1
20	2	9db93a92781cfa2323ff9bc591aa1555f31041f3090c1a930c96fc4f29cb92b8	2025-03-14 03:57:44.889559	2025-03-14 03:57:44.889559	PostmanRuntime/7.39.1	::1
21	2	50bb1d8ca0ff7eadd0ad3d537d22dd0592f9dbab94513a27a348b37ce05551a8	2025-03-14 04:10:28.398798	2025-03-14 04:10:28.398798	PostmanRuntime/7.39.1	::1
22	2	f3667173a9e6b9be96f8c13955e7eb072d5c4a328632d4c695af590dcc108ccf	2025-03-14 18:57:16.136496	2025-03-14 18:57:16.136496	PostmanRuntime/7.39.1	::1
23	2	e78ed22923f11d27aa5be72988870d66a66df16efe7237fffc93c4ab08661ccf	2025-03-19 01:20:12.961513	2025-03-19 01:20:12.961513	PostmanRuntime/7.39.1	::1
24	6	a0f0583069cc7b7a763e097420ff47448e0d80ed008954a2bd1b67fde195a7fb	2025-04-10 05:07:25.514566	2025-04-10 05:07:25.514566	PostmanRuntime/7.39.1	::1
\.


--
-- Data for Name: solid_queue_blocked_executions; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_blocked_executions (id, job_id, queue_name, priority, concurrency_key, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_claimed_executions; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_claimed_executions (id, job_id, process_id, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_failed_executions; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_failed_executions (id, job_id, error, created_at) FROM stdin;
1	1	{"exception_class":"ArgumentError","message":"parameter validator found 2 errors:\\n  - missing required parameter params[:message][:body][:html][:data]\\n  - missing required parameter params[:message][:subject][:data]","backtrace":["/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/param_validator.rb:35:in `validate!'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/param_validator.rb:15:in `validate!'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/param_validator.rb:25:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/seahorse/client/plugins/raise_response_errors.rb:16:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/checksum_algorithm.rb:169:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/jsonvalue_converter.rb:16:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/invocation_id.rb:16:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/idempotency_token.rb:19:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/param_converter.rb:26:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/seahorse/client/plugins/request_callback.rb:89:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/response_paging.rb:12:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/seahorse/client/plugins/response_target.rb:24:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/telemetry.rb:39:in `block in call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/telemetry/no_op.rb:29:in `in_span'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/telemetry.rb:53:in `span_wrapper'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/aws-sdk-core/plugins/telemetry.rb:39:in `call'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-core-3.220.1/lib/seahorse/client/request.rb:72:in `send_request'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/aws-sdk-ses-1.82.0/lib/aws-sdk-ses/client.rb:3585:in `send_email'","/home/chima/proyecto/maileraction/app/jobs/campaigns/send_campaign_job.rb:18:in `block in perform'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/relation/delegation.rb:101:in `each'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/relation/delegation.rb:101:in `each'","/home/chima/proyecto/maileraction/app/jobs/campaigns/send_campaign_job.rb:16:in `perform'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:68:in `block in _perform_job'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:120:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/i18n-1.14.7/lib/i18n.rb:353:in `with_locale'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/translation.rb:9:in `block (2 levels) in \\u003cmodule:Translation\\u003e'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `instance_exec'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/core_ext/time/zones.rb:65:in `use_zone'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/timezones.rb:9:in `block (2 levels) in \\u003cmodule:Timezones\\u003e'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `instance_exec'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:140:in `run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:67:in `_perform_job'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:32:in `_perform_job'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:51:in `perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:26:in `block in perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/railties/job_runtime.rb:13:in `block in instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:40:in `block in instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/notifications.rb:210:in `block in instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/notifications/instrumenter.rb:58:in `instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/notifications.rb:210:in `instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:39:in `instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/railties/job_runtime.rb:11:in `instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:26:in `perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/logging.rb:32:in `block in perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/tagged_logging.rb:143:in `block in tagged'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/tagged_logging.rb:38:in `tagged'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/tagged_logging.rb:143:in `tagged'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/broadcast_logger.rb:241:in `method_missing'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/logging.rb:39:in `tag_logger'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/logging.rb:32:in `perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:29:in `block in execute'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:120:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/railtie.rb:95:in `block (4 levels) in \\u003cclass:Railtie\\u003e'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/reloader.rb:77:in `block in wrap'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/execution_wrapper.rb:87:in `wrap'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/reloader.rb:74:in `wrap'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/railtie.rb:94:in `block (3 levels) in \\u003cclass:Railtie\\u003e'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `instance_exec'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:140:in `run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:27:in `execute'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/app/models/solid_queue/claimed_execution.rb:95:in `execute'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/app/models/solid_queue/claimed_execution.rb:61:in `perform'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/lib/solid_queue/pool.rb:23:in `block (2 levels) in post'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/execution_wrapper.rb:91:in `wrap'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/lib/solid_queue/app_executor.rb:7:in `wrap_in_app_executor'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/lib/solid_queue/pool.rb:22:in `block in post'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/promises.rb:1593:in `evaluate_to'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/promises.rb:1776:in `block in on_resolvable'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:359:in `run_task'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:350:in `block (3 levels) in create_worker'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:341:in `loop'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:341:in `block (2 levels) in create_worker'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:340:in `catch'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:340:in `block in create_worker'"]}	2025-03-22 02:35:37.200188
2	3	{"exception_class":"ActiveRecord::RecordInvalid","message":"Validation failed: Status is not included in the list","backtrace":["/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/validations.rb:87:in `raise_validation_error'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/validations.rb:54:in `save!'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/transactions.rb:366:in `block in save!'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/transactions.rb:418:in `block (2 levels) in with_transaction_returning_status'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_adapters/abstract/database_statements.rb:357:in `transaction'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/transactions.rb:414:in `block in with_transaction_returning_status'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_adapters/abstract/connection_pool.rb:412:in `with_connection'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_handling.rb:310:in `with_connection'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/transactions.rb:410:in `with_transaction_returning_status'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/transactions.rb:366:in `save!'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/suppressor.rb:56:in `save!'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/persistence.rb:579:in `block in update!'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/transactions.rb:418:in `block (2 levels) in with_transaction_returning_status'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_adapters/abstract/transaction.rb:626:in `block in within_new_transaction'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/concurrency/null_lock.rb:9:in `synchronize'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_adapters/abstract/transaction.rb:623:in `within_new_transaction'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_adapters/abstract/database_statements.rb:367:in `within_new_transaction'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_adapters/abstract/database_statements.rb:359:in `transaction'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/transactions.rb:414:in `block in with_transaction_returning_status'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_adapters/abstract/connection_pool.rb:418:in `with_connection'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/connection_handling.rb:310:in `with_connection'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/transactions.rb:410:in `with_transaction_returning_status'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/persistence.rb:577:in `update!'","/home/chima/proyecto/maileraction/app/jobs/campaigns/send_campaign_job.rb:53:in `perform'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:68:in `block in _perform_job'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:120:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/i18n-1.14.7/lib/i18n.rb:353:in `with_locale'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/translation.rb:9:in `block (2 levels) in \\u003cmodule:Translation\\u003e'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `instance_exec'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/core_ext/time/zones.rb:65:in `use_zone'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/timezones.rb:9:in `block (2 levels) in \\u003cmodule:Timezones\\u003e'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `instance_exec'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:140:in `run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:67:in `_perform_job'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:32:in `_perform_job'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:51:in `perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:26:in `block in perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/railties/job_runtime.rb:13:in `block in instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:40:in `block in instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/notifications.rb:210:in `block in instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/notifications/instrumenter.rb:58:in `instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/notifications.rb:210:in `instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:39:in `instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activerecord-8.0.1/lib/active_record/railties/job_runtime.rb:11:in `instrument'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/instrumentation.rb:26:in `perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/logging.rb:32:in `block in perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/tagged_logging.rb:143:in `block in tagged'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/tagged_logging.rb:38:in `tagged'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/tagged_logging.rb:143:in `tagged'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/broadcast_logger.rb:241:in `method_missing'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/logging.rb:39:in `tag_logger'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/logging.rb:32:in `perform_now'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:29:in `block in execute'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:120:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/railtie.rb:95:in `block (4 levels) in \\u003cclass:Railtie\\u003e'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/reloader.rb:77:in `block in wrap'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/execution_wrapper.rb:87:in `wrap'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/reloader.rb:74:in `wrap'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/railtie.rb:94:in `block (3 levels) in \\u003cclass:Railtie\\u003e'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `instance_exec'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:129:in `block in run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/callbacks.rb:140:in `run_callbacks'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activejob-8.0.1/lib/active_job/execution.rb:27:in `execute'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/app/models/solid_queue/claimed_execution.rb:95:in `execute'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/app/models/solid_queue/claimed_execution.rb:61:in `perform'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/lib/solid_queue/pool.rb:23:in `block (2 levels) in post'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/activesupport-8.0.1/lib/active_support/execution_wrapper.rb:91:in `wrap'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/lib/solid_queue/app_executor.rb:7:in `wrap_in_app_executor'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/solid_queue-1.1.3/lib/solid_queue/pool.rb:22:in `block in post'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/promises.rb:1593:in `evaluate_to'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/promises.rb:1776:in `block in on_resolvable'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:359:in `run_task'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:350:in `block (3 levels) in create_worker'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:341:in `loop'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:341:in `block (2 levels) in create_worker'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:340:in `catch'","/home/chima/.rbenv/versions/3.2.3/lib/ruby/gems/3.2.0/gems/concurrent-ruby-1.3.5/lib/concurrent-ruby/concurrent/executor/ruby_thread_pool_executor.rb:340:in `block in create_worker'"]}	2025-03-22 03:20:18.993794
\.


--
-- Data for Name: solid_queue_jobs; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_jobs (id, queue_name, class_name, arguments, priority, active_job_id, scheduled_at, finished_at, concurrency_key, created_at, updated_at) FROM stdin;
1	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"f95b7909-3b9d-4c56-a363-ccd24634d178","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[1],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-22T02:35:36.928222261Z","scheduled_at":"2025-03-22T02:35:36.926944455Z"}	0	f95b7909-3b9d-4c56-a363-ccd24634d178	2025-03-22 02:35:36.926944	\N	\N	2025-03-22 02:35:36.959363	2025-03-22 02:35:36.959363
2	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"d0b49777-97bf-468a-974b-02a24aabb90b","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[1],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-22T03:01:15.668306080Z","scheduled_at":"2025-03-22T03:01:15.667930746Z"}	0	d0b49777-97bf-468a-974b-02a24aabb90b	2025-03-22 03:01:15.66793	2025-03-22 03:01:15.842359	\N	2025-03-22 03:01:15.695186	2025-03-22 03:01:15.842359
3	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"e45103a9-04ce-4364-8c38-3256f3f251e0","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[3],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-22T03:20:18.855651576Z","scheduled_at":"2025-03-22T03:20:18.855613825Z"}	0	e45103a9-04ce-4364-8c38-3256f3f251e0	2025-03-22 03:20:18.855613	\N	\N	2025-03-22 03:20:18.85596	2025-03-22 03:20:18.85596
4	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"14ccbf80-077a-4a80-beff-e05f48ac8b4c","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[3],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-22T03:42:55.856042542Z","scheduled_at":"2025-03-22T03:42:55.855999511Z"}	0	14ccbf80-077a-4a80-beff-e05f48ac8b4c	2025-03-22 03:42:55.855999	2025-03-22 03:42:55.979291	\N	2025-03-22 03:42:55.85655	2025-03-22 03:42:55.979291
5	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"1824421f-19dc-4701-a9fd-0b8398fcc308","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[4],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-22T03:47:05.869467372Z","scheduled_at":"2025-03-22T03:47:05.869357686Z"}	0	1824421f-19dc-4701-a9fd-0b8398fcc308	2025-03-22 03:47:05.869357	2025-03-22 03:47:06.053873	\N	2025-03-22 03:47:05.869982	2025-03-22 03:47:06.053873
7	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"b95aff9c-f1c6-4e79-805d-86ad59eb5a0a","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["🚨 Prueba de alerta de error desde MailerAction"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-22T04:41:44.718663028Z","scheduled_at":"2025-03-22T04:41:44.718626129Z"}	0	b95aff9c-f1c6-4e79-805d-86ad59eb5a0a	2025-03-22 04:41:44.718626	2025-03-25 04:44:00.367364	\N	2025-03-22 04:41:44.719221	2025-03-25 04:44:00.367364
8	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"b1e87708-e489-4016-8905-fb035de06c47","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T02:55:32.985591191Z","scheduled_at":"2025-03-25T02:55:32.985258600Z"}	0	b1e87708-e489-4016-8905-fb035de06c47	2025-03-25 02:55:32.985258	2025-03-25 04:44:00.376874	\N	2025-03-25 02:55:32.994783	2025-03-25 04:44:00.376874
9	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"a73fdb7b-5e59-416a-8efb-1a56e8ae9341","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T02:59:40.440231585Z","scheduled_at":"2025-03-25T02:59:40.440178055Z"}	0	a73fdb7b-5e59-416a-8efb-1a56e8ae9341	2025-03-25 02:59:40.440178	2025-03-25 04:44:00.441368	\N	2025-03-25 02:59:40.448051	2025-03-25 04:44:00.441368
11	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"32d01d97-36d7-4d48-866a-ef13b70ccc0c","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:00:29.784358319Z","scheduled_at":"2025-03-25T03:00:29.784319597Z"}	0	32d01d97-36d7-4d48-866a-ef13b70ccc0c	2025-03-25 03:00:29.784319	2025-03-25 04:44:00.449328	\N	2025-03-25 03:00:29.796683	2025-03-25 04:44:00.449328
12	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"afe187af-66f2-4dd9-bb5f-fcf32159753f","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:01:14.528373819Z","scheduled_at":"2025-03-25T03:01:14.528301445Z"}	0	afe187af-66f2-4dd9-bb5f-fcf32159753f	2025-03-25 03:01:14.528301	2025-03-25 04:44:00.540389	\N	2025-03-25 03:01:14.545662	2025-03-25 04:44:00.540389
13	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"f9a708af-5813-44ee-bc20-84cb40980327","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:02:32.818887402Z","scheduled_at":"2025-03-25T03:02:32.818843530Z"}	0	f9a708af-5813-44ee-bc20-84cb40980327	2025-03-25 03:02:32.818843	2025-03-25 04:44:00.54768	\N	2025-03-25 03:02:32.826659	2025-03-25 04:44:00.54768
14	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"462cc0e3-e977-4f6b-afc4-3be9e485d4ce","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:02:48.670484845Z","scheduled_at":"2025-03-25T03:02:48.670425854Z"}	0	462cc0e3-e977-4f6b-afc4-3be9e485d4ce	2025-03-25 03:02:48.670425	2025-03-25 04:44:00.558963	\N	2025-03-25 03:02:48.677847	2025-03-25 04:44:00.558963
15	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"3f8e0351-ca04-4f9b-9961-67a00f112d87","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:03:24.257331339Z","scheduled_at":"2025-03-25T03:03:24.257291314Z"}	0	3f8e0351-ca04-4f9b-9961-67a00f112d87	2025-03-25 03:03:24.257291	2025-03-25 04:44:00.629097	\N	2025-03-25 03:03:24.264442	2025-03-25 04:44:00.629097
6	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"27d721b1-6b23-4e10-b6e2-a400c8e9e0ab","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["🚨 Prueba de alerta de error desde MailerAction"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-22T04:30:15.657145219Z","scheduled_at":"2025-03-22T04:30:15.656781736Z"}	0	27d721b1-6b23-4e10-b6e2-a400c8e9e0ab	2025-03-22 04:30:15.656781	2025-03-25 04:44:00.352755	\N	2025-03-22 04:30:15.691245	2025-03-25 04:44:00.352755
10	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"3c113540-eaaf-48c1-911b-0d20dce8e12e","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:00:00.237234576Z","scheduled_at":"2025-03-25T03:00:00.237182347Z"}	0	3c113540-eaaf-48c1-911b-0d20dce8e12e	2025-03-25 03:00:00.237182	2025-03-25 04:44:00.453067	\N	2025-03-25 03:00:00.245932	2025-03-25 04:44:00.453067
16	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"03c90005-3821-497d-afec-59c3591c947a","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:05:04.045978331Z","scheduled_at":"2025-03-25T03:05:04.045921424Z"}	0	03c90005-3821-497d-afec-59c3591c947a	2025-03-25 03:05:04.045921	2025-03-25 04:44:00.655016	\N	2025-03-25 03:05:04.054193	2025-03-25 04:44:00.655016
17	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"b8bd8163-5e97-4db3-9447-3abb25d153bb","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: Tengo un problema al crear plantillas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:05:16.989693955Z","scheduled_at":"2025-03-25T03:05:16.989551208Z"}	0	b8bd8163-5e97-4db3-9447-3abb25d153bb	2025-03-25 03:05:16.989551	2025-03-25 04:44:00.714127	\N	2025-03-25 03:05:16.998019	2025-03-25 04:44:00.714127
18	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"6bc96a0f-94ac-4482-9f04-0ee52bdd4900","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No se cargan bien los créditos después de la campaña."],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-25T03:06:44.271828110Z","scheduled_at":"2025-03-25T03:06:44.271795428Z"}	0	6bc96a0f-94ac-4482-9f04-0ee52bdd4900	2025-03-25 03:06:44.271795	2025-03-25 04:44:00.78059	\N	2025-03-25 03:06:44.272211	2025-03-25 04:44:00.78059
19	default	Notifications::SendEmailJob	{"job_class":"Notifications::SendEmailJob","job_id":"a0cb854e-0158-40f7-a380-24d8b2b49bd9","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[1],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-25T04:42:11.135277456Z","scheduled_at":"2025-03-25T04:42:11.134901450Z"}	0	a0cb854e-0158-40f7-a380-24d8b2b49bd9	2025-03-25 04:42:11.134901	2025-03-25 04:44:00.783412	\N	2025-03-25 04:42:11.145673	2025-03-25 04:44:00.783412
20	default	Notifications::SendEmailJob	{"job_class":"Notifications::SendEmailJob","job_id":"d955a580-fb96-4a08-a7f7-144a6b2af802","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[3],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-25T06:20:34.213185766Z","scheduled_at":"2025-03-25T06:20:34.211255094Z"}	0	d955a580-fb96-4a08-a7f7-144a6b2af802	2025-03-25 06:20:34.211255	2025-03-25 06:20:58.327545	\N	2025-03-25 06:20:34.253772	2025-03-25 06:20:58.327545
21	default	Notifications::SendEmailJob	{"job_class":"Notifications::SendEmailJob","job_id":"d0ff27de-1578-40fa-9809-d1c48f81ed28","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[4],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-25T06:35:53.576447283Z","scheduled_at":"2025-03-25T06:35:53.576396818Z"}	0	d0ff27de-1578-40fa-9809-d1c48f81ed28	2025-03-25 06:35:53.576396	2025-03-25 06:35:54.206747	\N	2025-03-25 06:35:53.576848	2025-03-25 06:35:54.206747
24	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"8a976916-1dab-440a-93c4-45cf7cf93f69","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[5],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-28T17:32:02.122075860Z","scheduled_at":"2025-03-28T17:32:32.112883806Z"}	0	8a976916-1dab-440a-93c4-45cf7cf93f69	2025-03-28 17:32:32.112883	2025-03-28 18:10:22.488432	\N	2025-03-28 17:32:02.133396	2025-03-28 18:10:22.488432
25	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"cee01fb1-8f9e-4382-89ff-0e0144672058","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[5],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-28T17:32:02.227754030Z","scheduled_at":"2025-03-28T17:32:32.227520704Z"}	0	cee01fb1-8f9e-4382-89ff-0e0144672058	2025-03-28 17:32:32.22752	2025-03-28 18:10:22.563655	\N	2025-03-28 17:32:02.228002	2025-03-28 18:10:22.563655
26	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"094f4c3d-f99f-4c09-9d68-794c99b51e55","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[5],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-28T17:32:02.303847544Z","scheduled_at":"2025-03-28T17:32:32.303701877Z"}	0	094f4c3d-f99f-4c09-9d68-794c99b51e55	2025-03-28 17:32:32.303701	2025-03-28 18:10:22.586331	\N	2025-03-28 17:32:02.304083	2025-03-28 18:10:22.586331
23	default	Notifications::SendEmailJob	{"job_class":"Notifications::SendEmailJob","job_id":"f8cf5276-4116-45b2-91c2-3fa9b169ebb0","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[6],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-26T03:29:02.339595306Z","scheduled_at":"2025-03-26T03:29:02.339562544Z"}	0	f8cf5276-4116-45b2-91c2-3fa9b169ebb0	2025-03-26 03:29:02.339562	2025-03-28 18:10:22.731649	\N	2025-03-26 03:29:02.339843	2025-03-28 18:10:22.731649
22	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"3b4c40ed-403f-4616-9699-c7f1b61f728e","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["🚨 Se detectaron múltiples errores en el envío de campañas."],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-26T03:29:02.284781031Z","scheduled_at":"2025-03-26T03:29:02.284434178Z"}	0	3b4c40ed-403f-4616-9699-c7f1b61f728e	2025-03-26 03:29:02.284434	2025-03-28 18:10:22.792819	\N	2025-03-26 03:29:02.29664	2025-03-28 18:10:22.792819
27	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"e70292e8-adfd-4a69-a65c-0da861cf8f8a","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[7],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-29T02:02:56.904476913Z","scheduled_at":"2025-03-29T02:03:26.896091461Z"}	0	e70292e8-adfd-4a69-a65c-0da861cf8f8a	2025-03-29 02:03:26.896091	\N	\N	2025-03-29 02:02:56.91454	2025-03-29 02:02:56.91454
28	default	Campaigns::SendCampaignBatchJob	{"job_class":"Campaigns::SendCampaignBatchJob","job_id":"fa49211d-276d-4d0f-b32f-121c0dca1521","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[7,100],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-29T03:47:19.102711399Z","scheduled_at":"2025-03-29T03:48:19.096933603Z"}	0	fa49211d-276d-4d0f-b32f-121c0dca1521	2025-03-29 03:48:19.096933	\N	\N	2025-03-29 03:47:19.112145	2025-03-29 03:47:19.112145
29	default	Campaigns::SendCampaignBatchJob	{"job_class":"Campaigns::SendCampaignBatchJob","job_id":"63205ba1-c7b5-4dda-801c-c3c937da1faf","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[7,100],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-29T03:56:14.010569028Z","scheduled_at":"2025-03-29T03:57:14.005793809Z"}	0	63205ba1-c7b5-4dda-801c-c3c937da1faf	2025-03-29 03:57:14.005793	\N	\N	2025-03-29 03:56:14.019433	2025-03-29 03:56:14.019433
30	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"fef75162-d67f-4a1e-bb18-9fca3ff12eab","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:15:36.178040691Z","scheduled_at":"2025-03-30T02:15:36.177322423Z"}	0	fef75162-d67f-4a1e-bb18-9fca3ff12eab	2025-03-30 02:15:36.177322	\N	\N	2025-03-30 02:15:36.189046	2025-03-30 02:15:36.189046
31	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"c5ab68d3-b9b3-414f-9ddc-230975b5e964","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:21:04.119734052Z","scheduled_at":"2025-03-30T02:21:04.117421494Z"}	0	c5ab68d3-b9b3-414f-9ddc-230975b5e964	2025-03-30 02:21:04.117421	\N	\N	2025-03-30 02:21:04.143364	2025-03-30 02:21:04.143364
32	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"3d1d36c9-2502-41e9-9343-a6aa9d49308a","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:23:22.369217796Z","scheduled_at":"2025-03-30T02:23:22.369176307Z"}	0	3d1d36c9-2502-41e9-9343-a6aa9d49308a	2025-03-30 02:23:22.369176	\N	\N	2025-03-30 02:23:22.376369	2025-03-30 02:23:22.376369
33	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"6c34ff83-9ee3-40ce-ad1d-ac3c87c618be","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:24:01.453743880Z","scheduled_at":"2025-03-30T02:24:01.453373855Z"}	0	6c34ff83-9ee3-40ce-ad1d-ac3c87c618be	2025-03-30 02:24:01.453373	\N	\N	2025-03-30 02:24:01.463592	2025-03-30 02:24:01.463592
34	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"72c731ac-277b-470f-9861-b05d7f683ca1","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:30:55.709982591Z","scheduled_at":"2025-03-30T02:30:55.709889618Z"}	0	72c731ac-277b-470f-9861-b05d7f683ca1	2025-03-30 02:30:55.709889	\N	\N	2025-03-30 02:30:55.714866	2025-03-30 02:30:55.714866
35	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"efc45a7e-ac31-4bc5-bed2-abc0c57ddcd9","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:32:53.185416345Z","scheduled_at":"2025-03-30T02:32:53.185363285Z"}	0	efc45a7e-ac31-4bc5-bed2-abc0c57ddcd9	2025-03-30 02:32:53.185363	\N	\N	2025-03-30 02:32:53.19299	2025-03-30 02:32:53.19299
36	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"c8d6620e-17f0-43ae-8c3d-0ee694c12e63","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:40:28.639849095Z","scheduled_at":"2025-03-30T02:40:28.639789463Z"}	0	c8d6620e-17f0-43ae-8c3d-0ee694c12e63	2025-03-30 02:40:28.639789	\N	\N	2025-03-30 02:40:28.643786	2025-03-30 02:40:28.643786
37	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"860446a3-9c82-48f1-91e7-0f595de9f753","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:41:37.955298993Z","scheduled_at":"2025-03-30T02:41:37.955250421Z"}	0	860446a3-9c82-48f1-91e7-0f595de9f753	2025-03-30 02:41:37.95525	\N	\N	2025-03-30 02:41:37.965325	2025-03-30 02:41:37.965325
38	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"799ace82-be25-48a1-828a-88a14fe462fd","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:41:58.234557439Z","scheduled_at":"2025-03-30T02:41:58.234211541Z"}	0	799ace82-be25-48a1-828a-88a14fe462fd	2025-03-30 02:41:58.234211	\N	\N	2025-03-30 02:41:58.243399	2025-03-30 02:41:58.243399
39	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"9286a340-fb90-4ca1-adbc-0258f721e005","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:42:55.515641454Z","scheduled_at":"2025-03-30T02:42:55.515576272Z"}	0	9286a340-fb90-4ca1-adbc-0258f721e005	2025-03-30 02:42:55.515576	\N	\N	2025-03-30 02:42:55.523432	2025-03-30 02:42:55.523432
40	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"2aec7eb0-f6d6-42aa-b79e-0d3ddef01e75","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:43:41.503898977Z","scheduled_at":"2025-03-30T02:43:41.503854734Z"}	0	2aec7eb0-f6d6-42aa-b79e-0d3ddef01e75	2025-03-30 02:43:41.503854	\N	\N	2025-03-30 02:43:41.511316	2025-03-30 02:43:41.511316
41	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"1a6a3849-c84a-4924-a375-15704745cd39","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:44:16.180756753Z","scheduled_at":"2025-03-30T02:44:16.180400655Z"}	0	1a6a3849-c84a-4924-a375-15704745cd39	2025-03-30 02:44:16.1804	\N	\N	2025-03-30 02:44:16.189219	2025-03-30 02:44:16.189219
42	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"b9484ad6-d68e-43af-8004-211c4affa1ab","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:45:43.848894922Z","scheduled_at":"2025-03-30T02:45:43.848510211Z"}	0	b9484ad6-d68e-43af-8004-211c4affa1ab	2025-03-30 02:45:43.84851	\N	\N	2025-03-30 02:45:43.858194	2025-03-30 02:45:43.858194
43	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"54ea3dfd-c0aa-4859-9fd4-c224c0a1a1ac","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:51:12.298117188Z","scheduled_at":"2025-03-30T02:51:12.297709275Z"}	0	54ea3dfd-c0aa-4859-9fd4-c224c0a1a1ac	2025-03-30 02:51:12.297709	\N	\N	2025-03-30 02:51:12.306881	2025-03-30 02:51:12.306881
44	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"e1108258-35ae-4048-86a0-4e270c670f8c","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:54:30.453169256Z","scheduled_at":"2025-03-30T02:54:30.453120975Z"}	0	e1108258-35ae-4048-86a0-4e270c670f8c	2025-03-30 02:54:30.45312	\N	\N	2025-03-30 02:54:30.461171	2025-03-30 02:54:30.461171
45	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"03f7908f-5074-43ac-bf1c-6c0ebe70a69c","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T02:56:25.807021748Z","scheduled_at":"2025-03-30T02:56:25.806609796Z"}	0	03f7908f-5074-43ac-bf1c-6c0ebe70a69c	2025-03-30 02:56:25.806609	\N	\N	2025-03-30 02:56:25.81782	2025-03-30 02:56:25.81782
46	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"4582feb6-55c7-46f5-b949-ada16805e890","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T03:04:39.416283245Z","scheduled_at":"2025-03-30T03:04:39.415943937Z"}	0	4582feb6-55c7-46f5-b949-ada16805e890	2025-03-30 03:04:39.415943	\N	\N	2025-03-30 03:04:39.425928	2025-03-30 03:04:39.425928
47	default	AdminNotifierJob	{"job_class":"AdminNotifierJob","job_id":"70a63741-f790-43e7-af4e-f8de2e2c0064","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["📬 Nuevo soporte de admin@mail.com: No puedo acceder a mi cuenta"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T03:55:36.941788007Z","scheduled_at":"2025-03-30T03:55:36.941326140Z"}	0	70a63741-f790-43e7-af4e-f8de2e2c0064	2025-03-30 03:55:36.941326	\N	\N	2025-03-30 03:55:36.950098	2025-03-30 03:55:36.950098
48	default	ScrapeEmailJob	{"job_class":"ScrapeEmailJob","job_id":"b3d7c5bf-f079-402a-bbd1-c282f0b6153f","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["https://empresa-ejemplo.cl"],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-30T05:30:24.215264137Z","scheduled_at":"2025-03-30T05:30:24.214783827Z"}	0	b3d7c5bf-f079-402a-bbd1-c282f0b6153f	2025-03-30 05:30:24.214783	\N	\N	2025-03-30 05:30:24.253843	2025-03-30 05:30:24.253843
49	default	ScrapeEmailJob	{"job_class":"ScrapeEmailJob","job_id":"4e2c1118-aa46-4e11-8d64-643b1d06c257","provider_job_id":null,"queue_name":"default","priority":null,"arguments":["https://empresa-cliente.cl"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-03-30T06:43:15.361726765Z","scheduled_at":"2025-03-30T06:43:15.361349468Z"}	0	4e2c1118-aa46-4e11-8d64-643b1d06c257	2025-03-30 06:43:15.361349	\N	\N	2025-03-30 06:43:15.371303	2025-03-30 06:43:15.371303
50	default	ResetIndustryEmailCountsJob	{"job_class":"ResetIndustryEmailCountsJob","job_id":"c8064e66-0593-4f59-b63f-f5c2202edcd4","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[],"executions":0,"exception_executions":{},"locale":"en","timezone":"America/Santiago","enqueued_at":"2025-03-30T06:57:00.550126392Z","scheduled_at":"2025-03-30T06:57:00.549711634Z"}	0	c8064e66-0593-4f59-b63f-f5c2202edcd4	2025-03-30 06:57:00.549711	\N	\N	2025-03-30 06:57:00.580939	2025-03-30 06:57:00.580939
51	default	Campaigns::SendCampaignJob	{"job_class":"Campaigns::SendCampaignJob","job_id":"ec869f72-471a-4cee-a02a-3c7f8bcfa57a","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[4],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2025-04-02T04:28:35.826718175Z","scheduled_at":"2025-04-02T04:28:35.826307485Z"}	0	ec869f72-471a-4cee-a02a-3c7f8bcfa57a	2025-04-02 04:28:35.826307	\N	\N	2025-04-02 04:28:35.837876	2025-04-02 04:28:35.837876
\.


--
-- Data for Name: solid_queue_pauses; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_pauses (id, queue_name, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_processes; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_processes (id, kind, last_heartbeat_at, supervisor_id, pid, hostname, metadata, created_at, name) FROM stdin;
\.


--
-- Data for Name: solid_queue_ready_executions; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_ready_executions (id, job_id, queue_name, priority, created_at) FROM stdin;
27	30	default	0	2025-03-30 02:15:36.206556
28	31	default	0	2025-03-30 02:21:04.177776
29	32	default	0	2025-03-30 02:23:22.388822
30	33	default	0	2025-03-30 02:24:01.481098
31	34	default	0	2025-03-30 02:30:55.731063
32	35	default	0	2025-03-30 02:32:53.208302
33	36	default	0	2025-03-30 02:40:28.658618
34	37	default	0	2025-03-30 02:41:37.988869
35	38	default	0	2025-03-30 02:41:58.260208
36	39	default	0	2025-03-30 02:42:55.537887
37	40	default	0	2025-03-30 02:43:41.527001
38	41	default	0	2025-03-30 02:44:16.204065
39	42	default	0	2025-03-30 02:45:43.880927
40	43	default	0	2025-03-30 02:51:12.32335
41	44	default	0	2025-03-30 02:54:30.477077
42	45	default	0	2025-03-30 02:56:25.845626
43	46	default	0	2025-03-30 03:04:39.441776
44	47	default	0	2025-03-30 03:55:36.965198
45	48	default	0	2025-03-30 05:30:24.276244
46	49	default	0	2025-03-30 06:43:15.386024
47	50	default	0	2025-03-30 06:57:00.597117
48	51	default	0	2025-04-02 04:28:35.855571
\.


--
-- Data for Name: solid_queue_recurring_executions; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_recurring_executions (id, job_id, task_key, run_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_recurring_tasks; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_recurring_tasks (id, key, schedule, command, class_name, arguments, queue_name, priority, static, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_scheduled_executions; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_scheduled_executions (id, job_id, queue_name, priority, scheduled_at, created_at) FROM stdin;
4	27	default	0	2025-03-29 02:03:26.896091	2025-03-29 02:02:56.929963
5	28	default	0	2025-03-29 03:48:19.096933	2025-03-29 03:47:19.127747
6	29	default	0	2025-03-29 03:57:14.005793	2025-03-29 03:56:14.032017
\.


--
-- Data for Name: solid_queue_semaphores; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.solid_queue_semaphores (id, key, value, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: support_requests; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.support_requests (id, user_id, message, created_at, updated_at, category, status, priority, source) FROM stdin;
1	2	Tengo un problema al crear plantillas.	2025-03-25 02:55:32.96757	2025-03-25 02:55:32.96757	\N	\N	\N	\N
2	2	Tengo un problema al crear plantillas.	2025-03-25 02:59:40.430573	2025-03-25 02:59:40.430573	\N	\N	\N	\N
3	2	Tengo un problema al crear plantillas.	2025-03-25 03:00:00.228605	2025-03-25 03:00:00.228605	\N	\N	\N	\N
4	2	Tengo un problema al crear plantillas.	2025-03-25 03:00:29.776792	2025-03-25 03:00:29.776792	\N	\N	\N	\N
5	2	Tengo un problema al crear plantillas.	2025-03-25 03:01:14.510277	2025-03-25 03:01:14.510277	\N	\N	\N	\N
6	2	Tengo un problema al crear plantillas.	2025-03-25 03:02:32.80766	2025-03-25 03:02:32.80766	\N	\N	\N	\N
7	2	Tengo un problema al crear plantillas.	2025-03-25 03:02:48.661246	2025-03-25 03:02:48.661246	\N	\N	\N	\N
8	2	Tengo un problema al crear plantillas.	2025-03-25 03:03:24.249238	2025-03-25 03:03:24.249238	\N	\N	\N	\N
9	2	Tengo un problema al crear plantillas.	2025-03-25 03:05:04.035691	2025-03-25 03:05:04.035691	\N	\N	\N	\N
10	2	Tengo un problema al crear plantillas.	2025-03-25 03:05:16.980261	2025-03-25 03:05:16.980261	\N	\N	\N	\N
11	2	No se cargan bien los créditos después de la campaña.	2025-03-25 03:06:44.26716	2025-03-25 03:06:44.26716	\N	\N	\N	\N
12	2	No puedo acceder a mi cuenta	2025-03-30 02:15:36.152625	2025-03-30 02:15:36.152625	\N	\N	\N	\N
13	2	No puedo acceder a mi cuenta	2025-03-30 02:21:04.079976	2025-03-30 02:21:04.079976	\N	\N	\N	\N
14	2	No puedo acceder a mi cuenta	2025-03-30 02:23:22.360625	2025-03-30 02:23:22.360625	\N	\N	\N	\N
15	2	No puedo acceder a mi cuenta	2025-03-30 02:24:01.438801	2025-03-30 02:24:01.438801	\N	\N	\N	\N
16	2	No puedo acceder a mi cuenta	2025-03-30 02:30:55.698321	2025-03-30 02:30:55.698321	\N	\N	\N	\N
17	2	No puedo acceder a mi cuenta	2025-03-30 02:32:53.175245	2025-03-30 02:32:53.175245	\N	\N	\N	\N
18	2	No puedo acceder a mi cuenta	2025-03-30 02:40:28.62271	2025-03-30 02:40:28.62271	\N	\N	\N	\N
19	2	No puedo acceder a mi cuenta	2025-03-30 02:41:37.946584	2025-03-30 02:41:37.946584	\N	\N	\N	\N
20	2	No puedo acceder a mi cuenta	2025-03-30 02:41:58.219597	2025-03-30 02:41:58.219597	\N	\N	\N	\N
21	2	No puedo acceder a mi cuenta	2025-03-30 02:42:55.506787	2025-03-30 02:42:55.506787	\N	\N	\N	\N
22	2	No puedo acceder a mi cuenta	2025-03-30 02:43:41.495704	2025-03-30 02:43:41.495704	\N	\N	\N	\N
23	2	No puedo acceder a mi cuenta	2025-03-30 02:44:16.166129	2025-03-30 02:44:16.166129	\N	\N	\N	\N
24	2	No puedo acceder a mi cuenta	2025-03-30 02:45:43.833753	2025-03-30 02:45:43.833753	\N	\N	\N	\N
25	2	No puedo acceder a mi cuenta	2025-03-30 02:51:12.283331	2025-03-30 02:51:12.283331	\N	\N	\N	\N
26	2	No puedo acceder a mi cuenta	2025-03-30 02:54:30.442839	2025-03-30 02:54:30.442839	\N	\N	\N	\N
27	2	No puedo acceder a mi cuenta	2025-03-30 02:56:25.786526	2025-03-30 02:56:25.786526	\N	\N	\N	\N
28	2	No puedo acceder a mi cuenta	2025-03-30 03:04:39.401459	2025-03-30 03:04:39.401459	\N	\N	\N	\N
29	2	No puedo acceder a mi cuenta	2025-03-30 03:55:36.926074	2025-03-30 03:55:36.926074	2	0	2	0
\.


--
-- Data for Name: template_blocks; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.template_blocks (id, template_id, block_type, html_content, settings, "position", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: templates; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.templates (id, name, description, category, user_id, created_at, updated_at, public, preview_image_url, html_content, theme) FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.transactions (id, amount, status, payment_method, user_id, credit_account_id, created_at, updated_at, campaign_id, campaign_uuid) FROM stdin;
1	10	consumed	credits	2	1	2025-03-14 04:25:45.010315	2025-03-14 04:25:45.010315	\N	\N
2	10	consumed	credits	2	1	2025-03-14 04:40:35.172626	2025-03-14 04:40:35.172626	\N	\N
3	10	consumed	credits	2	1	2025-03-14 04:41:05.445244	2025-03-14 04:41:05.445244	\N	\N
4	40	consumed	credits	2	1	2025-03-14 19:30:50.488922	2025-03-14 19:30:50.488922	\N	\N
5	40	consumed	campaign	2	1	2025-03-15 03:34:41.370375	2025-03-15 03:34:41.370375	1	024eba05-3608-4a52-ac71-5a569d4daebf
6	40	consumed	campaign	2	1	2025-03-15 03:39:06.443674	2025-03-15 03:39:06.443674	1	024eba05-3608-4a52-ac71-5a569d4daebf
7	40	consumed	campaign	2	1	2025-03-15 03:44:08.549383	2025-03-15 03:44:08.549383	1	024eba05-3608-4a52-ac71-5a569d4daebf
8	40	consumed	campaign	2	1	2025-03-15 03:45:49.069669	2025-03-15 03:45:49.069669	1	024eba05-3608-4a52-ac71-5a569d4daebf
9	40	consumed	campaign	2	1	2025-03-15 03:47:11.801888	2025-03-15 03:47:11.801888	1	024eba05-3608-4a52-ac71-5a569d4daebf
10	40	consumed	campaign	2	1	2025-03-15 03:48:08.148433	2025-03-15 03:48:08.148433	1	024eba05-3608-4a52-ac71-5a569d4daebf
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: chima
--

COPY public.users (id, email_address, password_digest, created_at, updated_at, role, plan_id, time_zone, remember_token, company, name, password_reset_token, password_reset_sent_at) FROM stdin;
2	admin@mail.com	$2a$12$aBL74ZdJdaCHUi2rBDzXcuNRPKhHYfeZ.bqqR9QqCOy9zKOqGFTse	2025-03-11 05:34:35.823912	2025-03-12 04:38:59.721403	0	3	\N	\N	\N	\N	\N	\N
4	tuemail@gmail.com	$2a$12$OxNCrmVoiJ/corkFia.IJ.xMNrpj9X841ZZWabJKJcFdbzW009.0i	2025-03-25 04:31:38.996346	2025-03-25 04:31:38.996346	0	\N	\N	\N	\N	\N	\N	\N
5	support@maileraction.com	$2a$12$i6fLe5v1QhExIPq5o8hHL.bdPoSSREAvG4LptL3cpxTKs2aWWLP0K	2025-03-25 04:34:17.418027	2025-03-25 04:34:17.418027	0	\N	\N	\N	\N	\N	\N	\N
3	info@maileraction.com	$2a$12$H/r3k/D/2L8IjgoWWL.PzOpdPHY6Gg.178s8HRUQrqKYH8jLhBYaS	2025-03-22 03:11:31.230246	2025-04-02 06:12:51.520419	4	\N	\N	\N	\N	\N	\N	\N
6	juan@example.com	$2a$12$YopYoU7SeJQcZVs5MbPy4Onnmvv7fdQ2Oq5uMmpLT1Pr4pfAMrQ2S	2025-04-10 04:32:53.710767	2025-04-10 04:32:53.710767	0	\N	America/Santiago	\N	\N	\N	\N	\N
7	pedrito@example.com	$2a$12$XIjzJwz0YrcME70rKcVsmu4nHuz9MMCGX1pvwloFvPyK6.2oqtif.	2025-04-11 07:04:20.463346	2025-04-11 07:04:20.463346	4	\N	\N	V0NZziYS_ZYbvKjWnJj6qQ	\N	\N	\N	\N
8	pedrito2@example.com	$2a$12$micFBijmQnT1vlHIj7VhU.gztugHsgzRE5LdvMkQLBFkTeoFEKnM.	2025-04-11 07:24:40.028725	2025-04-11 07:24:40.028725	4	\N	\N	v1wD7Wi-L-QL4P7WJzo8hw	\N	\N	\N	\N
1	chimasadus@gmail.com	$2a$12$7t6vpgzRI3iTCQV1FcQVn.DKBca8AKSaB1WJlorYN0j3n5qHSnfBK	2025-03-09 02:45:40.781431	2025-04-23 04:20:42.41839	0	\N	\N	\N	\N	\N	3OzKCb53bDsH22fVe3pJbQ	2025-04-15 04:56:19.416376
\.


--
-- Name: block_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.block_templates_id_seq', 1, false);


--
-- Name: bounces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.bounces_id_seq', 3, true);


--
-- Name: campaign_emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.campaign_emails_id_seq', 13, true);


--
-- Name: campaigns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.campaigns_id_seq', 7, true);


--
-- Name: credit_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.credit_accounts_id_seq', 2, true);


--
-- Name: email_blocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.email_blocks_id_seq', 43, true);


--
-- Name: email_error_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.email_error_logs_id_seq', 276, true);


--
-- Name: email_event_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.email_event_logs_id_seq', 277, true);


--
-- Name: email_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.email_logs_id_seq', 301, true);


--
-- Name: email_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.email_records_id_seq', 174, true);


--
-- Name: industries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.industries_id_seq', 41, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.notifications_id_seq', 11, true);


--
-- Name: plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.plans_id_seq', 3, true);


--
-- Name: public_email_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.public_email_records_id_seq', 14, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.roles_id_seq', 7, true);


--
-- Name: scrape_targets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.scrape_targets_id_seq', 1, false);


--
-- Name: scraping_sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.scraping_sources_id_seq', 1, false);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.sessions_id_seq', 24, true);


--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_blocked_executions_id_seq', 1, false);


--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_claimed_executions_id_seq', 26, true);


--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_failed_executions_id_seq', 2, true);


--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_jobs_id_seq', 51, true);


--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_pauses_id_seq', 1, false);


--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_processes_id_seq', 30, true);


--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_ready_executions_id_seq', 48, true);


--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_recurring_executions_id_seq', 1, false);


--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_recurring_tasks_id_seq', 1, false);


--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_scheduled_executions_id_seq', 6, true);


--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.solid_queue_semaphores_id_seq', 1, false);


--
-- Name: support_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.support_requests_id_seq', 29, true);


--
-- Name: template_blocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.template_blocks_id_seq', 2, true);


--
-- Name: templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.templates_id_seq', 9, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.transactions_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chima
--

SELECT pg_catalog.setval('public.users_id_seq', 8, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: block_templates block_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.block_templates
    ADD CONSTRAINT block_templates_pkey PRIMARY KEY (id);


--
-- Name: bounces bounces_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.bounces
    ADD CONSTRAINT bounces_pkey PRIMARY KEY (id);


--
-- Name: campaign_emails campaign_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaign_emails
    ADD CONSTRAINT campaign_emails_pkey PRIMARY KEY (id);


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (id);


--
-- Name: credit_accounts credit_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.credit_accounts
    ADD CONSTRAINT credit_accounts_pkey PRIMARY KEY (id);


--
-- Name: email_blocks email_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_blocks
    ADD CONSTRAINT email_blocks_pkey PRIMARY KEY (id);


--
-- Name: email_error_logs email_error_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_error_logs
    ADD CONSTRAINT email_error_logs_pkey PRIMARY KEY (id);


--
-- Name: email_event_logs email_event_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_event_logs
    ADD CONSTRAINT email_event_logs_pkey PRIMARY KEY (id);


--
-- Name: email_logs email_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_pkey PRIMARY KEY (id);


--
-- Name: email_records email_records_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_records
    ADD CONSTRAINT email_records_pkey PRIMARY KEY (id);


--
-- Name: industries industries_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.industries
    ADD CONSTRAINT industries_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: public_email_records public_email_records_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.public_email_records
    ADD CONSTRAINT public_email_records_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: scrape_targets scrape_targets_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.scrape_targets
    ADD CONSTRAINT scrape_targets_pkey PRIMARY KEY (id);


--
-- Name: scraping_sources scraping_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.scraping_sources
    ADD CONSTRAINT scraping_sources_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_blocked_executions solid_queue_blocked_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_blocked_executions
    ADD CONSTRAINT solid_queue_blocked_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_claimed_executions solid_queue_claimed_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_claimed_executions
    ADD CONSTRAINT solid_queue_claimed_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_failed_executions solid_queue_failed_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_failed_executions
    ADD CONSTRAINT solid_queue_failed_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_jobs solid_queue_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_jobs
    ADD CONSTRAINT solid_queue_jobs_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_pauses solid_queue_pauses_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_pauses
    ADD CONSTRAINT solid_queue_pauses_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_processes solid_queue_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_processes
    ADD CONSTRAINT solid_queue_processes_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_ready_executions solid_queue_ready_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_ready_executions
    ADD CONSTRAINT solid_queue_ready_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_recurring_executions solid_queue_recurring_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_recurring_executions
    ADD CONSTRAINT solid_queue_recurring_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_recurring_tasks solid_queue_recurring_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_recurring_tasks
    ADD CONSTRAINT solid_queue_recurring_tasks_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_scheduled_executions solid_queue_scheduled_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions
    ADD CONSTRAINT solid_queue_scheduled_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_semaphores solid_queue_semaphores_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_semaphores
    ADD CONSTRAINT solid_queue_semaphores_pkey PRIMARY KEY (id);


--
-- Name: support_requests support_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.support_requests
    ADD CONSTRAINT support_requests_pkey PRIMARY KEY (id);


--
-- Name: template_blocks template_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.template_blocks
    ADD CONSTRAINT template_blocks_pkey PRIMARY KEY (id);


--
-- Name: templates templates_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_block_templates_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_block_templates_on_user_id ON public.block_templates USING btree (user_id);


--
-- Name: index_bounces_on_campaign_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_bounces_on_campaign_id ON public.bounces USING btree (campaign_id);


--
-- Name: index_bounces_on_campaign_uuid; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_bounces_on_campaign_uuid ON public.bounces USING btree (campaign_uuid);


--
-- Name: index_bounces_on_email_record_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_bounces_on_email_record_id ON public.bounces USING btree (email_record_id);


--
-- Name: index_campaign_emails_on_campaign_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_campaign_emails_on_campaign_id ON public.campaign_emails USING btree (campaign_id);


--
-- Name: index_campaign_emails_on_campaign_uuid; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_campaign_emails_on_campaign_uuid ON public.campaign_emails USING btree (campaign_uuid);


--
-- Name: index_campaign_emails_on_email_record_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_campaign_emails_on_email_record_id ON public.campaign_emails USING btree (email_record_id);


--
-- Name: index_campaigns_on_industry_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_campaigns_on_industry_id ON public.campaigns USING btree (industry_id);


--
-- Name: index_campaigns_on_template_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_campaigns_on_template_id ON public.campaigns USING btree (template_id);


--
-- Name: index_campaigns_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_campaigns_on_user_id ON public.campaigns USING btree (user_id);


--
-- Name: index_campaigns_on_uuid; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_campaigns_on_uuid ON public.campaigns USING btree (uuid);


--
-- Name: index_credit_accounts_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_credit_accounts_on_user_id ON public.credit_accounts USING btree (user_id);


--
-- Name: index_email_blocks_on_block_template_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_blocks_on_block_template_id ON public.email_blocks USING btree (block_template_id);


--
-- Name: index_email_blocks_on_campaign_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_blocks_on_campaign_id ON public.email_blocks USING btree (campaign_id);


--
-- Name: index_email_blocks_on_campaign_uuid; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_blocks_on_campaign_uuid ON public.email_blocks USING btree (campaign_uuid);


--
-- Name: index_email_blocks_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_blocks_on_user_id ON public.email_blocks USING btree (user_id);


--
-- Name: index_email_error_logs_on_campaign_uuid; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_error_logs_on_campaign_uuid ON public.email_error_logs USING btree (campaign_uuid);


--
-- Name: index_email_event_logs_on_campaign_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_event_logs_on_campaign_id ON public.email_event_logs USING btree (campaign_id);


--
-- Name: index_email_event_logs_on_campaign_uuid; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_event_logs_on_campaign_uuid ON public.email_event_logs USING btree (campaign_uuid);


--
-- Name: index_email_event_logs_on_email; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_event_logs_on_email ON public.email_event_logs USING btree (email);


--
-- Name: index_email_event_logs_on_event_type; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_event_logs_on_event_type ON public.email_event_logs USING btree (event_type);


--
-- Name: index_email_logs_on_campaign_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_logs_on_campaign_id ON public.email_logs USING btree (campaign_id);


--
-- Name: index_email_logs_on_campaign_uuid; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_logs_on_campaign_uuid ON public.email_logs USING btree (campaign_uuid);


--
-- Name: index_email_logs_on_email_record_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_logs_on_email_record_id ON public.email_logs USING btree (email_record_id);


--
-- Name: index_email_records_on_industry_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_email_records_on_industry_id ON public.email_records USING btree (industry_id);


--
-- Name: index_notifications_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_notifications_on_user_id ON public.notifications USING btree (user_id);


--
-- Name: index_public_email_records_on_industry_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_public_email_records_on_industry_id ON public.public_email_records USING btree (industry_id);


--
-- Name: index_sessions_on_session_token; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_sessions_on_session_token ON public.sessions USING btree (session_token);


--
-- Name: index_sessions_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_sessions_on_user_id ON public.sessions USING btree (user_id);


--
-- Name: index_solid_queue_blocked_executions_for_maintenance; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_blocked_executions_for_maintenance ON public.solid_queue_blocked_executions USING btree (expires_at, concurrency_key);


--
-- Name: index_solid_queue_blocked_executions_for_release; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_blocked_executions_for_release ON public.solid_queue_blocked_executions USING btree (concurrency_key, priority, job_id);


--
-- Name: index_solid_queue_blocked_executions_on_job_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_blocked_executions_on_job_id ON public.solid_queue_blocked_executions USING btree (job_id);


--
-- Name: index_solid_queue_claimed_executions_on_job_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_claimed_executions_on_job_id ON public.solid_queue_claimed_executions USING btree (job_id);


--
-- Name: index_solid_queue_claimed_executions_on_process_id_and_job_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_claimed_executions_on_process_id_and_job_id ON public.solid_queue_claimed_executions USING btree (process_id, job_id);


--
-- Name: index_solid_queue_dispatch_all; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_dispatch_all ON public.solid_queue_scheduled_executions USING btree (scheduled_at, priority, job_id);


--
-- Name: index_solid_queue_failed_executions_on_job_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_failed_executions_on_job_id ON public.solid_queue_failed_executions USING btree (job_id);


--
-- Name: index_solid_queue_jobs_for_alerting; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_jobs_for_alerting ON public.solid_queue_jobs USING btree (scheduled_at, finished_at);


--
-- Name: index_solid_queue_jobs_for_filtering; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_jobs_for_filtering ON public.solid_queue_jobs USING btree (queue_name, finished_at);


--
-- Name: index_solid_queue_jobs_on_active_job_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_jobs_on_active_job_id ON public.solid_queue_jobs USING btree (active_job_id);


--
-- Name: index_solid_queue_jobs_on_class_name; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_jobs_on_class_name ON public.solid_queue_jobs USING btree (class_name);


--
-- Name: index_solid_queue_jobs_on_finished_at; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_jobs_on_finished_at ON public.solid_queue_jobs USING btree (finished_at);


--
-- Name: index_solid_queue_pauses_on_queue_name; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_pauses_on_queue_name ON public.solid_queue_pauses USING btree (queue_name);


--
-- Name: index_solid_queue_poll_all; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_poll_all ON public.solid_queue_ready_executions USING btree (priority, job_id);


--
-- Name: index_solid_queue_poll_by_queue; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_poll_by_queue ON public.solid_queue_ready_executions USING btree (queue_name, priority, job_id);


--
-- Name: index_solid_queue_processes_on_last_heartbeat_at; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_processes_on_last_heartbeat_at ON public.solid_queue_processes USING btree (last_heartbeat_at);


--
-- Name: index_solid_queue_processes_on_name_and_supervisor_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_processes_on_name_and_supervisor_id ON public.solid_queue_processes USING btree (name, supervisor_id);


--
-- Name: index_solid_queue_processes_on_supervisor_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_processes_on_supervisor_id ON public.solid_queue_processes USING btree (supervisor_id);


--
-- Name: index_solid_queue_ready_executions_on_job_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_ready_executions_on_job_id ON public.solid_queue_ready_executions USING btree (job_id);


--
-- Name: index_solid_queue_recurring_executions_on_job_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_recurring_executions_on_job_id ON public.solid_queue_recurring_executions USING btree (job_id);


--
-- Name: index_solid_queue_recurring_executions_on_task_key_and_run_at; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_recurring_executions_on_task_key_and_run_at ON public.solid_queue_recurring_executions USING btree (task_key, run_at);


--
-- Name: index_solid_queue_recurring_tasks_on_key; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_recurring_tasks_on_key ON public.solid_queue_recurring_tasks USING btree (key);


--
-- Name: index_solid_queue_recurring_tasks_on_static; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_recurring_tasks_on_static ON public.solid_queue_recurring_tasks USING btree (static);


--
-- Name: index_solid_queue_scheduled_executions_on_job_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_scheduled_executions_on_job_id ON public.solid_queue_scheduled_executions USING btree (job_id);


--
-- Name: index_solid_queue_semaphores_on_expires_at; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_semaphores_on_expires_at ON public.solid_queue_semaphores USING btree (expires_at);


--
-- Name: index_solid_queue_semaphores_on_key; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_solid_queue_semaphores_on_key ON public.solid_queue_semaphores USING btree (key);


--
-- Name: index_solid_queue_semaphores_on_key_and_value; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_solid_queue_semaphores_on_key_and_value ON public.solid_queue_semaphores USING btree (key, value);


--
-- Name: index_support_requests_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_support_requests_on_user_id ON public.support_requests USING btree (user_id);


--
-- Name: index_template_blocks_on_template_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_template_blocks_on_template_id ON public.template_blocks USING btree (template_id);


--
-- Name: index_templates_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_templates_on_user_id ON public.templates USING btree (user_id);


--
-- Name: index_transactions_on_campaign_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_transactions_on_campaign_id ON public.transactions USING btree (campaign_id);


--
-- Name: index_transactions_on_campaign_uuid; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_transactions_on_campaign_uuid ON public.transactions USING btree (campaign_uuid);


--
-- Name: index_transactions_on_credit_account_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_transactions_on_credit_account_id ON public.transactions USING btree (credit_account_id);


--
-- Name: index_transactions_on_user_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_transactions_on_user_id ON public.transactions USING btree (user_id);


--
-- Name: index_users_on_plan_id; Type: INDEX; Schema: public; Owner: chima
--

CREATE INDEX index_users_on_plan_id ON public.users USING btree (plan_id);


--
-- Name: index_users_on_remember_token; Type: INDEX; Schema: public; Owner: chima
--

CREATE UNIQUE INDEX index_users_on_remember_token ON public.users USING btree (remember_token);


--
-- Name: support_requests fk_rails_03ae9ca37e; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.support_requests
    ADD CONSTRAINT fk_rails_03ae9ca37e FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: email_blocks fk_rails_07880796dd; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_blocks
    ADD CONSTRAINT fk_rails_07880796dd FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id);


--
-- Name: bounces fk_rails_163ad8ab75; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.bounces
    ADD CONSTRAINT fk_rails_163ad8ab75 FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id);


--
-- Name: transactions fk_rails_19cc35efd9; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_rails_19cc35efd9 FOREIGN KEY (credit_account_id) REFERENCES public.credit_accounts(id);


--
-- Name: campaigns fk_rails_1f3d159e40; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT fk_rails_1f3d159e40 FOREIGN KEY (template_id) REFERENCES public.templates(id);


--
-- Name: campaign_emails fk_rails_2eb79f1eff; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaign_emails
    ADD CONSTRAINT fk_rails_2eb79f1eff FOREIGN KEY (email_record_id) REFERENCES public.email_records(id);


--
-- Name: solid_queue_recurring_executions fk_rails_318a5533ed; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_recurring_executions
    ADD CONSTRAINT fk_rails_318a5533ed FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: solid_queue_failed_executions fk_rails_39bbc7a631; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_failed_executions
    ADD CONSTRAINT fk_rails_39bbc7a631 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: email_logs fk_rails_3ac6891ec4; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT fk_rails_3ac6891ec4 FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id);


--
-- Name: template_blocks fk_rails_41ca4c9262; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.template_blocks
    ADD CONSTRAINT fk_rails_41ca4c9262 FOREIGN KEY (template_id) REFERENCES public.templates(id);


--
-- Name: email_event_logs fk_rails_4a0add7d4b; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_event_logs
    ADD CONSTRAINT fk_rails_4a0add7d4b FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id);


--
-- Name: solid_queue_blocked_executions fk_rails_4cd34e2228; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_blocked_executions
    ADD CONSTRAINT fk_rails_4cd34e2228 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: credit_accounts fk_rails_530e99800f; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.credit_accounts
    ADD CONSTRAINT fk_rails_530e99800f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: block_templates fk_rails_5a57055667; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.block_templates
    ADD CONSTRAINT fk_rails_5a57055667 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: templates fk_rails_68700cea77; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT fk_rails_68700cea77 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: email_blocks fk_rails_6f75a5b43b; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_blocks
    ADD CONSTRAINT fk_rails_6f75a5b43b FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sessions fk_rails_758836b4f0; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_758836b4f0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transactions fk_rails_77364e6416; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_rails_77364e6416 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: email_logs fk_rails_797ec37a4a; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT fk_rails_797ec37a4a FOREIGN KEY (email_record_id) REFERENCES public.email_records(id);


--
-- Name: solid_queue_ready_executions fk_rails_81fcbd66af; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_ready_executions
    ADD CONSTRAINT fk_rails_81fcbd66af FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: campaign_emails fk_rails_886575590d; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaign_emails
    ADD CONSTRAINT fk_rails_886575590d FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id);


--
-- Name: public_email_records fk_rails_99e7e0cfbc; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.public_email_records
    ADD CONSTRAINT fk_rails_99e7e0cfbc FOREIGN KEY (industry_id) REFERENCES public.industries(id);


--
-- Name: solid_queue_claimed_executions fk_rails_9cfe4d4944; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_claimed_executions
    ADD CONSTRAINT fk_rails_9cfe4d4944 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: campaigns fk_rails_9eb8249bf2; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT fk_rails_9eb8249bf2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notifications fk_rails_b080fb4855; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_b080fb4855 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: email_records fk_rails_b6674840ef; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_records
    ADD CONSTRAINT fk_rails_b6674840ef FOREIGN KEY (industry_id) REFERENCES public.industries(id);


--
-- Name: solid_queue_scheduled_executions fk_rails_c4316f352d; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions
    ADD CONSTRAINT fk_rails_c4316f352d FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: users fk_rails_c7d01481e8; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_c7d01481e8 FOREIGN KEY (plan_id) REFERENCES public.plans(id);


--
-- Name: campaigns fk_rails_c88caadf39; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT fk_rails_c88caadf39 FOREIGN KEY (industry_id) REFERENCES public.industries(id);


--
-- Name: bounces fk_rails_e3fb20d34b; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.bounces
    ADD CONSTRAINT fk_rails_e3fb20d34b FOREIGN KEY (email_record_id) REFERENCES public.email_records(id);


--
-- Name: transactions fk_rails_e8c97433d8; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_rails_e8c97433d8 FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id);


--
-- Name: email_blocks fk_rails_fe10251eac; Type: FK CONSTRAINT; Schema: public; Owner: chima
--

ALTER TABLE ONLY public.email_blocks
    ADD CONSTRAINT fk_rails_fe10251eac FOREIGN KEY (block_template_id) REFERENCES public.block_templates(id);


--
-- PostgreSQL database dump complete
--

