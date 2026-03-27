--
-- PostgreSQL database dump
--


-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.8 (Debian 17.8-1.pgdg11+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--




--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--



--
-- Name: assay_unit; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.assay_unit AS ENUM (
    'dilution',
    'au_ml',
    'bau_ml',
    'mg_ml',
    'percent',
    'pnu',
    'unknown'
);



--
-- Name: company_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.company_type AS ENUM (
    'pharmacy',
    'provider',
    'ingredient_supplier'
);



--
-- Name: document_type_order; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.document_type_order AS ENUM (
    'new_rx',
    'refill_rx',
    'not_rx',
    'otc',
    'auto_rx',
    'other',
    'rx_on_file'
);



--
-- Name: document_type_patient; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.document_type_patient AS ENUM (
    'agreement',
    'hipaa_signature',
    'medical_record',
    'power_of_attorney',
    'release_of_information',
    'other'
);



--
-- Name: dosage_form_enum; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.dosage_form_enum AS ENUM (
    'solution'
);



--
-- Name: drug_schedule; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.drug_schedule AS ENUM (
    'L'
);



--
-- Name: event_source; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.event_source AS ENUM (
    'unknown',
    'admin',
    'admin_command',
    'ehr',
    'allergy_choices',
    'graphql'
);



--
-- Name: event_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.event_type AS ENUM (
    'user_registered',
    'user_password_reset_request',
    'user_password_reset',
    'user_email_changed',
    'user_phone_changed',
    'user_name_changed',
    'user_passwordless_login_request',
    'user_logged_in',
    'patient_medical_document',
    'patient_tag_added',
    'patient_tag_removed',
    'order_status_changed'
);



--
-- Name: fax_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.fax_type AS ENUM (
    'prescription',
    'test',
    'other'
);



--
-- Name: fill_order_source; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.fill_order_source AS ENUM (
    'api',
    'fax'
);



--
-- Name: fill_order_webhook_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.fill_order_webhook_type AS ENUM (
    'new_order',
    'unknown'
);



--
-- Name: gender; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.gender AS ENUM (
    'male',
    'female',
    'other',
    'decline_to_state',
    'unknown'
);



--
-- Name: ingredient_form; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.ingredient_form AS ENUM (
    'capsule',
    'solution',
    'suspension',
    'tablet'
);



--
-- Name: ingredient_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.ingredient_type AS ENUM (
    'active',
    'activated',
    'filler'
);



--
-- Name: intake_audit_event_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.intake_audit_event_type AS ENUM (
    'review_started',
    'review_completed',
    'routing_corrected',
    'data_edited'
);



--
-- Name: intake_source_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.intake_source_type AS ENUM (
    'manual_upload',
    'fax'
);



--
-- Name: intake_status; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.intake_status AS ENUM (
    'queued',
    'processing',
    'review_required',
    'order_created',
    'rejected',
    'complete',
    'failed'
);



--
-- Name: label_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.label_type AS ENUM (
    'shipping_label',
    'return_label'
);



--
-- Name: measurement_unit; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.measurement_unit AS ENUM (
    'ml',
    'l',
    'g'
);



--
-- Name: note_type_order; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.note_type_order AS ENUM (
    'manual_note',
    'pickup_note',
    'consultation_note',
    'status_update',
    'problem'
);



--
-- Name: note_type_patient; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.note_type_patient AS ENUM (
    'general',
    'memo',
    'communication',
    'other'
);



--
-- Name: order_status; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.order_status AS ENUM (
    'not_filled',
    'labels_printed',
    'waiting',
    'in_progress',
    'consultation_required',
    'verified',
    'shipping_pickup',
    'shipped',
    'unverified',
    'hold_file',
    'rejected',
    'shipping_error'
);



--
-- Name: order_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.order_type AS ENUM (
    'new_rx',
    'refill'
);



--
-- Name: patient_species; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.patient_species AS ENUM (
    'human',
    'unknown'
);



--
-- Name: physician_title; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.physician_title AS ENUM (
    'UNK',
    'DO',
    'NPC',
    'MD',
    'NP',
    'PAC',
    'FNP',
    'FNPC',
    'FNPBC'
);



--
-- Name: postal_carrier; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.postal_carrier AS ENUM (
    'unknown',
    'usps',
    'ups',
    'fedex',
    'easypost'
);



--
-- Name: prescription_kind; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.prescription_kind AS ENUM (
    'unknown',
    'initial',
    'renewal',
    'formula_modification'
);



--
-- Name: prescription_source; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.prescription_source AS ENUM (
    'api_rest',
    'api_graphql',
    'fax'
);



--
-- Name: prescription_status; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.prescription_status AS ENUM (
    'ready',
    'review_required',
    'rejected'
);



--
-- Name: prescription_webhook_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.prescription_webhook_type AS ENUM (
    'new_order',
    'pms_prescription_create',
    'unknown',
    'pms_prescription_update'
);



--
-- Name: product_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.product_type AS ENUM (
    'compound'
);



--
-- Name: product_type_enum; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.product_type_enum AS ENUM (
    'non_standardized_allergenic',
    'standardized_allergenic'
);



--
-- Name: routing_method; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.routing_method AS ENUM (
    'textract',
    'bedrock',
    'review'
);



--
-- Name: shipping_provider; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.shipping_provider AS ENUM (
    'stamps_com',
    'shipping_station'
);



--
-- Name: shipping_status; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.shipping_status AS ENUM (
    'submit_carrier',
    'on_hold',
    'problem',
    'pending',
    'in_transit',
    'delivered',
    'voided'
);



--
-- Name: state_modality; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.state_modality AS ENUM (
    'sync_audio_state',
    'sync_video_state',
    'async_state'
);



--
-- Name: user_role; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.user_role AS ENUM (
    'admin',
    'pharmacist',
    'technician',
    'partner',
    'robot'
);



--
-- Name: webhook_source; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.webhook_source AS ENUM (
    'shipstation'
);



--
-- Name: webhook_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.webhook_type AS ENUM (
    'unknown'
);



SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts_company; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.accounts_company (
    address_line_1 character varying(255),
    address_line_2 character varying(255),
    address_line_3 character varying(255),
    city character varying(100),
    state character varying(2),
    zipcode character varying(10),
    address_history jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    type public.company_type NOT NULL,
    phone character varying(100) NOT NULL,
    fax character varying(100) NOT NULL,
    email character varying(254) NOT NULL,
    email2 character varying(254) NOT NULL,
    memo text NOT NULL,
    memo_shipping text NOT NULL,
    deleted_at timestamp with time zone,
    legal_name character varying(255) NOT NULL,
    is_active boolean NOT NULL
);



--
-- Name: accounts_pharmacist; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.accounts_pharmacist (
    user_ptr_id uuid NOT NULL
);



--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.accounts_user (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    email character varying(254) NOT NULL,
    phone character varying(255) NOT NULL,
    role public.user_role NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    middle_name character varying(150) NOT NULL,
    token_valid_min_time timestamp with time zone NOT NULL,
    additional_details jsonb NOT NULL,
    state character varying(2) NOT NULL,
    last_seen timestamp with time zone,
    company_id uuid,
    deleted_at timestamp with time zone
);



--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.accounts_user_groups (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    group_id integer NOT NULL
);



--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.accounts_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.accounts_user_user_permissions (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    permission_id integer NOT NULL
);



--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.accounts_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);



--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);



--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);



--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id uuid NOT NULL
);



--
-- Name: billing_billinginvoice; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.billing_billinginvoice (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    pharmacy_company_id uuid NOT NULL,
    provider_company_id uuid NOT NULL
);



--
-- Name: billing_billinginvoice_transactions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.billing_billinginvoice_transactions (
    id bigint NOT NULL,
    billinginvoice_id uuid NOT NULL,
    transaction_id uuid NOT NULL
);



--
-- Name: billing_billinginvoice_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.billing_billinginvoice_transactions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.billing_billinginvoice_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: billing_transaction; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.billing_transaction (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    sequence_id integer NOT NULL,
    completed_date timestamp with time zone,
    effective_date timestamp with time zone,
    transaction_date timestamp with time zone,
    transaction_reference_id character varying(255),
    transaction_memo text NOT NULL,
    memo text,
    is_successful boolean NOT NULL,
    created_by_id uuid NOT NULL,
    order_id uuid NOT NULL,
    pharmacy_company_id uuid NOT NULL,
    provider_company_id uuid NOT NULL,
    CONSTRAINT billing_transaction_sequence_id_check CHECK ((sequence_id >= 0))
);



--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id uuid NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);



--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);



--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);



--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);



--
-- Name: faxorder_bedrockcache; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.faxorder_bedrockcache (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    crop_hash character varying(64) NOT NULL,
    model_id character varying(100) NOT NULL,
    prompt_profile character varying(100) NOT NULL,
    response_data jsonb NOT NULL,
    tokens_input integer NOT NULL,
    tokens_output integer NOT NULL
);



--
-- Name: faxorder_faxauditevent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.faxorder_faxauditevent (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    event_type public.intake_audit_event_type NOT NULL,
    review_started_at timestamp with time zone,
    review_completed_at timestamp with time zone,
    changes jsonb NOT NULL,
    memo text NOT NULL,
    additional_details jsonb NOT NULL,
    user_id uuid NOT NULL,
    fax_document_id uuid NOT NULL
);



--
-- Name: faxorder_faxdocument; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.faxorder_faxdocument (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    status public.intake_status NOT NULL,
    fax_type public.fax_type,
    source_type public.intake_source_type NOT NULL,
    received_at timestamp with time zone NOT NULL,
    source_file_url character varying(500) NOT NULL,
    template_family character varying(100) NOT NULL,
    template_version character varying(50) NOT NULL,
    routing_confidence double precision,
    routing_method public.routing_method,
    normalized_data jsonb NOT NULL,
    extraction_data jsonb NOT NULL,
    bedrock_data jsonb NOT NULL,
    preprocess_meta jsonb NOT NULL,
    review_reasons jsonb NOT NULL,
    review_regions jsonb NOT NULL,
    reviewed_at timestamp with time zone,
    processing_started_at timestamp with time zone,
    processing_completed_at timestamp with time zone,
    error_message text NOT NULL,
    memo text NOT NULL,
    additional_details jsonb NOT NULL,
    prescription_kind public.prescription_kind,
    pharmacy_company_id uuid,
    prescription_id uuid,
    provider_company_id uuid,
    reviewed_by_id uuid,
    template_config_id uuid,
    fax_receiver character varying(20),
    fax_sender character varying(20),
    order_id uuid,
    document_id character varying(20),
    sequence_id integer,
    number_of_pages integer NOT NULL,
    CONSTRAINT faxorder_faxdocument_number_of_pages_check CHECK ((number_of_pages >= 0)),
    CONSTRAINT faxorder_faxdocument_sequence_id_check CHECK ((sequence_id >= 0))
);



--
-- Name: faxorder_faxdocumentpage; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.faxorder_faxdocumentpage (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    page_number integer NOT NULL,
    page_raw_url character varying(500) NOT NULL,
    page_clean_url character varying(500) NOT NULL,
    preprocess_meta jsonb NOT NULL,
    extraction_data jsonb NOT NULL,
    fax_document_id uuid NOT NULL,
    order_id uuid,
    CONSTRAINT faxorder_faxdocumentpage_page_number_check CHECK ((page_number >= 0))
);



--
-- Name: faxorder_faxtemplateconfig; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.faxorder_faxtemplateconfig (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    family character varying(100) NOT NULL,
    version character varying(50) NOT NULL,
    is_active boolean NOT NULL,
    anchor_phrases jsonb NOT NULL,
    routing_confidence_threshold double precision NOT NULL,
    bundle_definitions jsonb NOT NULL,
    textract_bundles jsonb NOT NULL,
    validation_overrides jsonb NOT NULL,
    qty_rules jsonb NOT NULL,
    prescription_kinds jsonb NOT NULL,
    memo text NOT NULL,
    pharmacy_company_id uuid,
    provider_company_id uuid
);



--
-- Name: faxorder_faxwebhookrequest; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.faxorder_faxwebhookrequest (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    webhook_data jsonb NOT NULL,
    processed_at timestamp with time zone,
    received_at timestamp with time zone NOT NULL,
    context text,
    user_agent text,
    ip_address inet,
    job_id character varying(100) NOT NULL,
    transaction_id character varying(100) NOT NULL,
    sender_fax character varying(50) NOT NULL,
    receiver_fax character varying(50) NOT NULL,
    page_count integer,
    duration_seconds integer,
    fax_received_time timestamp with time zone,
    processing_error text NOT NULL,
    fax_document_id uuid,
    user_id uuid,
    CONSTRAINT faxorder_faxwebhookrequest_duration_seconds_check CHECK ((duration_seconds >= 0)),
    CONSTRAINT faxorder_faxwebhookrequest_page_count_check CHECK ((page_count >= 0))
);



--
-- Name: ingredients_ingredient; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredients_ingredient (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    deleted_at timestamp with time zone,
    name character varying(255) NOT NULL,
    measurement_unit public.measurement_unit NOT NULL,
    generic_name character varying(255) NOT NULL,
    form public.ingredient_form NOT NULL,
    memo text,
    data jsonb NOT NULL,
    ndc_id uuid,
    ingredient_type public.ingredient_type NOT NULL
);



--
-- Name: ingredients_ingredientmap; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredients_ingredientmap (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    original_name character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    ingredient_id uuid NOT NULL,
    pharmacy_company_id uuid,
    provider_company_id uuid,
    user_id uuid NOT NULL,
    is_do_not_map boolean NOT NULL,
    treatment_kind character varying(13)
);



--
-- Name: ingredients_inventory; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredients_inventory (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    deleted_at timestamp with time zone,
    lot_id character varying(20) NOT NULL,
    is_active boolean NOT NULL,
    expiration_date date,
    memo text,
    data jsonb NOT NULL,
    ingredient_id uuid NOT NULL,
    pharmacy_company_id uuid,
    assay_r1 double precision NOT NULL,
    assay_r2 double precision NOT NULL,
    assay_unit public.assay_unit NOT NULL,
    ndc_code character varying(20),
    dilution_data jsonb NOT NULL,
    dilution_data_text text NOT NULL
);



--
-- Name: ingredients_ndcpharmaceutical; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredients_ndcpharmaceutical (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    product_id character varying(50) NOT NULL,
    ndc character varying(20) NOT NULL,
    product_type_name public.product_type_enum,
    proprietary_name text NOT NULL,
    proprietary_name_suffix character varying(255) NOT NULL,
    nonproprietary_name text NOT NULL,
    dosage_form_name public.dosage_form_enum,
    route_name text NOT NULL,
    start_marketing_date date,
    end_marketing_date date,
    application_number character varying(50) NOT NULL,
    substance_name text NOT NULL,
    active_numerator_strength numeric(10,4),
    active_ingredient_unit character varying(100) NOT NULL,
    pharm_classes text NOT NULL,
    ndc_exclude_flag boolean NOT NULL,
    listing_record_certified_through date,
    manufacturer_id uuid
);



--
-- Name: orders_fillorder; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_fillorder (
    address_line_1 character varying(255) NOT NULL,
    address_line_2 character varying(255) NOT NULL,
    address_line_3 character varying(255) NOT NULL,
    city character varying(100) NOT NULL,
    state character varying(2) NOT NULL,
    zipcode character varying(10) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    sequence_id integer NOT NULL,
    deleted_at timestamp with time zone,
    fill_id character varying(20),
    address_verified_at timestamp with time zone,
    order_date date,
    order_type public.order_type NOT NULL,
    order_status public.order_status NOT NULL,
    memo text NOT NULL,
    is_problem_with_order boolean NOT NULL,
    is_hold_for_payment boolean NOT NULL,
    is_active boolean NOT NULL,
    verified_at timestamp with time zone,
    manifest_url character varying(500) NOT NULL,
    pharmacist_id uuid,
    pharmacy_company_id uuid,
    prescription_id uuid NOT NULL,
    provider_company_id uuid,
    fill_number integer,
    patient_id uuid,
    labels_pdf_url character varying(500),
    additional_details jsonb NOT NULL,
    locked_by_id uuid,
    locked_until timestamp with time zone,
    verified_by_id uuid,
    has_related_orders boolean NOT NULL,
    parent_fill_order_id uuid,
    next_shipment_date date,
    next_shipment_date_text text,
    technician_id uuid,
    order_source public.fill_order_source NOT NULL,
    CONSTRAINT orders_fillorder_refill_number_check CHECK ((fill_number >= 0)),
    CONSTRAINT orders_fillorder_sequence_id_check CHECK ((sequence_id >= 0))
);



--
-- Name: orders_fillorderapirequest; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_fillorderapirequest (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    webhook_data jsonb NOT NULL,
    processed_at timestamp with time zone,
    received_at timestamp with time zone NOT NULL,
    context text,
    user_agent text NOT NULL,
    ip_address inet,
    webhook_type public.fill_order_webhook_type NOT NULL,
    fill_order_id uuid,
    user_id uuid
);



--
-- Name: orders_fillorderingredient; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_fillorderingredient (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    qty double precision NOT NULL,
    inventory_id uuid,
    order_id uuid NOT NULL,
    ingredient_order integer,
    dilution_number integer,
    dilution_value character varying(50) NOT NULL,
    dilution_display character varying(50) NOT NULL,
    lot_id character varying(20) NOT NULL,
    original_dilution_number integer,
    original_dilution_value character varying(50) NOT NULL,
    original_ingredient_display character varying(100) NOT NULL,
    original_ingredient_order integer,
    original_ingredient_qty character varying(50) NOT NULL,
    deleted_at timestamp with time zone,
    is_active boolean NOT NULL,
    CONSTRAINT orders_fillorderingredient_dilution_number_check CHECK ((dilution_number >= 0)),
    CONSTRAINT orders_fillorderingredient_ingredient_order_check CHECK ((ingredient_order >= 0)),
    CONSTRAINT orders_fillorderingredient_original_dilution_number_check CHECK ((original_dilution_number >= 0)),
    CONSTRAINT orders_fillorderingredient_original_ingredient_order_check CHECK ((original_ingredient_order >= 0))
);



--
-- Name: orders_fillorderingredientevent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_fillorderingredientevent (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    deleted_at timestamp with time zone,
    additional_details jsonb NOT NULL,
    data_old jsonb NOT NULL,
    data_new jsonb NOT NULL,
    reason text NOT NULL,
    fill_order_ingredient_id uuid NOT NULL,
    inventory_id uuid,
    user_id uuid
);



--
-- Name: orders_fillorderstatusevent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_fillorderstatusevent (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    additional_details jsonb NOT NULL,
    status_old public.order_status,
    status_new public.order_status NOT NULL,
    fill_order_id uuid NOT NULL,
    user_id uuid,
    reason text NOT NULL
);



--
-- Name: orders_orderdocument; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_orderdocument (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    subject character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    document character varying(100) NOT NULL,
    document_type public.document_type_order NOT NULL,
    fill_order_id uuid NOT NULL,
    user_id uuid NOT NULL,
    note_id uuid,
    s3_url character varying(200) NOT NULL
);



--
-- Name: orders_ordernote; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_ordernote (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    subject character varying(255) NOT NULL,
    text text,
    is_active boolean NOT NULL,
    note_type public.note_type_order NOT NULL,
    data jsonb NOT NULL,
    fill_order_id uuid NOT NULL,
    user_id uuid NOT NULL,
    additional_details jsonb NOT NULL
);



--
-- Name: orders_shipment; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_shipment (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    shipped_at date NOT NULL,
    description text NOT NULL,
    carrier public.postal_carrier NOT NULL,
    tracking_number character varying(255) NOT NULL,
    order_id uuid NOT NULL,
    pharmacy_id uuid NOT NULL,
    prescription_id uuid,
    dimension_data jsonb NOT NULL,
    shipping_status public.shipping_status NOT NULL,
    carrier_status character varying(10) NOT NULL,
    deleted_at timestamp with time zone,
    status_updated_at timestamp with time zone NOT NULL
);



--
-- Name: orders_shipmentlabel; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_shipmentlabel (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    provider public.shipping_provider NOT NULL,
    label_type public.label_type NOT NULL,
    label_zpl_url character varying(200) NOT NULL,
    tracking_number character varying(255) NOT NULL,
    label_id character varying(255) NOT NULL,
    api_request_data jsonb NOT NULL,
    api_response_data jsonb NOT NULL,
    is_successful boolean NOT NULL,
    error_message text NOT NULL,
    postage_cost numeric(10,2),
    service_type character varying(100) NOT NULL,
    package_weight_oz numeric(10,2),
    shipment_id uuid NOT NULL,
    label_zpl_s3_url character varying(200) NOT NULL,
    label_pdf_s3_url character varying(200) NOT NULL,
    is_voided boolean NOT NULL,
    service_type_display character varying(100) NOT NULL,
    label_pdf_url character varying(200) NOT NULL,
    label_png_s3_url character varying(200) NOT NULL,
    label_png_url character varying(200) NOT NULL,
    deleted_at timestamp with time zone
);



--
-- Name: orders_shippingcarrier; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_shippingcarrier (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    carrier_id character varying(100) NOT NULL,
    carrier_code character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    is_enabled boolean NOT NULL,
    raw_data jsonb NOT NULL,
    last_synced_at timestamp with time zone NOT NULL,
    company_id uuid NOT NULL
);



--
-- Name: orders_shippingservice; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders_shippingservice (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    service_code character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    domestic boolean NOT NULL,
    international boolean NOT NULL,
    is_multi_package_supported boolean NOT NULL,
    is_return_supported boolean NOT NULL,
    is_hidden boolean NOT NULL,
    raw_data jsonb NOT NULL,
    carrier_id uuid NOT NULL
);



--
-- Name: prescriptions_patient; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_patient (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    middle_name character varying(150) NOT NULL,
    preferred_name character varying(150) NOT NULL,
    phone character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    readable_id character varying(150),
    date_of_birth date,
    species public.patient_species NOT NULL,
    gender public.gender NOT NULL,
    is_pregnant boolean NOT NULL,
    weight numeric(6,2),
    height numeric(6,2),
    allergies text NOT NULL,
    provider_external_id character varying(150),
    provider_company_id uuid NOT NULL,
    disease_history jsonb NOT NULL,
    medical_history jsonb NOT NULL,
    pharmacy_company_id uuid NOT NULL,
    is_anaphylactic boolean NOT NULL,
    sequence_id integer NOT NULL,
    display_date_of_birth character varying(10) NOT NULL,
    medications text NOT NULL,
    CONSTRAINT prescriptions_patient_sequence_id_check CHECK ((sequence_id >= 0))
);



--
-- Name: prescriptions_patientdocument; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_patientdocument (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    subject character varying(255),
    is_active boolean NOT NULL,
    document character varying(100) NOT NULL,
    document_type public.document_type_patient NOT NULL,
    patient_id uuid NOT NULL,
    user_id uuid NOT NULL,
    note_id uuid,
    s3_url character varying(200) NOT NULL
);



--
-- Name: prescriptions_patientguardian; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_patientguardian (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    middle_name character varying(150) NOT NULL,
    preferred_name character varying(150) NOT NULL,
    phone character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    provider_external_id character varying(150) NOT NULL,
    provider_company_id uuid NOT NULL,
    patient_id uuid NOT NULL
);



--
-- Name: prescriptions_patientnote; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_patientnote (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    subject character varying(255),
    text text,
    is_active boolean NOT NULL,
    note_type public.note_type_patient NOT NULL,
    patient_id uuid NOT NULL,
    user_id uuid NOT NULL,
    additional_details jsonb NOT NULL,
    data jsonb NOT NULL
);



--
-- Name: prescriptions_physician; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_physician (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    middle_name character varying(150) NOT NULL,
    phone character varying(255) NOT NULL,
    phone_evening character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    is_prescribing_privilege boolean NOT NULL,
    provider_external_id character varying(150) NOT NULL,
    npi character varying(50) NOT NULL,
    title public.physician_title NOT NULL,
    provider_company_id uuid NOT NULL
);



--
-- Name: prescriptions_physicianstate; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_physicianstate (
    id bigint NOT NULL,
    state character varying(2) NOT NULL,
    modality public.state_modality NOT NULL,
    physician_id uuid NOT NULL
);



--
-- Name: prescriptions_physicianstate_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.prescriptions_physicianstate ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.prescriptions_physicianstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: prescriptions_prescription; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_prescription (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    sequence_id integer NOT NULL,
    rx_id character varying(100) NOT NULL,
    medication_name character varying(255) NOT NULL,
    product_type public.product_type NOT NULL,
    kind public.prescription_kind NOT NULL,
    provider_external_id character varying(150),
    signed_at timestamp with time zone,
    is_active boolean NOT NULL,
    qty integer NOT NULL,
    qty_unit public.measurement_unit NOT NULL,
    auth_refills integer NOT NULL,
    days_supply integer NOT NULL,
    rejection_reason text NOT NULL,
    additional_details jsonb NOT NULL,
    prescription_schedule public.drug_schedule NOT NULL,
    date_expiration date,
    data jsonb NOT NULL,
    labels_url character varying(500) NOT NULL,
    patient_id uuid,
    pharmacy_company_id uuid,
    physician_id uuid,
    provider_company_id uuid,
    ingredient_data jsonb NOT NULL,
    patient_instructions text NOT NULL,
    prescription_pdf_url character varying(500) NOT NULL,
    allergy_type character varying(16) NOT NULL,
    dilution_data jsonb NOT NULL,
    source public.prescription_source NOT NULL,
    status public.prescription_status NOT NULL,
    CONSTRAINT prescriptions_prescription_auth_refills_check CHECK ((auth_refills >= 0)),
    CONSTRAINT prescriptions_prescription_days_supply_check CHECK ((days_supply >= 0)),
    CONSTRAINT prescriptions_prescription_qty_check CHECK ((qty >= 0)),
    CONSTRAINT prescriptions_prescription_sequence_id_check CHECK ((sequence_id >= 0))
);



--
-- Name: prescriptions_prescriptionapirequest; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_prescriptionapirequest (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    webhook_data jsonb NOT NULL,
    processed_at timestamp with time zone,
    received_at timestamp with time zone NOT NULL,
    context text,
    user_agent text,
    ip_address inet,
    webhook_type public.prescription_webhook_type NOT NULL,
    prescription_id uuid,
    user_id uuid
);



--
-- Name: prescriptions_prescriptiondocument; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_prescriptiondocument (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    subject character varying(255),
    is_active boolean NOT NULL,
    document character varying(100) NOT NULL,
    prescription_id uuid NOT NULL,
    user_id uuid NOT NULL,
    note_id uuid,
    s3_url character varying(200) NOT NULL
);



--
-- Name: prescriptions_prescriptionnote; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.prescriptions_prescriptionnote (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    subject character varying(255),
    text text,
    is_active boolean NOT NULL,
    prescription_id uuid NOT NULL,
    user_id uuid NOT NULL,
    additional_details jsonb NOT NULL,
    data jsonb NOT NULL
);



--
-- Name: shipping_shipmentproblem; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.shipping_shipmentproblem (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    error_message text NOT NULL,
    response_data jsonb NOT NULL,
    shipment_id uuid NOT NULL
);



--
-- Name: shipping_shippingapirequest; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.shipping_shippingapirequest (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    webhook_data jsonb NOT NULL,
    processed_at timestamp with time zone,
    received_at timestamp with time zone NOT NULL,
    context text,
    user_agent text,
    ip_address inet,
    resource_type character varying(100) NOT NULL,
    resource_url character varying(500),
    user_id uuid,
    resource_data jsonb NOT NULL,
    shipment_label_id uuid
);



--
-- Name: system_featureflag; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.system_featureflag (
    name character varying(1024) NOT NULL,
    description text NOT NULL,
    is_enabled boolean NOT NULL,
    run_no_more_than integer NOT NULL,
    run_counter integer NOT NULL,
    settings jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT system_featureflag_run_counter_check CHECK ((run_counter >= 0)),
    CONSTRAINT system_featureflag_run_no_more_than_check CHECK ((run_no_more_than >= 0))
);



--
-- Name: system_featureflag_only_for_users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.system_featureflag_only_for_users (
    id bigint NOT NULL,
    featureflag_id character varying(1024) NOT NULL,
    user_id uuid NOT NULL
);



--
-- Name: system_featureflag_only_for_users_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

ALTER TABLE public.system_featureflag_only_for_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.system_featureflag_only_for_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: system_systemevent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.system_systemevent (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    type public.event_type NOT NULL,
    source public.event_source NOT NULL,
    additional_details jsonb NOT NULL,
    subject_id uuid,
    is_hidden boolean NOT NULL,
    initiated_by_id uuid,
    patient_id uuid,
    subject_ct_id integer,
    user_id uuid
);



--
-- Name: webhooks_providercompanywebhooknotification; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.webhooks_providercompanywebhooknotification (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    endpoint_url character varying(200) NOT NULL,
    request_method character varying(5) NOT NULL,
    request_data jsonb NOT NULL,
    response_status_code integer,
    response_headers jsonb NOT NULL,
    response_body text NOT NULL,
    response_timestamp timestamp with time zone,
    no_response_error_message text NOT NULL,
    provider_company_id uuid NOT NULL,
    CONSTRAINT webhooks_providercompanywebhooknotif_response_status_code_check CHECK ((response_status_code >= 0))
);



--
-- Name: webhooks_providercompanywebhookurls; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.webhooks_providercompanywebhookurls (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    order_updates_url character varying(200) NOT NULL,
    provider_company_id uuid NOT NULL
);



--
-- Name: webhooks_shipmenttrackingevent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.webhooks_shipmenttrackingevent (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    tracking_number character varying(255) NOT NULL,
    carrier_status_code character varying(100) NOT NULL,
    carrier_status_description text NOT NULL,
    status_code character varying(10) NOT NULL,
    occurred_at timestamp with time zone,
    carrier_occurred_at timestamp with time zone,
    description text NOT NULL,
    city_locality character varying(255) NOT NULL,
    state_province character varying(100) NOT NULL,
    postal_code character varying(20) NOT NULL,
    country_code character varying(10) NOT NULL,
    company_name character varying(255) NOT NULL,
    signer character varying(255) NOT NULL,
    event_code character varying(100) NOT NULL,
    raw_data jsonb NOT NULL,
    shipment_id uuid NOT NULL,
    webhook_request_id uuid
);



--
-- Name: webhooks_webhookrequest; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.webhooks_webhookrequest (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    source public.webhook_source NOT NULL,
    client_ip inet,
    headers jsonb NOT NULL,
    body jsonb NOT NULL
);



--
-- Name: accounts_company accounts_company_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_company
    ADD CONSTRAINT accounts_company_pkey PRIMARY KEY (id);


--
-- Name: accounts_pharmacist accounts_pharmacist_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_pharmacist
    ADD CONSTRAINT accounts_pharmacist_pkey PRIMARY KEY (user_ptr_id);


--
-- Name: accounts_user accounts_user_email_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_email_key UNIQUE (email);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: billing_billinginvoice billing_billinginvoice_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_billinginvoice
    ADD CONSTRAINT billing_billinginvoice_pkey PRIMARY KEY (id);


--
-- Name: billing_billinginvoice_transactions billing_billinginvoice_t_billinginvoice_id_transa_899f9f18_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_billinginvoice_transactions
    ADD CONSTRAINT billing_billinginvoice_t_billinginvoice_id_transa_899f9f18_uniq UNIQUE (billinginvoice_id, transaction_id);


--
-- Name: billing_billinginvoice_transactions billing_billinginvoice_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_billinginvoice_transactions
    ADD CONSTRAINT billing_billinginvoice_transactions_pkey PRIMARY KEY (id);


--
-- Name: billing_transaction billing_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_transaction
    ADD CONSTRAINT billing_transaction_pkey PRIMARY KEY (id);


--
-- Name: billing_transaction billing_transaction_sequence_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_transaction
    ADD CONSTRAINT billing_transaction_sequence_id_key UNIQUE (sequence_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: faxorder_bedrockcache faxorder_bedrockcache_crop_hash_model_id_promp_83e591c4_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_bedrockcache
    ADD CONSTRAINT faxorder_bedrockcache_crop_hash_model_id_promp_83e591c4_uniq UNIQUE (crop_hash, model_id, prompt_profile);


--
-- Name: faxorder_bedrockcache faxorder_bedrockcache_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_bedrockcache
    ADD CONSTRAINT faxorder_bedrockcache_pkey PRIMARY KEY (id);


--
-- Name: faxorder_faxauditevent faxorder_faxauditevent_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxauditevent
    ADD CONSTRAINT faxorder_faxauditevent_pkey PRIMARY KEY (id);


--
-- Name: faxorder_faxdocument faxorder_faxdocument_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocument
    ADD CONSTRAINT faxorder_faxdocument_pkey PRIMARY KEY (id);


--
-- Name: faxorder_faxdocument faxorder_faxdocument_sequence_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocument
    ADD CONSTRAINT faxorder_faxdocument_sequence_id_key UNIQUE (sequence_id);


--
-- Name: faxorder_faxdocumentpage faxorder_faxdocumentpage_fax_document_id_page_num_20e1d842_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocumentpage
    ADD CONSTRAINT faxorder_faxdocumentpage_fax_document_id_page_num_20e1d842_uniq UNIQUE (fax_document_id, page_number);


--
-- Name: faxorder_faxdocumentpage faxorder_faxdocumentpage_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocumentpage
    ADD CONSTRAINT faxorder_faxdocumentpage_pkey PRIMARY KEY (id);


--
-- Name: faxorder_faxtemplateconfig faxorder_faxtemplateconfig_family_version_5f4fd318_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxtemplateconfig
    ADD CONSTRAINT faxorder_faxtemplateconfig_family_version_5f4fd318_uniq UNIQUE (family, version);


--
-- Name: faxorder_faxtemplateconfig faxorder_faxtemplateconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxtemplateconfig
    ADD CONSTRAINT faxorder_faxtemplateconfig_pkey PRIMARY KEY (id);


--
-- Name: faxorder_faxwebhookrequest faxorder_faxwebhookrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxwebhookrequest
    ADD CONSTRAINT faxorder_faxwebhookrequest_pkey PRIMARY KEY (id);


--
-- Name: ingredients_ingredient ingredients_ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ingredient
    ADD CONSTRAINT ingredients_ingredient_pkey PRIMARY KEY (id);


--
-- Name: ingredients_inventory ingredients_ingredientlot_lot_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_inventory
    ADD CONSTRAINT ingredients_ingredientlot_lot_id_key UNIQUE (lot_id);


--
-- Name: ingredients_inventory ingredients_ingredientlot_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_inventory
    ADD CONSTRAINT ingredients_ingredientlot_pkey PRIMARY KEY (id);


--
-- Name: ingredients_ingredientmap ingredients_ingredientma_original_name_treatment__1efa50f7_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ingredientmap
    ADD CONSTRAINT ingredients_ingredientma_original_name_treatment__1efa50f7_uniq UNIQUE (original_name, treatment_kind);


--
-- Name: ingredients_ingredientmap ingredients_ingredientmap_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ingredientmap
    ADD CONSTRAINT ingredients_ingredientmap_pkey PRIMARY KEY (id);


--
-- Name: ingredients_ndcpharmaceutical ingredients_ndcpharmaceutical_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ndcpharmaceutical
    ADD CONSTRAINT ingredients_ndcpharmaceutical_pkey PRIMARY KEY (id);


--
-- Name: orders_fillorder orders_fillorder_fill_id_deleted_at_1db0f089_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_fill_id_deleted_at_1db0f089_uniq UNIQUE (fill_id, deleted_at);


--
-- Name: orders_fillorder orders_fillorder_fill_number_prescription_a3344909_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_fill_number_prescription_a3344909_uniq UNIQUE (fill_number, prescription_id, deleted_at);


--
-- Name: orders_fillorder orders_fillorder_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_pkey PRIMARY KEY (id);


--
-- Name: orders_fillorder orders_fillorder_sequence_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_sequence_id_key UNIQUE (sequence_id);


--
-- Name: orders_fillorderapirequest orders_fillorderapirequest_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderapirequest
    ADD CONSTRAINT orders_fillorderapirequest_pkey PRIMARY KEY (id);


--
-- Name: orders_fillorderingredient orders_fillorderingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderingredient
    ADD CONSTRAINT orders_fillorderingredient_pkey PRIMARY KEY (id);


--
-- Name: orders_fillorderingredientevent orders_fillorderingredientevent_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderingredientevent
    ADD CONSTRAINT orders_fillorderingredientevent_pkey PRIMARY KEY (id);


--
-- Name: orders_fillorderstatusevent orders_fillorderstatusevent_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderstatusevent
    ADD CONSTRAINT orders_fillorderstatusevent_pkey PRIMARY KEY (id);


--
-- Name: orders_orderdocument orders_orderdocument_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_orderdocument
    ADD CONSTRAINT orders_orderdocument_pkey PRIMARY KEY (id);


--
-- Name: orders_ordernote orders_ordernote_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_ordernote
    ADD CONSTRAINT orders_ordernote_pkey PRIMARY KEY (id);


--
-- Name: orders_shipment orders_shipment_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shipment
    ADD CONSTRAINT orders_shipment_pkey PRIMARY KEY (id);


--
-- Name: orders_shipmentlabel orders_shipmentlabel_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shipmentlabel
    ADD CONSTRAINT orders_shipmentlabel_pkey PRIMARY KEY (id);


--
-- Name: orders_shippingcarrier orders_shippingcarrier_company_id_carrier_id_a81f5d8d_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shippingcarrier
    ADD CONSTRAINT orders_shippingcarrier_company_id_carrier_id_a81f5d8d_uniq UNIQUE (company_id, carrier_id);


--
-- Name: orders_shippingcarrier orders_shippingcarrier_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shippingcarrier
    ADD CONSTRAINT orders_shippingcarrier_pkey PRIMARY KEY (id);


--
-- Name: orders_shippingservice orders_shippingservice_carrier_id_service_code_34d03b67_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shippingservice
    ADD CONSTRAINT orders_shippingservice_carrier_id_service_code_34d03b67_uniq UNIQUE (carrier_id, service_code);


--
-- Name: orders_shippingservice orders_shippingservice_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shippingservice
    ADD CONSTRAINT orders_shippingservice_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_patient prescriptions_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patient
    ADD CONSTRAINT prescriptions_patient_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_patient prescriptions_patient_provider_external_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patient
    ADD CONSTRAINT prescriptions_patient_provider_external_id_key UNIQUE (provider_external_id);


--
-- Name: prescriptions_patient prescriptions_patient_readable_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patient
    ADD CONSTRAINT prescriptions_patient_readable_id_key UNIQUE (readable_id);


--
-- Name: prescriptions_patient prescriptions_patient_sequence_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patient
    ADD CONSTRAINT prescriptions_patient_sequence_id_key UNIQUE (sequence_id);


--
-- Name: prescriptions_patientdocument prescriptions_patientdocument_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientdocument
    ADD CONSTRAINT prescriptions_patientdocument_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_patientguardian prescriptions_patientguardian_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientguardian
    ADD CONSTRAINT prescriptions_patientguardian_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_patientnote prescriptions_patientnote_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientnote
    ADD CONSTRAINT prescriptions_patientnote_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_physician prescriptions_physician_email_provider_company_id_e7f20ec6_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_physician
    ADD CONSTRAINT prescriptions_physician_email_provider_company_id_e7f20ec6_uniq UNIQUE (email, provider_company_id);


--
-- Name: prescriptions_physician prescriptions_physician_npi_provider_company_id_10efb1dd_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_physician
    ADD CONSTRAINT prescriptions_physician_npi_provider_company_id_10efb1dd_uniq UNIQUE (npi, provider_company_id);


--
-- Name: prescriptions_physician prescriptions_physician_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_physician
    ADD CONSTRAINT prescriptions_physician_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_physician prescriptions_physician_provider_external_id_pro_24ca1b6e_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_physician
    ADD CONSTRAINT prescriptions_physician_provider_external_id_pro_24ca1b6e_uniq UNIQUE (provider_external_id, provider_company_id);


--
-- Name: prescriptions_physicianstate prescriptions_physicianstate_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_physicianstate
    ADD CONSTRAINT prescriptions_physicianstate_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_prescription prescriptions_prescripti_rx_id_provider_company_i_4e1f6b33_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescription
    ADD CONSTRAINT prescriptions_prescripti_rx_id_provider_company_i_4e1f6b33_uniq UNIQUE (rx_id, provider_company_id, pharmacy_company_id);


--
-- Name: prescriptions_prescription prescriptions_prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescription
    ADD CONSTRAINT prescriptions_prescription_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_prescription prescriptions_prescription_sequence_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescription
    ADD CONSTRAINT prescriptions_prescription_sequence_id_key UNIQUE (sequence_id);


--
-- Name: prescriptions_prescriptionapirequest prescriptions_prescriptionapirequest_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptionapirequest
    ADD CONSTRAINT prescriptions_prescriptionapirequest_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_prescriptiondocument prescriptions_prescriptiondocument_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptiondocument
    ADD CONSTRAINT prescriptions_prescriptiondocument_pkey PRIMARY KEY (id);


--
-- Name: prescriptions_prescriptionnote prescriptions_prescriptionnote_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptionnote
    ADD CONSTRAINT prescriptions_prescriptionnote_pkey PRIMARY KEY (id);


--
-- Name: shipping_shipmentproblem shipping_shipmentproblem_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.shipping_shipmentproblem
    ADD CONSTRAINT shipping_shipmentproblem_pkey PRIMARY KEY (id);


--
-- Name: shipping_shippingapirequest shipping_shippingapirequest_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.shipping_shippingapirequest
    ADD CONSTRAINT shipping_shippingapirequest_pkey PRIMARY KEY (id);


--
-- Name: system_featureflag_only_for_users system_featureflag_only__featureflag_id_user_id_1d0a82c0_uniq; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_featureflag_only_for_users
    ADD CONSTRAINT system_featureflag_only__featureflag_id_user_id_1d0a82c0_uniq UNIQUE (featureflag_id, user_id);


--
-- Name: system_featureflag_only_for_users system_featureflag_only_for_users_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_featureflag_only_for_users
    ADD CONSTRAINT system_featureflag_only_for_users_pkey PRIMARY KEY (id);


--
-- Name: system_featureflag system_featureflag_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_featureflag
    ADD CONSTRAINT system_featureflag_pkey PRIMARY KEY (name);


--
-- Name: system_systemevent system_systemevent_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_systemevent
    ADD CONSTRAINT system_systemevent_pkey PRIMARY KEY (id);


--
-- Name: webhooks_providercompanywebhooknotification webhooks_providercompanywebhooknotification_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_providercompanywebhooknotification
    ADD CONSTRAINT webhooks_providercompanywebhooknotification_pkey PRIMARY KEY (id);


--
-- Name: webhooks_providercompanywebhookurls webhooks_providercompanywebhookurls_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_providercompanywebhookurls
    ADD CONSTRAINT webhooks_providercompanywebhookurls_pkey PRIMARY KEY (id);


--
-- Name: webhooks_providercompanywebhookurls webhooks_providercompanywebhookurls_provider_company_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_providercompanywebhookurls
    ADD CONSTRAINT webhooks_providercompanywebhookurls_provider_company_id_key UNIQUE (provider_company_id);


--
-- Name: webhooks_shipmenttrackingevent webhooks_shipmenttrackingevent_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_shipmenttrackingevent
    ADD CONSTRAINT webhooks_shipmenttrackingevent_pkey PRIMARY KEY (id);


--
-- Name: webhooks_webhookrequest webhooks_webhookrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_webhookrequest
    ADD CONSTRAINT webhooks_webhookrequest_pkey PRIMARY KEY (id);


--
-- Name: accounts_company_deleted_at_e9fd190a; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_company_deleted_at_e9fd190a ON public.accounts_company USING btree (deleted_at);


--
-- Name: accounts_company_state_b304ebd2; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_company_state_b304ebd2 ON public.accounts_company USING btree (state);


--
-- Name: accounts_company_state_b304ebd2_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_company_state_b304ebd2_like ON public.accounts_company USING btree (state varchar_pattern_ops);


--
-- Name: accounts_company_type_e0209e3f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_company_type_e0209e3f ON public.accounts_company USING btree (type);


--
-- Name: accounts_user_company_id_bc91fe74; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_company_id_bc91fe74 ON public.accounts_user USING btree (company_id);


--
-- Name: accounts_user_deleted_at_88c9c1f6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_deleted_at_88c9c1f6 ON public.accounts_user USING btree (deleted_at);


--
-- Name: accounts_user_email_b2644a56_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_email_b2644a56_like ON public.accounts_user USING btree (email varchar_pattern_ops);


--
-- Name: accounts_user_first_name_cb714b03; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_first_name_cb714b03 ON public.accounts_user USING btree (first_name);


--
-- Name: accounts_user_first_name_cb714b03_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_first_name_cb714b03_like ON public.accounts_user USING btree (first_name varchar_pattern_ops);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_last_name_d3fe5f1d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_last_name_d3fe5f1d ON public.accounts_user USING btree (last_name);


--
-- Name: accounts_user_last_name_d3fe5f1d_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_last_name_d3fe5f1d_like ON public.accounts_user USING btree (last_name varchar_pattern_ops);


--
-- Name: accounts_user_last_seen_8179a751; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_last_seen_8179a751 ON public.accounts_user USING btree (last_seen);


--
-- Name: accounts_user_phone_c603acdd; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_phone_c603acdd ON public.accounts_user USING btree (phone);


--
-- Name: accounts_user_phone_c603acdd_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_phone_c603acdd_like ON public.accounts_user USING btree (phone varchar_pattern_ops);


--
-- Name: accounts_user_state_cc2e565b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_state_cc2e565b ON public.accounts_user USING btree (state);


--
-- Name: accounts_user_state_cc2e565b_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_state_cc2e565b_like ON public.accounts_user USING btree (state varchar_pattern_ops);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: billing_billinginvoice_pharmacy_company_id_1438bf9e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX billing_billinginvoice_pharmacy_company_id_1438bf9e ON public.billing_billinginvoice USING btree (pharmacy_company_id);


--
-- Name: billing_billinginvoice_provider_company_id_0a4908d5; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX billing_billinginvoice_provider_company_id_0a4908d5 ON public.billing_billinginvoice USING btree (provider_company_id);


--
-- Name: billing_billinginvoice_transactions_billinginvoice_id_5c8dbcba; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX billing_billinginvoice_transactions_billinginvoice_id_5c8dbcba ON public.billing_billinginvoice_transactions USING btree (billinginvoice_id);


--
-- Name: billing_billinginvoice_transactions_transaction_id_d3e9c480; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX billing_billinginvoice_transactions_transaction_id_d3e9c480 ON public.billing_billinginvoice_transactions USING btree (transaction_id);


--
-- Name: billing_transaction_created_by_id_e240efc3; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX billing_transaction_created_by_id_e240efc3 ON public.billing_transaction USING btree (created_by_id);


--
-- Name: billing_transaction_order_id_d731e333; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX billing_transaction_order_id_d731e333 ON public.billing_transaction USING btree (order_id);


--
-- Name: billing_transaction_pharmacy_company_id_43cd6687; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX billing_transaction_pharmacy_company_id_43cd6687 ON public.billing_transaction USING btree (pharmacy_company_id);


--
-- Name: billing_transaction_provider_company_id_85ff84f0; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX billing_transaction_provider_company_id_85ff84f0 ON public.billing_transaction USING btree (provider_company_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: faxorder_be_crop_ha_9279f7_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_be_crop_ha_9279f7_idx ON public.faxorder_bedrockcache USING btree (crop_hash, model_id, prompt_profile);


--
-- Name: faxorder_bedrockcache_crop_hash_7a8d7c0d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_bedrockcache_crop_hash_7a8d7c0d ON public.faxorder_bedrockcache USING btree (crop_hash);


--
-- Name: faxorder_bedrockcache_crop_hash_7a8d7c0d_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_bedrockcache_crop_hash_7a8d7c0d_like ON public.faxorder_bedrockcache USING btree (crop_hash varchar_pattern_ops);


--
-- Name: faxorder_fa_family_801a6e_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_fa_family_801a6e_idx ON public.faxorder_faxtemplateconfig USING btree (family, is_active);


--
-- Name: faxorder_fa_fax_doc_9910d7_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_fa_fax_doc_9910d7_idx ON public.faxorder_faxauditevent USING btree (fax_document_id, created_at DESC);


--
-- Name: faxorder_fa_job_id_4d6f0a_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_fa_job_id_4d6f0a_idx ON public.faxorder_faxwebhookrequest USING btree (job_id);


--
-- Name: faxorder_fa_receive_f48630_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_fa_receive_f48630_idx ON public.faxorder_faxwebhookrequest USING btree (receiver_fax);


--
-- Name: faxorder_fa_sender__c4b22c_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_fa_sender__c4b22c_idx ON public.faxorder_faxwebhookrequest USING btree (sender_fax);


--
-- Name: faxorder_fa_status_3f15f4_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_fa_status_3f15f4_idx ON public.faxorder_faxdocument USING btree (status, created_at DESC);


--
-- Name: faxorder_fa_templat_8d14ba_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_fa_templat_8d14ba_idx ON public.faxorder_faxdocument USING btree (template_family, created_at DESC);


--
-- Name: faxorder_faxauditevent_event_type_e77b629d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxauditevent_event_type_e77b629d ON public.faxorder_faxauditevent USING btree (event_type);


--
-- Name: faxorder_faxauditevent_fax_document_id_90173a1c; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxauditevent_fax_document_id_90173a1c ON public.faxorder_faxauditevent USING btree (fax_document_id);


--
-- Name: faxorder_faxauditevent_user_id_0dcedcb7; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxauditevent_user_id_0dcedcb7 ON public.faxorder_faxauditevent USING btree (user_id);


--
-- Name: faxorder_faxdocument_fax_type_e7c93418; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_fax_type_e7c93418 ON public.faxorder_faxdocument USING btree (fax_type);


--
-- Name: faxorder_faxdocument_order_id_65185428; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_order_id_65185428 ON public.faxorder_faxdocument USING btree (order_id);


--
-- Name: faxorder_faxdocument_pharmacy_company_id_2f10c565; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_pharmacy_company_id_2f10c565 ON public.faxorder_faxdocument USING btree (pharmacy_company_id);


--
-- Name: faxorder_faxdocument_prescription_id_980b2bd2; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_prescription_id_980b2bd2 ON public.faxorder_faxdocument USING btree (prescription_id);


--
-- Name: faxorder_faxdocument_provider_company_id_a79fba3d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_provider_company_id_a79fba3d ON public.faxorder_faxdocument USING btree (provider_company_id);


--
-- Name: faxorder_faxdocument_reviewed_by_id_142183c9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_reviewed_by_id_142183c9 ON public.faxorder_faxdocument USING btree (reviewed_by_id);


--
-- Name: faxorder_faxdocument_status_d467ef16; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_status_d467ef16 ON public.faxorder_faxdocument USING btree (status);


--
-- Name: faxorder_faxdocument_template_config_id_ae33a4ca; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_template_config_id_ae33a4ca ON public.faxorder_faxdocument USING btree (template_config_id);


--
-- Name: faxorder_faxdocument_template_family_6ca9b336; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_template_family_6ca9b336 ON public.faxorder_faxdocument USING btree (template_family);


--
-- Name: faxorder_faxdocument_template_family_6ca9b336_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocument_template_family_6ca9b336_like ON public.faxorder_faxdocument USING btree (template_family varchar_pattern_ops);


--
-- Name: faxorder_faxdocumentpage_fax_document_id_58568a4d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocumentpage_fax_document_id_58568a4d ON public.faxorder_faxdocumentpage USING btree (fax_document_id);


--
-- Name: faxorder_faxdocumentpage_order_id_65daa22f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxdocumentpage_order_id_65daa22f ON public.faxorder_faxdocumentpage USING btree (order_id);


--
-- Name: faxorder_faxtemplateconfig_family_32279a8f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxtemplateconfig_family_32279a8f ON public.faxorder_faxtemplateconfig USING btree (family);


--
-- Name: faxorder_faxtemplateconfig_family_32279a8f_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxtemplateconfig_family_32279a8f_like ON public.faxorder_faxtemplateconfig USING btree (family varchar_pattern_ops);


--
-- Name: faxorder_faxtemplateconfig_is_active_59d29141; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxtemplateconfig_is_active_59d29141 ON public.faxorder_faxtemplateconfig USING btree (is_active);


--
-- Name: faxorder_faxtemplateconfig_pharmacy_company_id_1d230d26; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxtemplateconfig_pharmacy_company_id_1d230d26 ON public.faxorder_faxtemplateconfig USING btree (pharmacy_company_id);


--
-- Name: faxorder_faxtemplateconfig_provider_company_id_059d350b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxtemplateconfig_provider_company_id_059d350b ON public.faxorder_faxtemplateconfig USING btree (provider_company_id);


--
-- Name: faxorder_faxwebhookrequest_fax_document_id_fb6da6ec; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_fax_document_id_fb6da6ec ON public.faxorder_faxwebhookrequest USING btree (fax_document_id);


--
-- Name: faxorder_faxwebhookrequest_job_id_6c6fdb16; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_job_id_6c6fdb16 ON public.faxorder_faxwebhookrequest USING btree (job_id);


--
-- Name: faxorder_faxwebhookrequest_job_id_6c6fdb16_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_job_id_6c6fdb16_like ON public.faxorder_faxwebhookrequest USING btree (job_id varchar_pattern_ops);


--
-- Name: faxorder_faxwebhookrequest_received_at_70280691; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_received_at_70280691 ON public.faxorder_faxwebhookrequest USING btree (received_at);


--
-- Name: faxorder_faxwebhookrequest_receiver_fax_2423fe52; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_receiver_fax_2423fe52 ON public.faxorder_faxwebhookrequest USING btree (receiver_fax);


--
-- Name: faxorder_faxwebhookrequest_receiver_fax_2423fe52_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_receiver_fax_2423fe52_like ON public.faxorder_faxwebhookrequest USING btree (receiver_fax varchar_pattern_ops);


--
-- Name: faxorder_faxwebhookrequest_sender_fax_4d18ea60; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_sender_fax_4d18ea60 ON public.faxorder_faxwebhookrequest USING btree (sender_fax);


--
-- Name: faxorder_faxwebhookrequest_sender_fax_4d18ea60_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_sender_fax_4d18ea60_like ON public.faxorder_faxwebhookrequest USING btree (sender_fax varchar_pattern_ops);


--
-- Name: faxorder_faxwebhookrequest_user_id_e7e64f51; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX faxorder_faxwebhookrequest_user_id_e7e64f51 ON public.faxorder_faxwebhookrequest USING btree (user_id);


--
-- Name: ingredients_ingredient_deleted_at_22e8c299; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredient_deleted_at_22e8c299 ON public.ingredients_ingredient USING btree (deleted_at);


--
-- Name: ingredients_ingredient_ndc_id_e4375fdd; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredient_ndc_id_e4375fdd ON public.ingredients_ingredient USING btree (ndc_id);


--
-- Name: ingredients_ingredientlot_deleted_at_af0ed2ee; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientlot_deleted_at_af0ed2ee ON public.ingredients_inventory USING btree (deleted_at);


--
-- Name: ingredients_ingredientlot_ingredient_id_363b2ebb; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientlot_ingredient_id_363b2ebb ON public.ingredients_inventory USING btree (ingredient_id);


--
-- Name: ingredients_ingredientlot_lot_id_c6ed01e1_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientlot_lot_id_c6ed01e1_like ON public.ingredients_inventory USING btree (lot_id varchar_pattern_ops);


--
-- Name: ingredients_ingredientlot_pharmacy_company_id_fe8eb637; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientlot_pharmacy_company_id_fe8eb637 ON public.ingredients_inventory USING btree (pharmacy_company_id);


--
-- Name: ingredients_ingredientmap_ingredient_id_e8ffc8c8; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientmap_ingredient_id_e8ffc8c8 ON public.ingredients_ingredientmap USING btree (ingredient_id);


--
-- Name: ingredients_ingredientmap_pharmacy_company_id_8b7f3b24; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientmap_pharmacy_company_id_8b7f3b24 ON public.ingredients_ingredientmap USING btree (pharmacy_company_id);


--
-- Name: ingredients_ingredientmap_provider_company_id_f6847e15; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientmap_provider_company_id_f6847e15 ON public.ingredients_ingredientmap USING btree (provider_company_id);


--
-- Name: ingredients_ingredientmap_treatment_kind_f1858a25; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientmap_treatment_kind_f1858a25 ON public.ingredients_ingredientmap USING btree (treatment_kind);


--
-- Name: ingredients_ingredientmap_treatment_kind_f1858a25_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientmap_treatment_kind_f1858a25_like ON public.ingredients_ingredientmap USING btree (treatment_kind varchar_pattern_ops);


--
-- Name: ingredients_ingredientmap_user_id_f32699d2; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ingredientmap_user_id_f32699d2 ON public.ingredients_ingredientmap USING btree (user_id);


--
-- Name: ingredients_ndcpharmaceutical_manufacturer_id_e9496359; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ndcpharmaceutical_manufacturer_id_e9496359 ON public.ingredients_ndcpharmaceutical USING btree (manufacturer_id);


--
-- Name: ingredients_ndcpharmaceutical_ndc_974c87df; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ndcpharmaceutical_ndc_974c87df ON public.ingredients_ndcpharmaceutical USING btree (ndc);


--
-- Name: ingredients_ndcpharmaceutical_ndc_974c87df_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ndcpharmaceutical_ndc_974c87df_like ON public.ingredients_ndcpharmaceutical USING btree (ndc varchar_pattern_ops);


--
-- Name: ingredients_ndcpharmaceutical_product_id_8e662b05; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ndcpharmaceutical_product_id_8e662b05 ON public.ingredients_ndcpharmaceutical USING btree (product_id);


--
-- Name: ingredients_ndcpharmaceutical_product_id_8e662b05_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ingredients_ndcpharmaceutical_product_id_8e662b05_like ON public.ingredients_ndcpharmaceutical USING btree (product_id varchar_pattern_ops);


--
-- Name: orders_fillorder_deleted_at_dcf597ba; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_deleted_at_dcf597ba ON public.orders_fillorder USING btree (deleted_at);


--
-- Name: orders_fillorder_locked_by_id_22c88679; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_locked_by_id_22c88679 ON public.orders_fillorder USING btree (locked_by_id);


--
-- Name: orders_fillorder_locked_until_d117870c; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_locked_until_d117870c ON public.orders_fillorder USING btree (locked_until);


--
-- Name: orders_fillorder_order_source_8a4f08a6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_order_source_8a4f08a6 ON public.orders_fillorder USING btree (order_source);


--
-- Name: orders_fillorder_parent_fill_order_id_194de8ad; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_parent_fill_order_id_194de8ad ON public.orders_fillorder USING btree (parent_fill_order_id);


--
-- Name: orders_fillorder_patient_id_7ab72d47; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_patient_id_7ab72d47 ON public.orders_fillorder USING btree (patient_id);


--
-- Name: orders_fillorder_pharmacist_id_3e1517f8; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_pharmacist_id_3e1517f8 ON public.orders_fillorder USING btree (pharmacist_id);


--
-- Name: orders_fillorder_pharmacy_company_id_7e8f5a41; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_pharmacy_company_id_7e8f5a41 ON public.orders_fillorder USING btree (pharmacy_company_id);


--
-- Name: orders_fillorder_prescription_id_2ea96956; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_prescription_id_2ea96956 ON public.orders_fillorder USING btree (prescription_id);


--
-- Name: orders_fillorder_provider_company_id_f2b475ff; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_provider_company_id_f2b475ff ON public.orders_fillorder USING btree (provider_company_id);


--
-- Name: orders_fillorder_state_79bf94bf; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_state_79bf94bf ON public.orders_fillorder USING btree (state);


--
-- Name: orders_fillorder_state_79bf94bf_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_state_79bf94bf_like ON public.orders_fillorder USING btree (state varchar_pattern_ops);


--
-- Name: orders_fillorder_technician_id_02fb3f31; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_technician_id_02fb3f31 ON public.orders_fillorder USING btree (technician_id);


--
-- Name: orders_fillorder_verified_by_id_6f23e158; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorder_verified_by_id_6f23e158 ON public.orders_fillorder USING btree (verified_by_id);


--
-- Name: orders_fillorderapirequest_fill_order_id_1be369b7; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderapirequest_fill_order_id_1be369b7 ON public.orders_fillorderapirequest USING btree (fill_order_id);


--
-- Name: orders_fillorderapirequest_received_at_d1aa5e9e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderapirequest_received_at_d1aa5e9e ON public.orders_fillorderapirequest USING btree (received_at);


--
-- Name: orders_fillorderapirequest_user_id_4acb538f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderapirequest_user_id_4acb538f ON public.orders_fillorderapirequest USING btree (user_id);


--
-- Name: orders_fillorderapirequest_webhook_type_91d9744a; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderapirequest_webhook_type_91d9744a ON public.orders_fillorderapirequest USING btree (webhook_type);


--
-- Name: orders_fillorderingredient_deleted_at_d274e81b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderingredient_deleted_at_d274e81b ON public.orders_fillorderingredient USING btree (deleted_at);


--
-- Name: orders_fillorderingredient_fill_order_ingredient_id_2d91595e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderingredient_fill_order_ingredient_id_2d91595e ON public.orders_fillorderingredientevent USING btree (fill_order_ingredient_id);


--
-- Name: orders_fillorderingredient_ingredient_id_c0d2be28; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderingredient_ingredient_id_c0d2be28 ON public.orders_fillorderingredient USING btree (inventory_id);


--
-- Name: orders_fillorderingredient_order_id_90b2b23e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderingredient_order_id_90b2b23e ON public.orders_fillorderingredient USING btree (order_id);


--
-- Name: orders_fillorderingredientevent_deleted_at_30701559; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderingredientevent_deleted_at_30701559 ON public.orders_fillorderingredientevent USING btree (deleted_at);


--
-- Name: orders_fillorderingredientevent_inventory_id_343bccfd; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderingredientevent_inventory_id_343bccfd ON public.orders_fillorderingredientevent USING btree (inventory_id);


--
-- Name: orders_fillorderingredientevent_user_id_76f891b9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderingredientevent_user_id_76f891b9 ON public.orders_fillorderingredientevent USING btree (user_id);


--
-- Name: orders_fillorderstatusevent_fill_order_id_6f869b37; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderstatusevent_fill_order_id_6f869b37 ON public.orders_fillorderstatusevent USING btree (fill_order_id);


--
-- Name: orders_fillorderstatusevent_status_new_a9a64664; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderstatusevent_status_new_a9a64664 ON public.orders_fillorderstatusevent USING btree (status_new);


--
-- Name: orders_fillorderstatusevent_status_old_6cbd1ce8; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderstatusevent_status_old_6cbd1ce8 ON public.orders_fillorderstatusevent USING btree (status_old);


--
-- Name: orders_fillorderstatusevent_user_id_b95e6231; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_fillorderstatusevent_user_id_b95e6231 ON public.orders_fillorderstatusevent USING btree (user_id);


--
-- Name: orders_orderdocument_fill_order_id_339dfe2c; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_orderdocument_fill_order_id_339dfe2c ON public.orders_orderdocument USING btree (fill_order_id);


--
-- Name: orders_orderdocument_note_id_ea4a6880; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_orderdocument_note_id_ea4a6880 ON public.orders_orderdocument USING btree (note_id);


--
-- Name: orders_orderdocument_user_id_70164748; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_orderdocument_user_id_70164748 ON public.orders_orderdocument USING btree (user_id);


--
-- Name: orders_ordernote_fill_order_id_11aec1a0; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_ordernote_fill_order_id_11aec1a0 ON public.orders_ordernote USING btree (fill_order_id);


--
-- Name: orders_ordernote_user_id_c8dec706; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_ordernote_user_id_c8dec706 ON public.orders_ordernote USING btree (user_id);


--
-- Name: orders_ship_carrier_91ba9c_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_ship_carrier_91ba9c_idx ON public.orders_shippingservice USING btree (carrier_id, domestic);


--
-- Name: orders_ship_carrier_c9908d_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_ship_carrier_c9908d_idx ON public.orders_shippingcarrier USING btree (carrier_code);


--
-- Name: orders_ship_company_ec3210_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_ship_company_ec3210_idx ON public.orders_shippingcarrier USING btree (company_id, is_enabled);


--
-- Name: orders_ship_service_68658d_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_ship_service_68658d_idx ON public.orders_shippingservice USING btree (service_code);


--
-- Name: orders_shipment_carrier_status_b041bb62; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipment_carrier_status_b041bb62 ON public.orders_shipment USING btree (carrier_status);


--
-- Name: orders_shipment_carrier_status_b041bb62_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipment_carrier_status_b041bb62_like ON public.orders_shipment USING btree (carrier_status varchar_pattern_ops);


--
-- Name: orders_shipment_deleted_at_beadd50d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipment_deleted_at_beadd50d ON public.orders_shipment USING btree (deleted_at);


--
-- Name: orders_shipment_order_id_661ed8ed; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipment_order_id_661ed8ed ON public.orders_shipment USING btree (order_id);


--
-- Name: orders_shipment_pharmacy_id_75bd84e7; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipment_pharmacy_id_75bd84e7 ON public.orders_shipment USING btree (pharmacy_id);


--
-- Name: orders_shipment_prescription_id_dc25cda4; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipment_prescription_id_dc25cda4 ON public.orders_shipment USING btree (prescription_id);


--
-- Name: orders_shipment_tracking_number_29c98397; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipment_tracking_number_29c98397 ON public.orders_shipment USING btree (tracking_number);


--
-- Name: orders_shipment_tracking_number_29c98397_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipment_tracking_number_29c98397_like ON public.orders_shipment USING btree (tracking_number varchar_pattern_ops);


--
-- Name: orders_shipmentlabel_deleted_at_b558c45f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipmentlabel_deleted_at_b558c45f ON public.orders_shipmentlabel USING btree (deleted_at);


--
-- Name: orders_shipmentlabel_is_successful_48ae8f56; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipmentlabel_is_successful_48ae8f56 ON public.orders_shipmentlabel USING btree (is_successful);


--
-- Name: orders_shipmentlabel_label_type_e9ab9ac3; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipmentlabel_label_type_e9ab9ac3 ON public.orders_shipmentlabel USING btree (label_type);


--
-- Name: orders_shipmentlabel_shipment_id_d0d1819f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipmentlabel_shipment_id_d0d1819f ON public.orders_shipmentlabel USING btree (shipment_id);


--
-- Name: orders_shipmentlabel_tracking_number_6bf79262; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipmentlabel_tracking_number_6bf79262 ON public.orders_shipmentlabel USING btree (tracking_number);


--
-- Name: orders_shipmentlabel_tracking_number_6bf79262_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shipmentlabel_tracking_number_6bf79262_like ON public.orders_shipmentlabel USING btree (tracking_number varchar_pattern_ops);


--
-- Name: orders_shippingcarrier_carrier_code_d9d8d3b3; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shippingcarrier_carrier_code_d9d8d3b3 ON public.orders_shippingcarrier USING btree (carrier_code);


--
-- Name: orders_shippingcarrier_carrier_code_d9d8d3b3_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shippingcarrier_carrier_code_d9d8d3b3_like ON public.orders_shippingcarrier USING btree (carrier_code varchar_pattern_ops);


--
-- Name: orders_shippingcarrier_carrier_id_9dcaf8c9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shippingcarrier_carrier_id_9dcaf8c9 ON public.orders_shippingcarrier USING btree (carrier_id);


--
-- Name: orders_shippingcarrier_carrier_id_9dcaf8c9_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shippingcarrier_carrier_id_9dcaf8c9_like ON public.orders_shippingcarrier USING btree (carrier_id varchar_pattern_ops);


--
-- Name: orders_shippingcarrier_company_id_e4be95d2; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shippingcarrier_company_id_e4be95d2 ON public.orders_shippingcarrier USING btree (company_id);


--
-- Name: orders_shippingservice_carrier_id_b790b09a; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shippingservice_carrier_id_b790b09a ON public.orders_shippingservice USING btree (carrier_id);


--
-- Name: orders_shippingservice_service_code_b835cff6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shippingservice_service_code_b835cff6 ON public.orders_shippingservice USING btree (service_code);


--
-- Name: orders_shippingservice_service_code_b835cff6_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX orders_shippingservice_service_code_b835cff6_like ON public.orders_shippingservice USING btree (service_code varchar_pattern_ops);


--
-- Name: prescriptio_prescri_304fe4_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptio_prescri_304fe4_idx ON public.prescriptions_prescriptionapirequest USING btree (prescription_id, received_at DESC);


--
-- Name: prescriptions_patient_date_of_birth_cbb4aa38; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patient_date_of_birth_cbb4aa38 ON public.prescriptions_patient USING btree (date_of_birth);


--
-- Name: prescriptions_patient_email_a566daf1; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patient_email_a566daf1 ON public.prescriptions_patient USING btree (email);


--
-- Name: prescriptions_patient_email_a566daf1_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patient_email_a566daf1_like ON public.prescriptions_patient USING btree (email varchar_pattern_ops);


--
-- Name: prescriptions_patient_gender_c93e9832; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patient_gender_c93e9832 ON public.prescriptions_patient USING btree (gender);


--
-- Name: prescriptions_patient_pharmacy_company_id_f57854b6; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patient_pharmacy_company_id_f57854b6 ON public.prescriptions_patient USING btree (pharmacy_company_id);


--
-- Name: prescriptions_patient_provider_company_id_e0916e6b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patient_provider_company_id_e0916e6b ON public.prescriptions_patient USING btree (provider_company_id);


--
-- Name: prescriptions_patient_provider_external_id_c0f61437_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patient_provider_external_id_c0f61437_like ON public.prescriptions_patient USING btree (provider_external_id varchar_pattern_ops);


--
-- Name: prescriptions_patient_readable_id_19251a62_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patient_readable_id_19251a62_like ON public.prescriptions_patient USING btree (readable_id varchar_pattern_ops);


--
-- Name: prescriptions_patientdocument_note_id_d58aa300; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientdocument_note_id_d58aa300 ON public.prescriptions_patientdocument USING btree (note_id);


--
-- Name: prescriptions_patientdocument_patient_id_9b905107; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientdocument_patient_id_9b905107 ON public.prescriptions_patientdocument USING btree (patient_id);


--
-- Name: prescriptions_patientdocument_user_id_4e62b464; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientdocument_user_id_4e62b464 ON public.prescriptions_patientdocument USING btree (user_id);


--
-- Name: prescriptions_patientgua_provider_external_id_fed0bebb_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientgua_provider_external_id_fed0bebb_like ON public.prescriptions_patientguardian USING btree (provider_external_id varchar_pattern_ops);


--
-- Name: prescriptions_patientguardian_email_43ff7926; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientguardian_email_43ff7926 ON public.prescriptions_patientguardian USING btree (email);


--
-- Name: prescriptions_patientguardian_email_43ff7926_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientguardian_email_43ff7926_like ON public.prescriptions_patientguardian USING btree (email varchar_pattern_ops);


--
-- Name: prescriptions_patientguardian_patient_id_e121ed0d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientguardian_patient_id_e121ed0d ON public.prescriptions_patientguardian USING btree (patient_id);


--
-- Name: prescriptions_patientguardian_provider_company_id_317836e9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientguardian_provider_company_id_317836e9 ON public.prescriptions_patientguardian USING btree (provider_company_id);


--
-- Name: prescriptions_patientguardian_provider_external_id_fed0bebb; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientguardian_provider_external_id_fed0bebb ON public.prescriptions_patientguardian USING btree (provider_external_id);


--
-- Name: prescriptions_patientnote_patient_id_7c94ff97; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientnote_patient_id_7c94ff97 ON public.prescriptions_patientnote USING btree (patient_id);


--
-- Name: prescriptions_patientnote_user_id_731728dd; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_patientnote_user_id_731728dd ON public.prescriptions_patientnote USING btree (user_id);


--
-- Name: prescriptions_physician_email_54e2a269; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_email_54e2a269 ON public.prescriptions_physician USING btree (email);


--
-- Name: prescriptions_physician_email_54e2a269_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_email_54e2a269_like ON public.prescriptions_physician USING btree (email varchar_pattern_ops);


--
-- Name: prescriptions_physician_first_name_11f982ee; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_first_name_11f982ee ON public.prescriptions_physician USING btree (first_name);


--
-- Name: prescriptions_physician_first_name_11f982ee_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_first_name_11f982ee_like ON public.prescriptions_physician USING btree (first_name varchar_pattern_ops);


--
-- Name: prescriptions_physician_last_name_2941d07d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_last_name_2941d07d ON public.prescriptions_physician USING btree (last_name);


--
-- Name: prescriptions_physician_last_name_2941d07d_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_last_name_2941d07d_like ON public.prescriptions_physician USING btree (last_name varchar_pattern_ops);


--
-- Name: prescriptions_physician_phone_89ad4f91; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_phone_89ad4f91 ON public.prescriptions_physician USING btree (phone);


--
-- Name: prescriptions_physician_phone_89ad4f91_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_phone_89ad4f91_like ON public.prescriptions_physician USING btree (phone varchar_pattern_ops);


--
-- Name: prescriptions_physician_phone_evening_5f50b4d9; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_phone_evening_5f50b4d9 ON public.prescriptions_physician USING btree (phone_evening);


--
-- Name: prescriptions_physician_phone_evening_5f50b4d9_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_phone_evening_5f50b4d9_like ON public.prescriptions_physician USING btree (phone_evening varchar_pattern_ops);


--
-- Name: prescriptions_physician_provider_company_id_df85819e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_provider_company_id_df85819e ON public.prescriptions_physician USING btree (provider_company_id);


--
-- Name: prescriptions_physician_provider_external_id_4dce25e5; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_provider_external_id_4dce25e5 ON public.prescriptions_physician USING btree (provider_external_id);


--
-- Name: prescriptions_physician_provider_external_id_4dce25e5_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physician_provider_external_id_4dce25e5_like ON public.prescriptions_physician USING btree (provider_external_id varchar_pattern_ops);


--
-- Name: prescriptions_physicianstate_physician_id_b21ad3fd; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_physicianstate_physician_id_b21ad3fd ON public.prescriptions_physicianstate USING btree (physician_id);


--
-- Name: prescriptions_prescription_kind_481e309c; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_kind_481e309c ON public.prescriptions_prescription USING btree (kind);


--
-- Name: prescriptions_prescription_patient_id_22183bec; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_patient_id_22183bec ON public.prescriptions_prescription USING btree (patient_id);


--
-- Name: prescriptions_prescription_pharmacy_company_id_21e197ca; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_pharmacy_company_id_21e197ca ON public.prescriptions_prescription USING btree (pharmacy_company_id);


--
-- Name: prescriptions_prescription_physician_id_414244ae; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_physician_id_414244ae ON public.prescriptions_prescription USING btree (physician_id);


--
-- Name: prescriptions_prescription_product_type_d6cba4b3; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_product_type_d6cba4b3 ON public.prescriptions_prescription USING btree (product_type);


--
-- Name: prescriptions_prescription_provider_company_id_50fea217; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_provider_company_id_50fea217 ON public.prescriptions_prescription USING btree (provider_company_id);


--
-- Name: prescriptions_prescription_provider_external_id_3c508a0b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_provider_external_id_3c508a0b ON public.prescriptions_prescription USING btree (provider_external_id);


--
-- Name: prescriptions_prescription_provider_external_id_3c508a0b_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_provider_external_id_3c508a0b_like ON public.prescriptions_prescription USING btree (provider_external_id varchar_pattern_ops);


--
-- Name: prescriptions_prescription_signed_at_0494a042; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_signed_at_0494a042 ON public.prescriptions_prescription USING btree (signed_at);


--
-- Name: prescriptions_prescription_source_d4cc950e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_source_d4cc950e ON public.prescriptions_prescription USING btree (source);


--
-- Name: prescriptions_prescription_status_057efe0e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescription_status_057efe0e ON public.prescriptions_prescription USING btree (status);


--
-- Name: prescriptions_prescriptionapirequest_prescription_id_b942921a; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptionapirequest_prescription_id_b942921a ON public.prescriptions_prescriptionapirequest USING btree (prescription_id);


--
-- Name: prescriptions_prescriptionapirequest_received_at_bdc720a8; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptionapirequest_received_at_bdc720a8 ON public.prescriptions_prescriptionapirequest USING btree (received_at);


--
-- Name: prescriptions_prescriptionapirequest_user_id_f95b7c4d; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptionapirequest_user_id_f95b7c4d ON public.prescriptions_prescriptionapirequest USING btree (user_id);


--
-- Name: prescriptions_prescriptionapirequest_webhook_type_4061e76f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptionapirequest_webhook_type_4061e76f ON public.prescriptions_prescriptionapirequest USING btree (webhook_type);


--
-- Name: prescriptions_prescriptiondocument_note_id_39930654; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptiondocument_note_id_39930654 ON public.prescriptions_prescriptiondocument USING btree (note_id);


--
-- Name: prescriptions_prescriptiondocument_prescription_id_891b9733; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptiondocument_prescription_id_891b9733 ON public.prescriptions_prescriptiondocument USING btree (prescription_id);


--
-- Name: prescriptions_prescriptiondocument_user_id_e76d7a57; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptiondocument_user_id_e76d7a57 ON public.prescriptions_prescriptiondocument USING btree (user_id);


--
-- Name: prescriptions_prescriptionnote_prescription_id_20ad3e6f; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptionnote_prescription_id_20ad3e6f ON public.prescriptions_prescriptionnote USING btree (prescription_id);


--
-- Name: prescriptions_prescriptionnote_user_id_7d35a929; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX prescriptions_prescriptionnote_user_id_7d35a929 ON public.prescriptions_prescriptionnote USING btree (user_id);


--
-- Name: shipping_shipmentproblem_shipment_id_f36546bc; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX shipping_shipmentproblem_shipment_id_f36546bc ON public.shipping_shipmentproblem USING btree (shipment_id);


--
-- Name: shipping_shippingapirequest_received_at_65c8ae26; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX shipping_shippingapirequest_received_at_65c8ae26 ON public.shipping_shippingapirequest USING btree (received_at);


--
-- Name: shipping_shippingapirequest_shipment_label_id_2eeead7b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX shipping_shippingapirequest_shipment_label_id_2eeead7b ON public.shipping_shippingapirequest USING btree (shipment_label_id);


--
-- Name: shipping_shippingapirequest_user_id_680fd1ce; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX shipping_shippingapirequest_user_id_680fd1ce ON public.shipping_shippingapirequest USING btree (user_id);


--
-- Name: system_featureflag_is_enabled_d03c9c9b; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_featureflag_is_enabled_d03c9c9b ON public.system_featureflag USING btree (is_enabled);


--
-- Name: system_featureflag_name_b4dca0a5_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_featureflag_name_b4dca0a5_like ON public.system_featureflag USING btree (name varchar_pattern_ops);


--
-- Name: system_featureflag_only_for_users_featureflag_id_a4b34557; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_featureflag_only_for_users_featureflag_id_a4b34557 ON public.system_featureflag_only_for_users USING btree (featureflag_id);


--
-- Name: system_featureflag_only_for_users_featureflag_id_a4b34557_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_featureflag_only_for_users_featureflag_id_a4b34557_like ON public.system_featureflag_only_for_users USING btree (featureflag_id varchar_pattern_ops);


--
-- Name: system_featureflag_only_for_users_user_id_c5c28acb; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_featureflag_only_for_users_user_id_c5c28acb ON public.system_featureflag_only_for_users USING btree (user_id);


--
-- Name: system_syst_created_468d99_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_syst_created_468d99_idx ON public.system_systemevent USING btree (created_at DESC);


--
-- Name: system_syst_user_id_b662c5_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_syst_user_id_b662c5_idx ON public.system_systemevent USING btree (user_id, is_hidden);


--
-- Name: system_systemevent_initiated_by_id_da32be49; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_systemevent_initiated_by_id_da32be49 ON public.system_systemevent USING btree (initiated_by_id);


--
-- Name: system_systemevent_is_hidden_516e55aa; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_systemevent_is_hidden_516e55aa ON public.system_systemevent USING btree (is_hidden);


--
-- Name: system_systemevent_patient_id_0b8575dc; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_systemevent_patient_id_0b8575dc ON public.system_systemevent USING btree (patient_id);


--
-- Name: system_systemevent_subject_ct_id_7b44fe74; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_systemevent_subject_ct_id_7b44fe74 ON public.system_systemevent USING btree (subject_ct_id);


--
-- Name: system_systemevent_user_id_0c6b7862; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX system_systemevent_user_id_0c6b7862 ON public.system_systemevent USING btree (user_id);


--
-- Name: unique_provider_external_id_per_company; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX unique_provider_external_id_per_company ON public.prescriptions_prescription USING btree (provider_external_id, provider_company_id) WHERE ((provider_external_id IS NOT NULL) AND (NOT (((provider_external_id)::text = ''::text) AND (provider_external_id IS NOT NULL))));


--
-- Name: webhooks_pr_created_c9ece0_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_pr_created_c9ece0_idx ON public.webhooks_providercompanywebhooknotification USING btree (created_at DESC);


--
-- Name: webhooks_providercompanywe_provider_company_id_afcc6791; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_providercompanywe_provider_company_id_afcc6791 ON public.webhooks_providercompanywebhooknotification USING btree (provider_company_id);


--
-- Name: webhooks_sh_status__3b9534_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_sh_status__3b9534_idx ON public.webhooks_shipmenttrackingevent USING btree (status_code, occurred_at DESC);


--
-- Name: webhooks_sh_trackin_7b9831_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_sh_trackin_7b9831_idx ON public.webhooks_shipmenttrackingevent USING btree (tracking_number, occurred_at DESC);


--
-- Name: webhooks_shipmenttrackingevent_shipment_id_bc482e32; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_shipmenttrackingevent_shipment_id_bc482e32 ON public.webhooks_shipmenttrackingevent USING btree (shipment_id);


--
-- Name: webhooks_shipmenttrackingevent_status_code_35858996; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_shipmenttrackingevent_status_code_35858996 ON public.webhooks_shipmenttrackingevent USING btree (status_code);


--
-- Name: webhooks_shipmenttrackingevent_status_code_35858996_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_shipmenttrackingevent_status_code_35858996_like ON public.webhooks_shipmenttrackingevent USING btree (status_code varchar_pattern_ops);


--
-- Name: webhooks_shipmenttrackingevent_tracking_number_5ee3ee93; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_shipmenttrackingevent_tracking_number_5ee3ee93 ON public.webhooks_shipmenttrackingevent USING btree (tracking_number);


--
-- Name: webhooks_shipmenttrackingevent_tracking_number_5ee3ee93_like; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_shipmenttrackingevent_tracking_number_5ee3ee93_like ON public.webhooks_shipmenttrackingevent USING btree (tracking_number varchar_pattern_ops);


--
-- Name: webhooks_shipmenttrackingevent_webhook_request_id_66078ff5; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_shipmenttrackingevent_webhook_request_id_66078ff5 ON public.webhooks_shipmenttrackingevent USING btree (webhook_request_id);


--
-- Name: webhooks_we_created_9001a9_idx; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_we_created_9001a9_idx ON public.webhooks_webhookrequest USING btree (created_at DESC);


--
-- Name: webhooks_webhookrequest_source_822fb776; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX webhooks_webhookrequest_source_822fb776 ON public.webhooks_webhookrequest USING btree (source);


--
-- Name: accounts_pharmacist accounts_pharmacist_user_ptr_id_d024c27c_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_pharmacist
    ADD CONSTRAINT accounts_pharmacist_user_ptr_id_d024c27c_fk_accounts_user_id FOREIGN KEY (user_ptr_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user accounts_user_company_id_bc91fe74_fk_accounts_company_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_company_id_bc91fe74_fk_accounts_company_id FOREIGN KEY (company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_billinginvoice_transactions billing_billinginvoi_billinginvoice_id_5c8dbcba_fk_billing_b; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_billinginvoice_transactions
    ADD CONSTRAINT billing_billinginvoi_billinginvoice_id_5c8dbcba_fk_billing_b FOREIGN KEY (billinginvoice_id) REFERENCES public.billing_billinginvoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_billinginvoice billing_billinginvoi_pharmacy_company_id_1438bf9e_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_billinginvoice
    ADD CONSTRAINT billing_billinginvoi_pharmacy_company_id_1438bf9e_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_billinginvoice billing_billinginvoi_provider_company_id_0a4908d5_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_billinginvoice
    ADD CONSTRAINT billing_billinginvoi_provider_company_id_0a4908d5_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_billinginvoice_transactions billing_billinginvoi_transaction_id_d3e9c480_fk_billing_t; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_billinginvoice_transactions
    ADD CONSTRAINT billing_billinginvoi_transaction_id_d3e9c480_fk_billing_t FOREIGN KEY (transaction_id) REFERENCES public.billing_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_transaction billing_transaction_created_by_id_e240efc3_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_transaction
    ADD CONSTRAINT billing_transaction_created_by_id_e240efc3_fk_accounts_user_id FOREIGN KEY (created_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_transaction billing_transaction_order_id_d731e333_fk_orders_fillorder_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_transaction
    ADD CONSTRAINT billing_transaction_order_id_d731e333_fk_orders_fillorder_id FOREIGN KEY (order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_transaction billing_transaction_pharmacy_company_id_43cd6687_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_transaction
    ADD CONSTRAINT billing_transaction_pharmacy_company_id_43cd6687_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_transaction billing_transaction_provider_company_id_85ff84f0_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.billing_transaction
    ADD CONSTRAINT billing_transaction_provider_company_id_85ff84f0_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxauditevent faxorder_faxauditeve_fax_document_id_90173a1c_fk_faxorder_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxauditevent
    ADD CONSTRAINT faxorder_faxauditeve_fax_document_id_90173a1c_fk_faxorder_ FOREIGN KEY (fax_document_id) REFERENCES public.faxorder_faxdocument(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxauditevent faxorder_faxauditevent_user_id_0dcedcb7_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxauditevent
    ADD CONSTRAINT faxorder_faxauditevent_user_id_0dcedcb7_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxdocumentpage faxorder_faxdocument_fax_document_id_58568a4d_fk_faxorder_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocumentpage
    ADD CONSTRAINT faxorder_faxdocument_fax_document_id_58568a4d_fk_faxorder_ FOREIGN KEY (fax_document_id) REFERENCES public.faxorder_faxdocument(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxdocument faxorder_faxdocument_order_id_65185428_fk_orders_fillorder_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocument
    ADD CONSTRAINT faxorder_faxdocument_order_id_65185428_fk_orders_fillorder_id FOREIGN KEY (order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxdocumentpage faxorder_faxdocument_order_id_65daa22f_fk_orders_fi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocumentpage
    ADD CONSTRAINT faxorder_faxdocument_order_id_65daa22f_fk_orders_fi FOREIGN KEY (order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxdocument faxorder_faxdocument_pharmacy_company_id_2f10c565_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocument
    ADD CONSTRAINT faxorder_faxdocument_pharmacy_company_id_2f10c565_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxdocument faxorder_faxdocument_prescription_id_980b2bd2_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocument
    ADD CONSTRAINT faxorder_faxdocument_prescription_id_980b2bd2_fk_prescript FOREIGN KEY (prescription_id) REFERENCES public.prescriptions_prescription(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxdocument faxorder_faxdocument_provider_company_id_a79fba3d_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocument
    ADD CONSTRAINT faxorder_faxdocument_provider_company_id_a79fba3d_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxdocument faxorder_faxdocument_reviewed_by_id_142183c9_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocument
    ADD CONSTRAINT faxorder_faxdocument_reviewed_by_id_142183c9_fk_accounts_ FOREIGN KEY (reviewed_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxdocument faxorder_faxdocument_template_config_id_ae33a4ca_fk_faxorder_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxdocument
    ADD CONSTRAINT faxorder_faxdocument_template_config_id_ae33a4ca_fk_faxorder_ FOREIGN KEY (template_config_id) REFERENCES public.faxorder_faxtemplateconfig(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxtemplateconfig faxorder_faxtemplate_pharmacy_company_id_1d230d26_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxtemplateconfig
    ADD CONSTRAINT faxorder_faxtemplate_pharmacy_company_id_1d230d26_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxtemplateconfig faxorder_faxtemplate_provider_company_id_059d350b_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxtemplateconfig
    ADD CONSTRAINT faxorder_faxtemplate_provider_company_id_059d350b_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxwebhookrequest faxorder_faxwebhookr_fax_document_id_fb6da6ec_fk_faxorder_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxwebhookrequest
    ADD CONSTRAINT faxorder_faxwebhookr_fax_document_id_fb6da6ec_fk_faxorder_ FOREIGN KEY (fax_document_id) REFERENCES public.faxorder_faxdocument(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faxorder_faxwebhookrequest faxorder_faxwebhookrequest_user_id_e7e64f51_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.faxorder_faxwebhookrequest
    ADD CONSTRAINT faxorder_faxwebhookrequest_user_id_e7e64f51_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ingredients_inventory ingredients_ingredie_ingredient_id_363b2ebb_fk_ingredien; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_inventory
    ADD CONSTRAINT ingredients_ingredie_ingredient_id_363b2ebb_fk_ingredien FOREIGN KEY (ingredient_id) REFERENCES public.ingredients_ingredient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ingredients_ingredientmap ingredients_ingredie_ingredient_id_e8ffc8c8_fk_ingredien; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ingredientmap
    ADD CONSTRAINT ingredients_ingredie_ingredient_id_e8ffc8c8_fk_ingredien FOREIGN KEY (ingredient_id) REFERENCES public.ingredients_ingredient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ingredients_ingredient ingredients_ingredie_ndc_id_e4375fdd_fk_ingredien; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ingredient
    ADD CONSTRAINT ingredients_ingredie_ndc_id_e4375fdd_fk_ingredien FOREIGN KEY (ndc_id) REFERENCES public.ingredients_ndcpharmaceutical(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ingredients_ingredientmap ingredients_ingredie_pharmacy_company_id_8b7f3b24_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ingredientmap
    ADD CONSTRAINT ingredients_ingredie_pharmacy_company_id_8b7f3b24_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ingredients_ingredientmap ingredients_ingredie_provider_company_id_f6847e15_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ingredientmap
    ADD CONSTRAINT ingredients_ingredie_provider_company_id_f6847e15_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ingredients_ingredientmap ingredients_ingredientmap_user_id_f32699d2_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ingredientmap
    ADD CONSTRAINT ingredients_ingredientmap_user_id_f32699d2_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ingredients_inventory ingredients_inventor_pharmacy_company_id_6ff8abfc_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_inventory
    ADD CONSTRAINT ingredients_inventor_pharmacy_company_id_6ff8abfc_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ingredients_ndcpharmaceutical ingredients_ndcpharm_manufacturer_id_e9496359_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_ndcpharmaceutical
    ADD CONSTRAINT ingredients_ndcpharm_manufacturer_id_e9496359_fk_accounts_ FOREIGN KEY (manufacturer_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_locked_by_id_22c88679_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_locked_by_id_22c88679_fk_accounts_user_id FOREIGN KEY (locked_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_parent_fill_order_id_194de8ad_fk_orders_fi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_parent_fill_order_id_194de8ad_fk_orders_fi FOREIGN KEY (parent_fill_order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_patient_id_7ab72d47_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_patient_id_7ab72d47_fk_prescript FOREIGN KEY (patient_id) REFERENCES public.prescriptions_patient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_pharmacist_id_3e1517f8_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_pharmacist_id_3e1517f8_fk_accounts_user_id FOREIGN KEY (pharmacist_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_pharmacy_company_id_7e8f5a41_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_pharmacy_company_id_7e8f5a41_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_prescription_id_2ea96956_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_prescription_id_2ea96956_fk_prescript FOREIGN KEY (prescription_id) REFERENCES public.prescriptions_prescription(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_provider_company_id_f2b475ff_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_provider_company_id_f2b475ff_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_technician_id_02fb3f31_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_technician_id_02fb3f31_fk_accounts_user_id FOREIGN KEY (technician_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorder orders_fillorder_verified_by_id_6f23e158_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorder
    ADD CONSTRAINT orders_fillorder_verified_by_id_6f23e158_fk_accounts_user_id FOREIGN KEY (verified_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderapirequest orders_fillorderapir_fill_order_id_1be369b7_fk_orders_fi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderapirequest
    ADD CONSTRAINT orders_fillorderapir_fill_order_id_1be369b7_fk_orders_fi FOREIGN KEY (fill_order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderapirequest orders_fillorderapirequest_user_id_4acb538f_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderapirequest
    ADD CONSTRAINT orders_fillorderapirequest_user_id_4acb538f_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderingredientevent orders_fillorderingr_fill_order_ingredien_2d91595e_fk_orders_fi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderingredientevent
    ADD CONSTRAINT orders_fillorderingr_fill_order_ingredien_2d91595e_fk_orders_fi FOREIGN KEY (fill_order_ingredient_id) REFERENCES public.orders_fillorderingredient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderingredientevent orders_fillorderingr_inventory_id_343bccfd_fk_ingredien; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderingredientevent
    ADD CONSTRAINT orders_fillorderingr_inventory_id_343bccfd_fk_ingredien FOREIGN KEY (inventory_id) REFERENCES public.ingredients_inventory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderingredient orders_fillorderingr_inventory_id_748ca30d_fk_ingredien; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderingredient
    ADD CONSTRAINT orders_fillorderingr_inventory_id_748ca30d_fk_ingredien FOREIGN KEY (inventory_id) REFERENCES public.ingredients_inventory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderingredient orders_fillorderingr_order_id_90b2b23e_fk_orders_fi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderingredient
    ADD CONSTRAINT orders_fillorderingr_order_id_90b2b23e_fk_orders_fi FOREIGN KEY (order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderingredientevent orders_fillorderingr_user_id_76f891b9_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderingredientevent
    ADD CONSTRAINT orders_fillorderingr_user_id_76f891b9_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderstatusevent orders_fillorderstat_fill_order_id_6f869b37_fk_orders_fi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderstatusevent
    ADD CONSTRAINT orders_fillorderstat_fill_order_id_6f869b37_fk_orders_fi FOREIGN KEY (fill_order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_fillorderstatusevent orders_fillorderstat_user_id_b95e6231_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_fillorderstatusevent
    ADD CONSTRAINT orders_fillorderstat_user_id_b95e6231_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderdocument orders_orderdocument_fill_order_id_339dfe2c_fk_orders_fi; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_orderdocument
    ADD CONSTRAINT orders_orderdocument_fill_order_id_339dfe2c_fk_orders_fi FOREIGN KEY (fill_order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderdocument orders_orderdocument_note_id_ea4a6880_fk_orders_ordernote_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_orderdocument
    ADD CONSTRAINT orders_orderdocument_note_id_ea4a6880_fk_orders_ordernote_id FOREIGN KEY (note_id) REFERENCES public.orders_ordernote(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderdocument orders_orderdocument_user_id_70164748_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_orderdocument
    ADD CONSTRAINT orders_orderdocument_user_id_70164748_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_ordernote orders_ordernote_fill_order_id_11aec1a0_fk_orders_fillorder_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_ordernote
    ADD CONSTRAINT orders_ordernote_fill_order_id_11aec1a0_fk_orders_fillorder_id FOREIGN KEY (fill_order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_ordernote orders_ordernote_user_id_c8dec706_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_ordernote
    ADD CONSTRAINT orders_ordernote_user_id_c8dec706_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_shipment orders_shipment_order_id_661ed8ed_fk_orders_fillorder_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shipment
    ADD CONSTRAINT orders_shipment_order_id_661ed8ed_fk_orders_fillorder_id FOREIGN KEY (order_id) REFERENCES public.orders_fillorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_shipment orders_shipment_pharmacy_id_75bd84e7_fk_accounts_company_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shipment
    ADD CONSTRAINT orders_shipment_pharmacy_id_75bd84e7_fk_accounts_company_id FOREIGN KEY (pharmacy_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_shipment orders_shipment_prescription_id_dc25cda4_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shipment
    ADD CONSTRAINT orders_shipment_prescription_id_dc25cda4_fk_prescript FOREIGN KEY (prescription_id) REFERENCES public.prescriptions_prescription(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_shipmentlabel orders_shipmentlabel_shipment_id_d0d1819f_fk_orders_shipment_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shipmentlabel
    ADD CONSTRAINT orders_shipmentlabel_shipment_id_d0d1819f_fk_orders_shipment_id FOREIGN KEY (shipment_id) REFERENCES public.orders_shipment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_shippingcarrier orders_shippingcarri_company_id_e4be95d2_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shippingcarrier
    ADD CONSTRAINT orders_shippingcarri_company_id_e4be95d2_fk_accounts_ FOREIGN KEY (company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_shippingservice orders_shippingservi_carrier_id_b790b09a_fk_orders_sh; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders_shippingservice
    ADD CONSTRAINT orders_shippingservi_carrier_id_b790b09a_fk_orders_sh FOREIGN KEY (carrier_id) REFERENCES public.orders_shippingcarrier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patientdocument prescriptions_patien_note_id_d58aa300_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientdocument
    ADD CONSTRAINT prescriptions_patien_note_id_d58aa300_fk_prescript FOREIGN KEY (note_id) REFERENCES public.prescriptions_patientnote(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patientnote prescriptions_patien_patient_id_7c94ff97_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientnote
    ADD CONSTRAINT prescriptions_patien_patient_id_7c94ff97_fk_prescript FOREIGN KEY (patient_id) REFERENCES public.prescriptions_patient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patientdocument prescriptions_patien_patient_id_9b905107_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientdocument
    ADD CONSTRAINT prescriptions_patien_patient_id_9b905107_fk_prescript FOREIGN KEY (patient_id) REFERENCES public.prescriptions_patient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patientguardian prescriptions_patien_patient_id_e121ed0d_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientguardian
    ADD CONSTRAINT prescriptions_patien_patient_id_e121ed0d_fk_prescript FOREIGN KEY (patient_id) REFERENCES public.prescriptions_patient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patient prescriptions_patien_pharmacy_company_id_f57854b6_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patient
    ADD CONSTRAINT prescriptions_patien_pharmacy_company_id_f57854b6_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patientguardian prescriptions_patien_provider_company_id_317836e9_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientguardian
    ADD CONSTRAINT prescriptions_patien_provider_company_id_317836e9_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patient prescriptions_patien_provider_company_id_e0916e6b_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patient
    ADD CONSTRAINT prescriptions_patien_provider_company_id_e0916e6b_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patientdocument prescriptions_patien_user_id_4e62b464_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientdocument
    ADD CONSTRAINT prescriptions_patien_user_id_4e62b464_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_patientnote prescriptions_patientnote_user_id_731728dd_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_patientnote
    ADD CONSTRAINT prescriptions_patientnote_user_id_731728dd_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_physicianstate prescriptions_physic_physician_id_b21ad3fd_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_physicianstate
    ADD CONSTRAINT prescriptions_physic_physician_id_b21ad3fd_fk_prescript FOREIGN KEY (physician_id) REFERENCES public.prescriptions_physician(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_physician prescriptions_physic_provider_company_id_df85819e_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_physician
    ADD CONSTRAINT prescriptions_physic_provider_company_id_df85819e_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescriptiondocument prescriptions_prescr_note_id_39930654_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptiondocument
    ADD CONSTRAINT prescriptions_prescr_note_id_39930654_fk_prescript FOREIGN KEY (note_id) REFERENCES public.prescriptions_prescriptionnote(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescription prescriptions_prescr_patient_id_22183bec_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescription
    ADD CONSTRAINT prescriptions_prescr_patient_id_22183bec_fk_prescript FOREIGN KEY (patient_id) REFERENCES public.prescriptions_patient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescription prescriptions_prescr_pharmacy_company_id_21e197ca_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescription
    ADD CONSTRAINT prescriptions_prescr_pharmacy_company_id_21e197ca_fk_accounts_ FOREIGN KEY (pharmacy_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescription prescriptions_prescr_physician_id_414244ae_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescription
    ADD CONSTRAINT prescriptions_prescr_physician_id_414244ae_fk_prescript FOREIGN KEY (physician_id) REFERENCES public.prescriptions_physician(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescriptionnote prescriptions_prescr_prescription_id_20ad3e6f_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptionnote
    ADD CONSTRAINT prescriptions_prescr_prescription_id_20ad3e6f_fk_prescript FOREIGN KEY (prescription_id) REFERENCES public.prescriptions_prescription(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescriptiondocument prescriptions_prescr_prescription_id_891b9733_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptiondocument
    ADD CONSTRAINT prescriptions_prescr_prescription_id_891b9733_fk_prescript FOREIGN KEY (prescription_id) REFERENCES public.prescriptions_prescription(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescriptionapirequest prescriptions_prescr_prescription_id_b942921a_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptionapirequest
    ADD CONSTRAINT prescriptions_prescr_prescription_id_b942921a_fk_prescript FOREIGN KEY (prescription_id) REFERENCES public.prescriptions_prescription(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescription prescriptions_prescr_provider_company_id_50fea217_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescription
    ADD CONSTRAINT prescriptions_prescr_provider_company_id_50fea217_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescriptionnote prescriptions_prescr_user_id_7d35a929_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptionnote
    ADD CONSTRAINT prescriptions_prescr_user_id_7d35a929_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescriptiondocument prescriptions_prescr_user_id_e76d7a57_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptiondocument
    ADD CONSTRAINT prescriptions_prescr_user_id_e76d7a57_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prescriptions_prescriptionapirequest prescriptions_prescr_user_id_f95b7c4d_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.prescriptions_prescriptionapirequest
    ADD CONSTRAINT prescriptions_prescr_user_id_f95b7c4d_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: shipping_shipmentproblem shipping_shipmentpro_shipment_id_f36546bc_fk_orders_sh; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.shipping_shipmentproblem
    ADD CONSTRAINT shipping_shipmentpro_shipment_id_f36546bc_fk_orders_sh FOREIGN KEY (shipment_id) REFERENCES public.orders_shipment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: shipping_shippingapirequest shipping_shippingapi_shipment_label_id_2eeead7b_fk_orders_sh; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.shipping_shippingapirequest
    ADD CONSTRAINT shipping_shippingapi_shipment_label_id_2eeead7b_fk_orders_sh FOREIGN KEY (shipment_label_id) REFERENCES public.orders_shipmentlabel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: shipping_shippingapirequest shipping_shippingapi_user_id_680fd1ce_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.shipping_shippingapirequest
    ADD CONSTRAINT shipping_shippingapi_user_id_680fd1ce_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: system_featureflag_only_for_users system_featureflag_o_featureflag_id_a4b34557_fk_system_fe; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_featureflag_only_for_users
    ADD CONSTRAINT system_featureflag_o_featureflag_id_a4b34557_fk_system_fe FOREIGN KEY (featureflag_id) REFERENCES public.system_featureflag(name) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: system_featureflag_only_for_users system_featureflag_o_user_id_c5c28acb_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_featureflag_only_for_users
    ADD CONSTRAINT system_featureflag_o_user_id_c5c28acb_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: system_systemevent system_systemevent_initiated_by_id_da32be49_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_systemevent
    ADD CONSTRAINT system_systemevent_initiated_by_id_da32be49_fk_accounts_user_id FOREIGN KEY (initiated_by_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: system_systemevent system_systemevent_patient_id_0b8575dc_fk_prescript; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_systemevent
    ADD CONSTRAINT system_systemevent_patient_id_0b8575dc_fk_prescript FOREIGN KEY (patient_id) REFERENCES public.prescriptions_patient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: system_systemevent system_systemevent_subject_ct_id_7b44fe74_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_systemevent
    ADD CONSTRAINT system_systemevent_subject_ct_id_7b44fe74_fk_django_co FOREIGN KEY (subject_ct_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: system_systemevent system_systemevent_user_id_0c6b7862_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.system_systemevent
    ADD CONSTRAINT system_systemevent_user_id_0c6b7862_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: webhooks_providercompanywebhookurls webhooks_providercom_provider_company_id_1edc35fa_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_providercompanywebhookurls
    ADD CONSTRAINT webhooks_providercom_provider_company_id_1edc35fa_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: webhooks_providercompanywebhooknotification webhooks_providercom_provider_company_id_afcc6791_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_providercompanywebhooknotification
    ADD CONSTRAINT webhooks_providercom_provider_company_id_afcc6791_fk_accounts_ FOREIGN KEY (provider_company_id) REFERENCES public.accounts_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: webhooks_shipmenttrackingevent webhooks_shipmenttra_shipment_id_bc482e32_fk_orders_sh; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_shipmenttrackingevent
    ADD CONSTRAINT webhooks_shipmenttra_shipment_id_bc482e32_fk_orders_sh FOREIGN KEY (shipment_id) REFERENCES public.orders_shipment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: webhooks_shipmenttrackingevent webhooks_shipmenttra_webhook_request_id_66078ff5_fk_webhooks_; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.webhooks_shipmenttrackingevent
    ADD CONSTRAINT webhooks_shipmenttra_webhook_request_id_66078ff5_fk_webhooks_ FOREIGN KEY (webhook_request_id) REFERENCES public.webhooks_webhookrequest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--


