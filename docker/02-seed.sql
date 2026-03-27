-- Minimal seed data for IVM crash reproduction.
-- Only 3 rows needed: 1 company, 1 patient, 1 fill order.
-- FK checks disabled — referentially complete data not required.
SET session_replication_role = 'replica';

-- Company row: the related table that triggers the crash.
-- Table name "accounts_company" sorts before "prescriptions_patient" alphabetically,
-- so its data is pushed through the IVM pipeline first during poke processing.
INSERT INTO accounts_company (
  id, name, type, phone, fax, email, email2, memo, memo_shipping,
  address_history, created_at, updated_at, legal_name, is_active
) VALUES (
  'aaaaaaaa-0000-0000-0000-000000000001',
  'Test Company',
  'provider',
  '', '', '', '', '', '',
  '{}'::jsonb,
  NOW(), NOW(),
  '', true
) ON CONFLICT DO NOTHING;

-- Patient row: provider_company_id points to the company above.
-- This ensures patient.assignmentList().related('providerCompany') joins to a real row.
INSERT INTO prescriptions_patient (
  id, first_name, last_name, middle_name, preferred_name, phone, email,
  date_of_birth, species, gender, is_pregnant, allergies,
  provider_company_id, disease_history, medical_history,
  pharmacy_company_id, is_anaphylactic, sequence_id, display_date_of_birth, medications,
  created_at, updated_at
) VALUES (
  'bbbbbbbb-0000-0000-0000-000000000001',
  'Jane', 'Doe', '', '', '', '',
  '1990-01-01', 'human', 'female', false, '',
  'aaaaaaaa-0000-0000-0000-000000000001',
  '{}'::jsonb, '{}'::jsonb,
  'aaaaaaaa-0000-0000-0000-000000000001',
  false, 1, '01/01/1990', '',
  NOW(), NOW()
) ON CONFLICT DO NOTHING;

-- Fill order: provider_company_id points to the company.
-- Query 2 fetches this order with .related('providerCompany'),
-- causing accounts_company data to appear in the poke.
INSERT INTO orders_fillorder (
  id, sequence_id, fill_id, order_type, order_status,
  address_line_1, address_line_2, address_line_3, city, state, zipcode,
  memo, is_problem_with_order, is_hold_for_payment, is_active,
  manifest_url, prescription_id, provider_company_id, patient_id,
  additional_details, has_related_orders, order_source,
  created_at, updated_at
) VALUES (
  'cccccccc-0000-0000-0000-000000000001',
  1, 'TEST001', 'new_rx', 'not_filled',
  '123 Test St', '', '', 'Anytown', 'NY', '10001',
  '', false, false, true,
  '', 'dddddddd-0000-0000-0000-000000000001',
  'aaaaaaaa-0000-0000-0000-000000000001',
  'bbbbbbbb-0000-0000-0000-000000000001',
  '{}'::jsonb, false, 'api',
  NOW(), NOW()
) ON CONFLICT DO NOTHING;

SET session_replication_role = 'origin';
