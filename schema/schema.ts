import type { ReadonlyJSONValue, Row } from '@rocicorp/zero';
import {
  ANYONE_CAN,
  boolean,
  createBuilder,
  createSchema,
  definePermissions,
  enumeration,
  json,
  number,
  relationships,
  string,
  table,
} from '@rocicorp/zero';

// Typed JSON column interfaces (generated from schema-generator-config)
interface IngredientEventSnapshot {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  readonly dilution_display?: string;
  readonly dilution_number?: number;
  readonly dilution_value?: string;
  readonly inventory?: {
    readonly lot_id?: string;
    readonly ndc_code?: string;
  };
  readonly is_active?: boolean;
  readonly qty?: number;
}

const bedrockCacheTable = table('bedrockCache')
  .from('faxorder_bedrockcache')
  .columns({
    createdAt: number().from('created_at'),
    cropHash: string().from('crop_hash'),
    id: string(),
    modelId: string().from('model_id'),
    promptProfile: string().from('prompt_profile'),
    responseData: json().from('response_data'),
    tokensInput: number().from('tokens_input'),
    tokensOutput: number().from('tokens_output'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const billingInvoiceTable = table('billingInvoice')
  .from('billing_billinginvoice')
  .columns({
    createdAt: number().from('created_at'),
    id: string(),
    pharmacyCompanyId: string().from('pharmacy_company_id'),
    providerCompanyId: string().from('provider_company_id'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const companyTable = table('company')
  .from('accounts_company')
  .columns({
    addressHistory: json().from('address_history'),
    addressLine1: string().optional().from('address_line_1'),
    addressLine2: string().optional().from('address_line_2'),
    addressLine3: string().optional().from('address_line_3'),
    city: string().optional(),
    createdAt: number().from('created_at'),
    deletedAt: number().optional().from('deleted_at'),
    email: string(),
    email2: string(),
    fax: string(),
    id: string(),
    isActive: boolean().from('is_active'),
    legalName: string().from('legal_name'),
    memo: string(),
    memoShipping: string().from('memo_shipping'),
    name: string(),
    phone: string(),
    state: string().optional(),
    type: enumeration<'ingredient_supplier' | 'pharmacy' | 'provider'>(),
    updatedAt: number().from('updated_at'),
    zipcode: string().optional(),
  })
  .primaryKey('id');

const faxAuditEventTable = table('faxAuditEvent')
  .from('faxorder_faxauditevent')
  .columns({
    additionalDetails: json().from('additional_details'),
    changes: json(),
    createdAt: number().from('created_at'),
    eventType: enumeration<'data_edited' | 'review_completed' | 'review_started' | 'routing_corrected'>().from(
      'event_type',
    ),
    faxDocumentId: string().from('fax_document_id'),
    id: string(),
    memo: string(),
    reviewCompletedAt: number().optional().from('review_completed_at'),
    reviewStartedAt: number().optional().from('review_started_at'),
    updatedAt: number().from('updated_at'),
    userId: string().from('user_id'),
  })
  .primaryKey('id');

const faxDocumentTable = table('faxDocument')
  .from('faxorder_faxdocument')
  .columns({
    additionalDetails: json().from('additional_details'),
    bedrockData: json().from('bedrock_data'),
    createdAt: number().from('created_at'),
    documentId: string().optional().from('document_id'),
    errorMessage: string().from('error_message'),
    extractionData: json().from('extraction_data'),
    faxReceiver: string().optional().from('fax_receiver'),
    faxSender: string().optional().from('fax_sender'),
    faxType: enumeration<'other' | 'prescription' | 'test'>().optional().from('fax_type'),
    id: string(),
    memo: string(),
    normalizedData: json().from('normalized_data'),
    numberOfPages: number().from('number_of_pages'),
    orderId: string().optional().from('order_id'),
    pharmacyCompanyId: string().optional().from('pharmacy_company_id'),
    preprocessMeta: json().from('preprocess_meta'),
    prescriptionId: string().optional().from('prescription_id'),
    prescriptionKind: enumeration<'formula_modification' | 'initial' | 'renewal' | 'unknown'>()
      .optional()
      .from('prescription_kind'),
    processingCompletedAt: number().optional().from('processing_completed_at'),
    processingStartedAt: number().optional().from('processing_started_at'),
    providerCompanyId: string().optional().from('provider_company_id'),
    receivedAt: number().from('received_at'),
    reviewedAt: number().optional().from('reviewed_at'),
    reviewedById: string().optional().from('reviewed_by_id'),
    reviewReasons: json().from('review_reasons'),
    reviewRegions: json().from('review_regions'),
    routingConfidence: number().optional().from('routing_confidence'),
    routingMethod: enumeration<'bedrock' | 'review' | 'textract'>().optional().from('routing_method'),
    sequenceId: number().optional().from('sequence_id'),
    sourceFileUrl: string().from('source_file_url'),
    sourceType: enumeration<'fax' | 'manual_upload'>().from('source_type'),
    status: enumeration<
      'complete' | 'failed' | 'order_created' | 'processing' | 'queued' | 'rejected' | 'review_required'
    >(),
    templateConfigId: string().optional().from('template_config_id'),
    templateFamily: string().from('template_family'),
    templateVersion: string().from('template_version'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const faxDocumentPageTable = table('faxDocumentPage')
  .from('faxorder_faxdocumentpage')
  .columns({
    createdAt: number().from('created_at'),
    extractionData: json().from('extraction_data'),
    faxDocumentId: string().from('fax_document_id'),
    id: string(),
    orderId: string().optional().from('order_id'),
    pageCleanUrl: string().from('page_clean_url'),
    pageNumber: number().from('page_number'),
    pageRawUrl: string().from('page_raw_url'),
    preprocessMeta: json().from('preprocess_meta'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const faxTemplateConfigTable = table('faxTemplateConfig')
  .from('faxorder_faxtemplateconfig')
  .columns({
    anchorPhrases: json().from('anchor_phrases'),
    bundleDefinitions: json().from('bundle_definitions'),
    createdAt: number().from('created_at'),
    family: string(),
    id: string(),
    isActive: boolean().from('is_active'),
    memo: string(),
    pharmacyCompanyId: string().optional().from('pharmacy_company_id'),
    prescriptionKinds: json().from('prescription_kinds'),
    providerCompanyId: string().optional().from('provider_company_id'),
    qtyRules: json().from('qty_rules'),
    routingConfidenceThreshold: number().from('routing_confidence_threshold'),
    textractBundles: json().from('textract_bundles'),
    updatedAt: number().from('updated_at'),
    validationOverrides: json().from('validation_overrides'),
    version: string(),
  })
  .primaryKey('id');

const faxWebhookRequestTable = table('faxWebhookRequest')
  .from('faxorder_faxwebhookrequest')
  .columns({
    context: string().optional(),
    createdAt: number().from('created_at'),
    durationSeconds: number().optional().from('duration_seconds'),
    faxDocumentId: string().optional().from('fax_document_id'),
    faxReceivedTime: number().optional().from('fax_received_time'),
    id: string(),
    jobId: string().from('job_id'),
    pageCount: number().optional().from('page_count'),
    processedAt: number().optional().from('processed_at'),
    processingError: string().from('processing_error'),
    receivedAt: number().from('received_at'),
    receiverFax: string().from('receiver_fax'),
    senderFax: string().from('sender_fax'),
    transactionId: string().from('transaction_id'),
    updatedAt: number().from('updated_at'),
    userAgent: string().optional().from('user_agent'),
    userId: string().optional().from('user_id'),
    webhookData: json().from('webhook_data'),
  })
  .primaryKey('id');

const featureFlagTable = table('featureFlag')
  .from('system_featureflag')
  .columns({
    createdAt: number().from('created_at'),
    description: string(),
    isEnabled: boolean().from('is_enabled'),
    name: string(),
    runCounter: number().from('run_counter'),
    runNoMoreThan: number().from('run_no_more_than'),
    settings: json(),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('name');

const fillOrderTable = table('fillOrder')
  .from('orders_fillorder')
  .columns({
    additionalDetails: json().from('additional_details'),
    addressLine1: string().from('address_line_1'),
    addressLine2: string().from('address_line_2'),
    addressLine3: string().from('address_line_3'),
    addressVerifiedAt: number().optional().from('address_verified_at'),
    city: string(),
    createdAt: number().from('created_at'),
    deletedAt: number().optional().from('deleted_at'),
    fillId: string().optional().from('fill_id'),
    fillNumber: number().optional().from('fill_number'),
    hasRelatedOrders: boolean().from('has_related_orders'),
    id: string(),
    isActive: boolean().from('is_active'),
    isHoldForPayment: boolean().from('is_hold_for_payment'),
    isProblemWithOrder: boolean().from('is_problem_with_order'),
    labelsPdfUrl: string().optional().from('labels_pdf_url'),
    lockedById: string().optional().from('locked_by_id'),
    lockedUntil: number().optional().from('locked_until'),
    manifestUrl: string().from('manifest_url'),
    memo: string(),
    nextShipmentDate: number().optional().from('next_shipment_date'),
    nextShipmentDateText: string().optional().from('next_shipment_date_text'),
    orderDate: number().optional().from('order_date'),
    orderSource: enumeration<'api' | 'fax'>().from('order_source'),
    orderStatus: enumeration<
      | 'consultation_required'
      | 'hold_file'
      | 'in_progress'
      | 'labels_printed'
      | 'not_filled'
      | 'rejected'
      | 'shipped'
      | 'shipping_error'
      | 'shipping_pickup'
      | 'unverified'
      | 'verified'
      | 'waiting'
    >().from('order_status'),
    orderType: enumeration<'new_rx' | 'refill'>().from('order_type'),
    parentFillOrderId: string().optional().from('parent_fill_order_id'),
    patientId: string().optional().from('patient_id'),
    pharmacistId: string().optional().from('pharmacist_id'),
    pharmacyCompanyId: string().optional().from('pharmacy_company_id'),
    prescriptionId: string().from('prescription_id'),
    providerCompanyId: string().optional().from('provider_company_id'),
    sequenceId: number().from('sequence_id'),
    state: string(),
    technicianId: string().optional().from('technician_id'),
    updatedAt: number().from('updated_at'),
    verifiedAt: number().optional().from('verified_at'),
    verifiedById: string().optional().from('verified_by_id'),
    zipcode: string(),
  })
  .primaryKey('id');

const fillOrderApiRequestTable = table('fillOrderApiRequest')
  .from('orders_fillorderapirequest')
  .columns({
    context: string().optional(),
    createdAt: number().from('created_at'),
    fillOrderId: string().optional().from('fill_order_id'),
    id: string(),
    processedAt: number().optional().from('processed_at'),
    receivedAt: number().from('received_at'),
    updatedAt: number().from('updated_at'),
    userAgent: string().from('user_agent'),
    userId: string().optional().from('user_id'),
    webhookData: json().from('webhook_data'),
    webhookType: enumeration<'new_order' | 'unknown'>().from('webhook_type'),
  })
  .primaryKey('id');

const fillOrderIngredientTable = table('fillOrderIngredient')
  .from('orders_fillorderingredient')
  .columns({
    createdAt: number().from('created_at'),
    deletedAt: number().optional().from('deleted_at'),
    dilutionDisplay: string().from('dilution_display'),
    dilutionNumber: number().optional().from('dilution_number'),
    dilutionValue: string().from('dilution_value'),
    id: string(),
    ingredientOrder: number().optional().from('ingredient_order'),
    inventoryId: string().optional().from('inventory_id'),
    isActive: boolean().from('is_active'),
    lotId: string().from('lot_id'),
    orderId: string().from('order_id'),
    originalDilutionNumber: number().optional().from('original_dilution_number'),
    originalDilutionValue: string().from('original_dilution_value'),
    originalIngredientDisplay: string().from('original_ingredient_display'),
    originalIngredientOrder: number().optional().from('original_ingredient_order'),
    originalIngredientQty: string().from('original_ingredient_qty'),
    qty: number(),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const fillOrderIngredientEventTable = table('fillOrderIngredientEvent')
  .from('orders_fillorderingredientevent')
  .columns({
    additionalDetails: json().from('additional_details'),
    createdAt: number().from('created_at'),
    dataNew: json<IngredientEventSnapshot>().from('data_new'),
    dataOld: json<IngredientEventSnapshot>().from('data_old'),
    deletedAt: number().optional().from('deleted_at'),
    fillOrderIngredientId: string().from('fill_order_ingredient_id'),
    id: string(),
    inventoryId: string().optional().from('inventory_id'),
    reason: string(),
    updatedAt: number().from('updated_at'),
    userId: string().optional().from('user_id'),
  })
  .primaryKey('id');

const fillOrderStatusEventTable = table('fillOrderStatusEvent')
  .from('orders_fillorderstatusevent')
  .columns({
    additionalDetails: json().from('additional_details'),
    createdAt: number().from('created_at'),
    fillOrderId: string().from('fill_order_id'),
    id: string(),
    reason: string(),
    statusNew: enumeration<
      | 'consultation_required'
      | 'hold_file'
      | 'in_progress'
      | 'labels_printed'
      | 'not_filled'
      | 'rejected'
      | 'shipped'
      | 'shipping_error'
      | 'shipping_pickup'
      | 'unverified'
      | 'verified'
      | 'waiting'
    >().from('status_new'),
    statusOld: enumeration<
      | 'consultation_required'
      | 'hold_file'
      | 'in_progress'
      | 'labels_printed'
      | 'not_filled'
      | 'rejected'
      | 'shipped'
      | 'shipping_error'
      | 'shipping_pickup'
      | 'unverified'
      | 'verified'
      | 'waiting'
    >()
      .optional()
      .from('status_old'),
    updatedAt: number().from('updated_at'),
    userId: string().optional().from('user_id'),
  })
  .primaryKey('id');

const ingredientTable = table('ingredient')
  .from('ingredients_ingredient')
  .columns({
    createdAt: number().from('created_at'),
    data: json(),
    deletedAt: number().optional().from('deleted_at'),
    form: enumeration<'capsule' | 'solution' | 'suspension' | 'tablet'>(),
    genericName: string().from('generic_name'),
    id: string(),
    ingredientType: enumeration<'activated' | 'active' | 'filler'>().from('ingredient_type'),
    measurementUnit: enumeration<'g' | 'l' | 'ml'>().from('measurement_unit'),
    memo: string().optional(),
    name: string(),
    ndcId: string().optional().from('ndc_id'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const ingredientMapTable = table('ingredientMap')
  .from('ingredients_ingredientmap')
  .columns({
    createdAt: number().from('created_at'),
    id: string(),
    ingredientId: string().from('ingredient_id'),
    isActive: boolean().from('is_active'),
    isDoNotMap: boolean().from('is_do_not_map'),
    originalName: string().from('original_name'),
    pharmacyCompanyId: string().optional().from('pharmacy_company_id'),
    providerCompanyId: string().optional().from('provider_company_id'),
    treatmentKind: string().optional().from('treatment_kind'),
    updatedAt: number().from('updated_at'),
    userId: string().from('user_id'),
  })
  .primaryKey('id');

const inventoryTable = table('inventory')
  .from('ingredients_inventory')
  .columns({
    assayR1: number().from('assay_r1'),
    assayR2: number().from('assay_r2'),
    assayUnit: enumeration<'au_ml' | 'bau_ml' | 'dilution' | 'mg_ml' | 'percent' | 'pnu' | 'unknown'>().from(
      'assay_unit',
    ),
    createdAt: number().from('created_at'),
    data: json(),
    deletedAt: number().optional().from('deleted_at'),
    dilutionData: json().from('dilution_data'),
    dilutionDataText: string().from('dilution_data_text'),
    expirationDate: number().optional().from('expiration_date'),
    id: string(),
    ingredientId: string().from('ingredient_id'),
    isActive: boolean().from('is_active'),
    lotId: string().from('lot_id'),
    memo: string().optional(),
    ndcCode: string().optional().from('ndc_code'),
    pharmacyCompanyId: string().optional().from('pharmacy_company_id'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const ndcPharmaceuticalTable = table('ndcPharmaceutical')
  .from('ingredients_ndcpharmaceutical')
  .columns({
    activeIngredientUnit: string().from('active_ingredient_unit'),
    activeNumeratorStrength: number().optional().from('active_numerator_strength'),
    applicationNumber: string().from('application_number'),
    createdAt: number().from('created_at'),
    dosageFormName: enumeration<'solution'>().optional().from('dosage_form_name'),
    endMarketingDate: number().optional().from('end_marketing_date'),
    id: string(),
    listingRecordCertifiedThrough: number().optional().from('listing_record_certified_through'),
    manufacturerId: string().optional().from('manufacturer_id'),
    ndc: string(),
    ndcExcludeFlag: boolean().from('ndc_exclude_flag'),
    nonproprietaryName: string().from('nonproprietary_name'),
    pharmClasses: string().from('pharm_classes'),
    productId: string().from('product_id'),
    productTypeName: enumeration<'non_standardized_allergenic' | 'standardized_allergenic'>()
      .optional()
      .from('product_type_name'),
    proprietaryName: string().from('proprietary_name'),
    proprietaryNameSuffix: string().from('proprietary_name_suffix'),
    routeName: string().from('route_name'),
    startMarketingDate: number().optional().from('start_marketing_date'),
    substanceName: string().from('substance_name'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const orderDocumentTable = table('orderDocument')
  .from('orders_orderdocument')
  .columns({
    createdAt: number().from('created_at'),
    document: string(),
    documentType: enumeration<'auto_rx' | 'new_rx' | 'not_rx' | 'otc' | 'other' | 'refill_rx' | 'rx_on_file'>().from(
      'document_type',
    ),
    fillOrderId: string().from('fill_order_id'),
    id: string(),
    isActive: boolean().from('is_active'),
    noteId: string().optional().from('note_id'),
    s3Url: string().from('s3_url'),
    subject: string(),
    updatedAt: number().from('updated_at'),
    userId: string().from('user_id'),
  })
  .primaryKey('id');

const orderNoteTable = table('orderNote')
  .from('orders_ordernote')
  .columns({
    additionalDetails: json().from('additional_details'),
    createdAt: number().from('created_at'),
    data: json(),
    fillOrderId: string().from('fill_order_id'),
    id: string(),
    isActive: boolean().from('is_active'),
    noteType: enumeration<'consultation_note' | 'manual_note' | 'pickup_note' | 'problem' | 'status_update'>().from(
      'note_type',
    ),
    subject: string(),
    text: string().optional(),
    updatedAt: number().from('updated_at'),
    userId: string().from('user_id'),
  })
  .primaryKey('id');

const patientTable = table('patient')
  .from('prescriptions_patient')
  .columns({
    allergies: string(),
    createdAt: number().from('created_at'),
    dateOfBirth: number().optional().from('date_of_birth'),
    diseaseHistory: json().from('disease_history'),
    displayDateOfBirth: string().from('display_date_of_birth'),
    email: string(),
    firstName: string().from('first_name'),
    gender: enumeration<'decline_to_state' | 'female' | 'male' | 'other' | 'unknown'>(),
    height: number().optional(),
    id: string(),
    isAnaphylactic: boolean().from('is_anaphylactic'),
    isPregnant: boolean().from('is_pregnant'),
    lastName: string().from('last_name'),
    medicalHistory: json().from('medical_history'),
    medications: string(),
    middleName: string().from('middle_name'),
    pharmacyCompanyId: string().from('pharmacy_company_id'),
    phone: string(),
    preferredName: string().from('preferred_name'),
    providerCompanyId: string().from('provider_company_id'),
    providerExternalId: string().optional().from('provider_external_id'),
    readableId: string().optional().from('readable_id'),
    sequenceId: number().from('sequence_id'),
    species: enumeration<'human' | 'unknown'>(),
    updatedAt: number().from('updated_at'),
    weight: number().optional(),
  })
  .primaryKey('id');

const patientDocumentTable = table('patientDocument')
  .from('prescriptions_patientdocument')
  .columns({
    createdAt: number().from('created_at'),
    document: string(),
    documentType: enumeration<
      'agreement' | 'hipaa_signature' | 'medical_record' | 'other' | 'power_of_attorney' | 'release_of_information'
    >().from('document_type'),
    id: string(),
    isActive: boolean().from('is_active'),
    noteId: string().optional().from('note_id'),
    patientId: string().from('patient_id'),
    s3Url: string().from('s3_url'),
    subject: string().optional(),
    updatedAt: number().from('updated_at'),
    userId: string().from('user_id'),
  })
  .primaryKey('id');

const patientGuardianTable = table('patientGuardian')
  .from('prescriptions_patientguardian')
  .columns({
    createdAt: number().from('created_at'),
    email: string(),
    firstName: string().from('first_name'),
    id: string(),
    lastName: string().from('last_name'),
    middleName: string().from('middle_name'),
    patientId: string().from('patient_id'),
    phone: string(),
    preferredName: string().from('preferred_name'),
    providerCompanyId: string().from('provider_company_id'),
    providerExternalId: string().from('provider_external_id'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const patientNoteTable = table('patientNote')
  .from('prescriptions_patientnote')
  .columns({
    additionalDetails: json().from('additional_details'),
    createdAt: number().from('created_at'),
    data: json(),
    id: string(),
    isActive: boolean().from('is_active'),
    noteType: enumeration<'communication' | 'general' | 'memo' | 'other'>().from('note_type'),
    patientId: string().from('patient_id'),
    subject: string().optional(),
    text: string().optional(),
    updatedAt: number().from('updated_at'),
    userId: string().from('user_id'),
  })
  .primaryKey('id');

const physicianTable = table('physician')
  .from('prescriptions_physician')
  .columns({
    createdAt: number().from('created_at'),
    email: string(),
    firstName: string().from('first_name'),
    id: string(),
    isPrescribingPrivilege: boolean().from('is_prescribing_privilege'),
    lastName: string().from('last_name'),
    middleName: string().from('middle_name'),
    npi: string(),
    phone: string(),
    phoneEvening: string().from('phone_evening'),
    providerCompanyId: string().from('provider_company_id'),
    providerExternalId: string().from('provider_external_id'),
    title: enumeration<'DO' | 'FNP' | 'FNPBC' | 'FNPC' | 'MD' | 'NP' | 'NPC' | 'PAC' | 'UNK'>(),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const physicianStateTable = table('physicianState')
  .from('prescriptions_physicianstate')
  .columns({
    id: number(),
    modality: enumeration<'async_state' | 'sync_audio_state' | 'sync_video_state'>(),
    physicianId: string().from('physician_id'),
    state: string(),
  })
  .primaryKey('id');

const prescriptionTable = table('prescription')
  .from('prescriptions_prescription')
  .columns({
    additionalDetails: json().from('additional_details'),
    allergyType: string().from('allergy_type'),
    authRefills: number().from('auth_refills'),
    createdAt: number().from('created_at'),
    data: json(),
    dateExpiration: number().optional().from('date_expiration'),
    daysSupply: number().from('days_supply'),
    dilutionData: json().from('dilution_data'),
    id: string(),
    ingredientData: json().from('ingredient_data'),
    isActive: boolean().from('is_active'),
    kind: enumeration<'formula_modification' | 'initial' | 'renewal' | 'unknown'>(),
    labelsUrl: string().from('labels_url'),
    medicationName: string().from('medication_name'),
    patientId: string().optional().from('patient_id'),
    patientInstructions: string().from('patient_instructions'),
    pharmacyCompanyId: string().optional().from('pharmacy_company_id'),
    physicianId: string().optional().from('physician_id'),
    prescriptionPdfUrl: string().from('prescription_pdf_url'),
    prescriptionSchedule: enumeration<'L'>().from('prescription_schedule'),
    productType: enumeration<'compound'>().from('product_type'),
    providerCompanyId: string().optional().from('provider_company_id'),
    providerExternalId: string().optional().from('provider_external_id'),
    qty: number(),
    qtyUnit: enumeration<'g' | 'l' | 'ml'>().from('qty_unit'),
    rejectionReason: string().from('rejection_reason'),
    rxId: string().from('rx_id'),
    sequenceId: number().from('sequence_id'),
    signedAt: number().optional().from('signed_at'),
    source: enumeration<'api_graphql' | 'api_rest' | 'fax'>(),
    status: enumeration<'ready' | 'rejected' | 'review_required'>(),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const prescriptionApiRequestTable = table('prescriptionApiRequest')
  .from('prescriptions_prescriptionapirequest')
  .columns({
    context: string().optional(),
    createdAt: number().from('created_at'),
    id: string(),
    prescriptionId: string().optional().from('prescription_id'),
    processedAt: number().optional().from('processed_at'),
    receivedAt: number().from('received_at'),
    updatedAt: number().from('updated_at'),
    userAgent: string().optional().from('user_agent'),
    userId: string().optional().from('user_id'),
    webhookData: json().from('webhook_data'),
    webhookType: enumeration<'new_order' | 'pms_prescription_create' | 'pms_prescription_update' | 'unknown'>().from(
      'webhook_type',
    ),
  })
  .primaryKey('id');

const prescriptionDocumentTable = table('prescriptionDocument')
  .from('prescriptions_prescriptiondocument')
  .columns({
    createdAt: number().from('created_at'),
    document: string(),
    id: string(),
    isActive: boolean().from('is_active'),
    noteId: string().optional().from('note_id'),
    prescriptionId: string().from('prescription_id'),
    s3Url: string().from('s3_url'),
    subject: string().optional(),
    updatedAt: number().from('updated_at'),
    userId: string().from('user_id'),
  })
  .primaryKey('id');

const prescriptionNoteTable = table('prescriptionNote')
  .from('prescriptions_prescriptionnote')
  .columns({
    additionalDetails: json().from('additional_details'),
    createdAt: number().from('created_at'),
    data: json(),
    id: string(),
    isActive: boolean().from('is_active'),
    prescriptionId: string().from('prescription_id'),
    subject: string().optional(),
    text: string().optional(),
    updatedAt: number().from('updated_at'),
    userId: string().from('user_id'),
  })
  .primaryKey('id');

const shipmentTable = table('shipment')
  .from('orders_shipment')
  .columns({
    carrier: enumeration<'easypost' | 'fedex' | 'unknown' | 'ups' | 'usps'>(),
    carrierStatus: string().from('carrier_status'),
    createdAt: number().from('created_at'),
    deletedAt: number().optional().from('deleted_at'),
    description: string(),
    dimensionData: json().from('dimension_data'),
    id: string(),
    orderId: string().from('order_id'),
    pharmacyId: string().from('pharmacy_id'),
    prescriptionId: string().optional().from('prescription_id'),
    shippedAt: number().from('shipped_at'),
    shippingStatus: enumeration<
      'delivered' | 'in_transit' | 'on_hold' | 'pending' | 'problem' | 'submit_carrier' | 'voided'
    >().from('shipping_status'),
    statusUpdatedAt: number().from('status_updated_at'),
    trackingNumber: string().from('tracking_number'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const shipmentLabelTable = table('shipmentLabel')
  .from('orders_shipmentlabel')
  .columns({
    apiRequestData: json().from('api_request_data'),
    apiResponseData: json().from('api_response_data'),
    createdAt: number().from('created_at'),
    deletedAt: number().optional().from('deleted_at'),
    errorMessage: string().from('error_message'),
    id: string(),
    isSuccessful: boolean().from('is_successful'),
    isVoided: boolean().from('is_voided'),
    labelId: string().from('label_id'),
    labelPdfS3Url: string().from('label_pdf_s3_url'),
    labelPdfUrl: string().from('label_pdf_url'),
    labelPngS3Url: string().from('label_png_s3_url'),
    labelPngUrl: string().from('label_png_url'),
    labelType: enumeration<'return_label' | 'shipping_label'>().from('label_type'),
    labelZplS3Url: string().from('label_zpl_s3_url'),
    labelZplUrl: string().from('label_zpl_url'),
    packageWeightOz: number().optional().from('package_weight_oz'),
    postageCost: number().optional().from('postage_cost'),
    provider: enumeration<'shipping_station' | 'stamps_com'>(),
    serviceType: string().from('service_type'),
    serviceTypeDisplay: string().from('service_type_display'),
    shipmentId: string().from('shipment_id'),
    trackingNumber: string().from('tracking_number'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const shipmentProblemTable = table('shipmentProblem')
  .from('shipping_shipmentproblem')
  .columns({
    createdAt: number().from('created_at'),
    errorMessage: string().from('error_message'),
    id: string(),
    responseData: json().from('response_data'),
    shipmentId: string().from('shipment_id'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const shipmentTrackingEventTable = table('shipmentTrackingEvent')
  .from('webhooks_shipmenttrackingevent')
  .columns({
    carrierOccurredAt: number().optional().from('carrier_occurred_at'),
    carrierStatusCode: string().from('carrier_status_code'),
    carrierStatusDescription: string().from('carrier_status_description'),
    cityLocality: string().from('city_locality'),
    companyName: string().from('company_name'),
    countryCode: string().from('country_code'),
    createdAt: number().from('created_at'),
    description: string(),
    eventCode: string().from('event_code'),
    id: string(),
    occurredAt: number().optional().from('occurred_at'),
    postalCode: string().from('postal_code'),
    rawData: json().from('raw_data'),
    shipmentId: string().from('shipment_id'),
    signer: string(),
    stateProvince: string().from('state_province'),
    statusCode: string().from('status_code'),
    trackingNumber: string().from('tracking_number'),
    updatedAt: number().from('updated_at'),
    webhookRequestId: string().optional().from('webhook_request_id'),
  })
  .primaryKey('id');

const shippingApiRequestTable = table('shippingApiRequest')
  .from('shipping_shippingapirequest')
  .columns({
    context: string().optional(),
    createdAt: number().from('created_at'),
    id: string(),
    processedAt: number().optional().from('processed_at'),
    receivedAt: number().from('received_at'),
    resourceData: json().from('resource_data'),
    resourceType: string().from('resource_type'),
    resourceUrl: string().optional().from('resource_url'),
    shipmentLabelId: string().optional().from('shipment_label_id'),
    updatedAt: number().from('updated_at'),
    userAgent: string().optional().from('user_agent'),
    userId: string().optional().from('user_id'),
    webhookData: json().from('webhook_data'),
  })
  .primaryKey('id');

const shippingCarrierTable = table('shippingCarrier')
  .from('orders_shippingcarrier')
  .columns({
    carrierCode: string().from('carrier_code'),
    carrierId: string().from('carrier_id'),
    companyId: string().from('company_id'),
    createdAt: number().from('created_at'),
    id: string(),
    isEnabled: boolean().from('is_enabled'),
    lastSyncedAt: number().from('last_synced_at'),
    name: string(),
    rawData: json().from('raw_data'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const shippingServiceTable = table('shippingService')
  .from('orders_shippingservice')
  .columns({
    carrierId: string().from('carrier_id'),
    createdAt: number().from('created_at'),
    domestic: boolean(),
    id: string(),
    international: boolean(),
    isHidden: boolean().from('is_hidden'),
    isMultiPackageSupported: boolean().from('is_multi_package_supported'),
    isReturnSupported: boolean().from('is_return_supported'),
    name: string(),
    rawData: json().from('raw_data'),
    serviceCode: string().from('service_code'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const systemEventTable = table('systemEvent')
  .from('system_systemevent')
  .columns({
    additionalDetails: json().from('additional_details'),
    createdAt: number().from('created_at'),
    id: string(),
    initiatedById: string().optional().from('initiated_by_id'),
    isHidden: boolean().from('is_hidden'),
    patientId: string().optional().from('patient_id'),
    source: enumeration<'admin_command' | 'admin' | 'allergy_choices' | 'ehr' | 'graphql' | 'unknown'>(),
    subjectCtId: number().optional().from('subject_ct_id'),
    subjectId: string().optional().from('subject_id'),
    type: enumeration<
      | 'order_status_changed'
      | 'patient_medical_document'
      | 'patient_tag_added'
      | 'patient_tag_removed'
      | 'user_email_changed'
      | 'user_logged_in'
      | 'user_name_changed'
      | 'user_password_reset_request'
      | 'user_password_reset'
      | 'user_passwordless_login_request'
      | 'user_phone_changed'
      | 'user_registered'
    >(),
    userId: string().optional().from('user_id'),
  })
  .primaryKey('id');

const transactionTable = table('transaction')
  .from('billing_transaction')
  .columns({
    completedDate: number().optional().from('completed_date'),
    createdAt: number().from('created_at'),
    createdById: string().from('created_by_id'),
    effectiveDate: number().optional().from('effective_date'),
    id: string(),
    isSuccessful: boolean().from('is_successful'),
    memo: string().optional(),
    orderId: string().from('order_id'),
    pharmacyCompanyId: string().from('pharmacy_company_id'),
    providerCompanyId: string().from('provider_company_id'),
    sequenceId: number().from('sequence_id'),
    transactionDate: number().optional().from('transaction_date'),
    transactionMemo: string().from('transaction_memo'),
    transactionReferenceId: string().optional().from('transaction_reference_id'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const userTable = table('user')
  .from('accounts_user')
  .columns({
    additionalDetails: json().from('additional_details'),
    companyId: string().optional().from('company_id'),
    createdAt: number().from('created_at'),
    dateJoined: number().from('date_joined'),
    deletedAt: number().optional().from('deleted_at'),
    email: string(),
    firstName: string().from('first_name'),
    id: string(),
    isActive: boolean().from('is_active'),
    isStaff: boolean().from('is_staff'),
    isSuperuser: boolean().from('is_superuser'),
    lastLogin: number().optional().from('last_login'),
    lastName: string().from('last_name'),
    lastSeen: number().optional().from('last_seen'),
    middleName: string().from('middle_name'),
    phone: string(),
    role: enumeration<'admin' | 'partner' | 'pharmacist' | 'robot' | 'technician'>(),
    state: string(),
    tokenValidMinTime: number().from('token_valid_min_time'),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const webhookRequestTable = table('webhookRequest')
  .from('webhooks_webhookrequest')
  .columns({
    body: json(),
    createdAt: number().from('created_at'),
    headers: json(),
    id: string(),
    source: enumeration<'shipstation'>(),
    updatedAt: number().from('updated_at'),
  })
  .primaryKey('id');

const billingInvoiceRelationships = relationships(billingInvoiceTable, ({ one }) => ({
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
}));

const companyRelationships = relationships(companyTable, ({ many }) => ({
  billingInvoicesAsPharmacyCompany: many({
    sourceField: ['id'],
    destSchema: billingInvoiceTable,
    destField: ['pharmacyCompanyId'],
  }),
  billingInvoicesAsProviderCompany: many({
    sourceField: ['id'],
    destSchema: billingInvoiceTable,
    destField: ['providerCompanyId'],
  }),
  faxDocumentsAsPharmacyCompany: many({
    sourceField: ['id'],
    destSchema: faxDocumentTable,
    destField: ['pharmacyCompanyId'],
  }),
  faxDocumentsAsProviderCompany: many({
    sourceField: ['id'],
    destSchema: faxDocumentTable,
    destField: ['providerCompanyId'],
  }),
  faxTemplateConfigsAsPharmacyCompany: many({
    sourceField: ['id'],
    destSchema: faxTemplateConfigTable,
    destField: ['pharmacyCompanyId'],
  }),
  faxTemplateConfigsAsProviderCompany: many({
    sourceField: ['id'],
    destSchema: faxTemplateConfigTable,
    destField: ['providerCompanyId'],
  }),
  fillOrdersAsPharmacyCompany: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['pharmacyCompanyId'],
  }),
  fillOrdersAsProviderCompany: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['providerCompanyId'],
  }),
  ingredientMapsAsPharmacyCompany: many({
    sourceField: ['id'],
    destSchema: ingredientMapTable,
    destField: ['pharmacyCompanyId'],
  }),
  ingredientMapsAsProviderCompany: many({
    sourceField: ['id'],
    destSchema: ingredientMapTable,
    destField: ['providerCompanyId'],
  }),
  inventories: many({
    sourceField: ['id'],
    destSchema: inventoryTable,
    destField: ['pharmacyCompanyId'],
  }),
  ndcPharmaceuticals: many({
    sourceField: ['id'],
    destSchema: ndcPharmaceuticalTable,
    destField: ['manufacturerId'],
  }),
  patientGuardians: many({
    sourceField: ['id'],
    destSchema: patientGuardianTable,
    destField: ['providerCompanyId'],
  }),
  patientsAsPharmacyCompany: many({
    sourceField: ['id'],
    destSchema: patientTable,
    destField: ['pharmacyCompanyId'],
  }),
  patientsAsProviderCompany: many({
    sourceField: ['id'],
    destSchema: patientTable,
    destField: ['providerCompanyId'],
  }),
  physicians: many({
    sourceField: ['id'],
    destSchema: physicianTable,
    destField: ['providerCompanyId'],
  }),
  prescriptionsAsPharmacyCompany: many({
    sourceField: ['id'],
    destSchema: prescriptionTable,
    destField: ['pharmacyCompanyId'],
  }),
  prescriptionsAsProviderCompany: many({
    sourceField: ['id'],
    destSchema: prescriptionTable,
    destField: ['providerCompanyId'],
  }),
  shipments: many({
    sourceField: ['id'],
    destSchema: shipmentTable,
    destField: ['pharmacyId'],
  }),
  shippingCarriers: many({
    sourceField: ['id'],
    destSchema: shippingCarrierTable,
    destField: ['companyId'],
  }),
  transactionsAsPharmacyCompany: many({
    sourceField: ['id'],
    destSchema: transactionTable,
    destField: ['pharmacyCompanyId'],
  }),
  transactionsAsProviderCompany: many({
    sourceField: ['id'],
    destSchema: transactionTable,
    destField: ['providerCompanyId'],
  }),
  users: many({
    sourceField: ['id'],
    destSchema: userTable,
    destField: ['companyId'],
  }),
}));

const faxAuditEventRelationships = relationships(faxAuditEventTable, ({ one }) => ({
  faxDocument: one({
    sourceField: ['faxDocumentId'],
    destSchema: faxDocumentTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const faxDocumentRelationships = relationships(faxDocumentTable, ({ one, many }) => ({
  order: one({
    sourceField: ['orderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  prescription: one({
    sourceField: ['prescriptionId'],
    destSchema: prescriptionTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  reviewedBy: one({
    sourceField: ['reviewedById'],
    destSchema: userTable,
    destField: ['id'],
  }),
  templateConfig: one({
    sourceField: ['templateConfigId'],
    destSchema: faxTemplateConfigTable,
    destField: ['id'],
  }),
  faxAuditEvents: many({
    sourceField: ['id'],
    destSchema: faxAuditEventTable,
    destField: ['faxDocumentId'],
  }),
  faxDocumentPages: many({
    sourceField: ['id'],
    destSchema: faxDocumentPageTable,
    destField: ['faxDocumentId'],
  }),
  faxWebhookRequests: many({
    sourceField: ['id'],
    destSchema: faxWebhookRequestTable,
    destField: ['faxDocumentId'],
  }),
}));

const faxDocumentPageRelationships = relationships(faxDocumentPageTable, ({ one }) => ({
  faxDocument: one({
    sourceField: ['faxDocumentId'],
    destSchema: faxDocumentTable,
    destField: ['id'],
  }),
  order: one({
    sourceField: ['orderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
}));

const faxTemplateConfigRelationships = relationships(faxTemplateConfigTable, ({ one, many }) => ({
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  faxDocuments: many({
    sourceField: ['id'],
    destSchema: faxDocumentTable,
    destField: ['templateConfigId'],
  }),
}));

const faxWebhookRequestRelationships = relationships(faxWebhookRequestTable, ({ one }) => ({
  faxDocument: one({
    sourceField: ['faxDocumentId'],
    destSchema: faxDocumentTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const fillOrderRelationships = relationships(fillOrderTable, ({ one, many }) => ({
  lockedBy: one({
    sourceField: ['lockedById'],
    destSchema: userTable,
    destField: ['id'],
  }),
  parentFillOrder: one({
    sourceField: ['parentFillOrderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  patient: one({
    sourceField: ['patientId'],
    destSchema: patientTable,
    destField: ['id'],
  }),
  pharmacist: one({
    sourceField: ['pharmacistId'],
    destSchema: userTable,
    destField: ['id'],
  }),
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  prescription: one({
    sourceField: ['prescriptionId'],
    destSchema: prescriptionTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  technician: one({
    sourceField: ['technicianId'],
    destSchema: userTable,
    destField: ['id'],
  }),
  verifiedBy: one({
    sourceField: ['verifiedById'],
    destSchema: userTable,
    destField: ['id'],
  }),
  faxDocumentPages: many({
    sourceField: ['id'],
    destSchema: faxDocumentPageTable,
    destField: ['orderId'],
  }),
  faxDocuments: many({
    sourceField: ['id'],
    destSchema: faxDocumentTable,
    destField: ['orderId'],
  }),
  fillOrderApiRequests: many({
    sourceField: ['id'],
    destSchema: fillOrderApiRequestTable,
    destField: ['fillOrderId'],
  }),
  fillOrderIngredients: many({
    sourceField: ['id'],
    destSchema: fillOrderIngredientTable,
    destField: ['orderId'],
  }),
  fillOrders: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['parentFillOrderId'],
  }),
  fillOrderStatusEvents: many({
    sourceField: ['id'],
    destSchema: fillOrderStatusEventTable,
    destField: ['fillOrderId'],
  }),
  orderDocuments: many({
    sourceField: ['id'],
    destSchema: orderDocumentTable,
    destField: ['fillOrderId'],
  }),
  orderNotes: many({
    sourceField: ['id'],
    destSchema: orderNoteTable,
    destField: ['fillOrderId'],
  }),
  shipments: many({
    sourceField: ['id'],
    destSchema: shipmentTable,
    destField: ['orderId'],
  }),
  transactions: many({
    sourceField: ['id'],
    destSchema: transactionTable,
    destField: ['orderId'],
  }),
}));

const fillOrderApiRequestRelationships = relationships(fillOrderApiRequestTable, ({ one }) => ({
  fillOrder: one({
    sourceField: ['fillOrderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const fillOrderIngredientRelationships = relationships(fillOrderIngredientTable, ({ one, many }) => ({
  inventory: one({
    sourceField: ['inventoryId'],
    destSchema: inventoryTable,
    destField: ['id'],
  }),
  order: one({
    sourceField: ['orderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  fillOrderIngredientEvents: many({
    sourceField: ['id'],
    destSchema: fillOrderIngredientEventTable,
    destField: ['fillOrderIngredientId'],
  }),
}));

const fillOrderIngredientEventRelationships = relationships(fillOrderIngredientEventTable, ({ one }) => ({
  fillOrderIngredient: one({
    sourceField: ['fillOrderIngredientId'],
    destSchema: fillOrderIngredientTable,
    destField: ['id'],
  }),
  inventory: one({
    sourceField: ['inventoryId'],
    destSchema: inventoryTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const fillOrderStatusEventRelationships = relationships(fillOrderStatusEventTable, ({ one }) => ({
  fillOrder: one({
    sourceField: ['fillOrderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const ingredientRelationships = relationships(ingredientTable, ({ one, many }) => ({
  ndc: one({
    sourceField: ['ndcId'],
    destSchema: ndcPharmaceuticalTable,
    destField: ['id'],
  }),
  ingredientMaps: many({
    sourceField: ['id'],
    destSchema: ingredientMapTable,
    destField: ['ingredientId'],
  }),
  inventories: many({
    sourceField: ['id'],
    destSchema: inventoryTable,
    destField: ['ingredientId'],
  }),
}));

const ingredientMapRelationships = relationships(ingredientMapTable, ({ one }) => ({
  ingredient: one({
    sourceField: ['ingredientId'],
    destSchema: ingredientTable,
    destField: ['id'],
  }),
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const inventoryRelationships = relationships(inventoryTable, ({ one, many }) => ({
  ingredient: one({
    sourceField: ['ingredientId'],
    destSchema: ingredientTable,
    destField: ['id'],
  }),
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  fillOrderIngredientEvents: many({
    sourceField: ['id'],
    destSchema: fillOrderIngredientEventTable,
    destField: ['inventoryId'],
  }),
  fillOrderIngredients: many({
    sourceField: ['id'],
    destSchema: fillOrderIngredientTable,
    destField: ['inventoryId'],
  }),
}));

const ndcPharmaceuticalRelationships = relationships(ndcPharmaceuticalTable, ({ one, many }) => ({
  manufacturer: one({
    sourceField: ['manufacturerId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  ingredients: many({
    sourceField: ['id'],
    destSchema: ingredientTable,
    destField: ['ndcId'],
  }),
}));

const orderDocumentRelationships = relationships(orderDocumentTable, ({ one }) => ({
  fillOrder: one({
    sourceField: ['fillOrderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  note: one({
    sourceField: ['noteId'],
    destSchema: orderNoteTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const orderNoteRelationships = relationships(orderNoteTable, ({ one, many }) => ({
  fillOrder: one({
    sourceField: ['fillOrderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
  orderDocuments: many({
    sourceField: ['id'],
    destSchema: orderDocumentTable,
    destField: ['noteId'],
  }),
}));

const patientRelationships = relationships(patientTable, ({ one, many }) => ({
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  fillOrders: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['patientId'],
  }),
  patientDocuments: many({
    sourceField: ['id'],
    destSchema: patientDocumentTable,
    destField: ['patientId'],
  }),
  patientGuardians: many({
    sourceField: ['id'],
    destSchema: patientGuardianTable,
    destField: ['patientId'],
  }),
  patientNotes: many({
    sourceField: ['id'],
    destSchema: patientNoteTable,
    destField: ['patientId'],
  }),
  prescriptions: many({
    sourceField: ['id'],
    destSchema: prescriptionTable,
    destField: ['patientId'],
  }),
  systemEvents: many({
    sourceField: ['id'],
    destSchema: systemEventTable,
    destField: ['patientId'],
  }),
}));

const patientDocumentRelationships = relationships(patientDocumentTable, ({ one }) => ({
  note: one({
    sourceField: ['noteId'],
    destSchema: patientNoteTable,
    destField: ['id'],
  }),
  patient: one({
    sourceField: ['patientId'],
    destSchema: patientTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const patientGuardianRelationships = relationships(patientGuardianTable, ({ one }) => ({
  patient: one({
    sourceField: ['patientId'],
    destSchema: patientTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
}));

const patientNoteRelationships = relationships(patientNoteTable, ({ one, many }) => ({
  patient: one({
    sourceField: ['patientId'],
    destSchema: patientTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
  patientDocuments: many({
    sourceField: ['id'],
    destSchema: patientDocumentTable,
    destField: ['noteId'],
  }),
}));

const physicianRelationships = relationships(physicianTable, ({ one, many }) => ({
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  physicianStates: many({
    sourceField: ['id'],
    destSchema: physicianStateTable,
    destField: ['physicianId'],
  }),
  prescriptions: many({
    sourceField: ['id'],
    destSchema: prescriptionTable,
    destField: ['physicianId'],
  }),
}));

const physicianStateRelationships = relationships(physicianStateTable, ({ one }) => ({
  physician: one({
    sourceField: ['physicianId'],
    destSchema: physicianTable,
    destField: ['id'],
  }),
}));

const prescriptionRelationships = relationships(prescriptionTable, ({ one, many }) => ({
  patient: one({
    sourceField: ['patientId'],
    destSchema: patientTable,
    destField: ['id'],
  }),
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  physician: one({
    sourceField: ['physicianId'],
    destSchema: physicianTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  faxDocuments: many({
    sourceField: ['id'],
    destSchema: faxDocumentTable,
    destField: ['prescriptionId'],
  }),
  fillOrders: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['prescriptionId'],
  }),
  prescriptionApiRequests: many({
    sourceField: ['id'],
    destSchema: prescriptionApiRequestTable,
    destField: ['prescriptionId'],
  }),
  prescriptionDocuments: many({
    sourceField: ['id'],
    destSchema: prescriptionDocumentTable,
    destField: ['prescriptionId'],
  }),
  prescriptionNotes: many({
    sourceField: ['id'],
    destSchema: prescriptionNoteTable,
    destField: ['prescriptionId'],
  }),
  shipments: many({
    sourceField: ['id'],
    destSchema: shipmentTable,
    destField: ['prescriptionId'],
  }),
}));

const prescriptionApiRequestRelationships = relationships(prescriptionApiRequestTable, ({ one }) => ({
  prescription: one({
    sourceField: ['prescriptionId'],
    destSchema: prescriptionTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const prescriptionDocumentRelationships = relationships(prescriptionDocumentTable, ({ one }) => ({
  note: one({
    sourceField: ['noteId'],
    destSchema: prescriptionNoteTable,
    destField: ['id'],
  }),
  prescription: one({
    sourceField: ['prescriptionId'],
    destSchema: prescriptionTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const prescriptionNoteRelationships = relationships(prescriptionNoteTable, ({ one, many }) => ({
  prescription: one({
    sourceField: ['prescriptionId'],
    destSchema: prescriptionTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
  prescriptionDocuments: many({
    sourceField: ['id'],
    destSchema: prescriptionDocumentTable,
    destField: ['noteId'],
  }),
}));

const shipmentRelationships = relationships(shipmentTable, ({ one, many }) => ({
  order: one({
    sourceField: ['orderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  pharmacy: one({
    sourceField: ['pharmacyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  prescription: one({
    sourceField: ['prescriptionId'],
    destSchema: prescriptionTable,
    destField: ['id'],
  }),
  shipmentLabels: many({
    sourceField: ['id'],
    destSchema: shipmentLabelTable,
    destField: ['shipmentId'],
  }),
  shipmentProblems: many({
    sourceField: ['id'],
    destSchema: shipmentProblemTable,
    destField: ['shipmentId'],
  }),
  shipmentTrackingEvents: many({
    sourceField: ['id'],
    destSchema: shipmentTrackingEventTable,
    destField: ['shipmentId'],
  }),
}));

const shipmentLabelRelationships = relationships(shipmentLabelTable, ({ one, many }) => ({
  shipment: one({
    sourceField: ['shipmentId'],
    destSchema: shipmentTable,
    destField: ['id'],
  }),
  shippingApiRequests: many({
    sourceField: ['id'],
    destSchema: shippingApiRequestTable,
    destField: ['shipmentLabelId'],
  }),
}));

const shipmentProblemRelationships = relationships(shipmentProblemTable, ({ one }) => ({
  shipment: one({
    sourceField: ['shipmentId'],
    destSchema: shipmentTable,
    destField: ['id'],
  }),
}));

const shipmentTrackingEventRelationships = relationships(shipmentTrackingEventTable, ({ one }) => ({
  shipment: one({
    sourceField: ['shipmentId'],
    destSchema: shipmentTable,
    destField: ['id'],
  }),
  webhookRequest: one({
    sourceField: ['webhookRequestId'],
    destSchema: webhookRequestTable,
    destField: ['id'],
  }),
}));

const shippingApiRequestRelationships = relationships(shippingApiRequestTable, ({ one }) => ({
  shipmentLabel: one({
    sourceField: ['shipmentLabelId'],
    destSchema: shipmentLabelTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const shippingCarrierRelationships = relationships(shippingCarrierTable, ({ one, many }) => ({
  company: one({
    sourceField: ['companyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  shippingServices: many({
    sourceField: ['id'],
    destSchema: shippingServiceTable,
    destField: ['carrierId'],
  }),
}));

const shippingServiceRelationships = relationships(shippingServiceTable, ({ one }) => ({
  carrier: one({
    sourceField: ['carrierId'],
    destSchema: shippingCarrierTable,
    destField: ['id'],
  }),
}));

const systemEventRelationships = relationships(systemEventTable, ({ one }) => ({
  initiatedBy: one({
    sourceField: ['initiatedById'],
    destSchema: userTable,
    destField: ['id'],
  }),
  patient: one({
    sourceField: ['patientId'],
    destSchema: patientTable,
    destField: ['id'],
  }),
  user: one({
    sourceField: ['userId'],
    destSchema: userTable,
    destField: ['id'],
  }),
}));

const transactionRelationships = relationships(transactionTable, ({ one }) => ({
  createdBy: one({
    sourceField: ['createdById'],
    destSchema: userTable,
    destField: ['id'],
  }),
  order: one({
    sourceField: ['orderId'],
    destSchema: fillOrderTable,
    destField: ['id'],
  }),
  pharmacyCompany: one({
    sourceField: ['pharmacyCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  providerCompany: one({
    sourceField: ['providerCompanyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
}));

const userRelationships = relationships(userTable, ({ one, many }) => ({
  company: one({
    sourceField: ['companyId'],
    destSchema: companyTable,
    destField: ['id'],
  }),
  faxAuditEvents: many({
    sourceField: ['id'],
    destSchema: faxAuditEventTable,
    destField: ['userId'],
  }),
  faxDocuments: many({
    sourceField: ['id'],
    destSchema: faxDocumentTable,
    destField: ['reviewedById'],
  }),
  faxWebhookRequests: many({
    sourceField: ['id'],
    destSchema: faxWebhookRequestTable,
    destField: ['userId'],
  }),
  fillOrderApiRequests: many({
    sourceField: ['id'],
    destSchema: fillOrderApiRequestTable,
    destField: ['userId'],
  }),
  fillOrderIngredientEvents: many({
    sourceField: ['id'],
    destSchema: fillOrderIngredientEventTable,
    destField: ['userId'],
  }),
  fillOrdersAsLockedBy: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['lockedById'],
  }),
  fillOrdersAsPharmacist: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['pharmacistId'],
  }),
  fillOrdersAsTechnician: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['technicianId'],
  }),
  fillOrdersAsVerifiedBy: many({
    sourceField: ['id'],
    destSchema: fillOrderTable,
    destField: ['verifiedById'],
  }),
  fillOrderStatusEvents: many({
    sourceField: ['id'],
    destSchema: fillOrderStatusEventTable,
    destField: ['userId'],
  }),
  ingredientMaps: many({
    sourceField: ['id'],
    destSchema: ingredientMapTable,
    destField: ['userId'],
  }),
  orderDocuments: many({
    sourceField: ['id'],
    destSchema: orderDocumentTable,
    destField: ['userId'],
  }),
  orderNotes: many({
    sourceField: ['id'],
    destSchema: orderNoteTable,
    destField: ['userId'],
  }),
  patientDocuments: many({
    sourceField: ['id'],
    destSchema: patientDocumentTable,
    destField: ['userId'],
  }),
  patientNotes: many({
    sourceField: ['id'],
    destSchema: patientNoteTable,
    destField: ['userId'],
  }),
  prescriptionApiRequests: many({
    sourceField: ['id'],
    destSchema: prescriptionApiRequestTable,
    destField: ['userId'],
  }),
  prescriptionDocuments: many({
    sourceField: ['id'],
    destSchema: prescriptionDocumentTable,
    destField: ['userId'],
  }),
  prescriptionNotes: many({
    sourceField: ['id'],
    destSchema: prescriptionNoteTable,
    destField: ['userId'],
  }),
  shippingApiRequests: many({
    sourceField: ['id'],
    destSchema: shippingApiRequestTable,
    destField: ['userId'],
  }),
  systemEventsAsInitiatedBy: many({
    sourceField: ['id'],
    destSchema: systemEventTable,
    destField: ['initiatedById'],
  }),
  systemEventsAsUser: many({
    sourceField: ['id'],
    destSchema: systemEventTable,
    destField: ['userId'],
  }),
  transactions: many({
    sourceField: ['id'],
    destSchema: transactionTable,
    destField: ['createdById'],
  }),
}));

const webhookRequestRelationships = relationships(webhookRequestTable, ({ many }) => ({
  shipmentTrackingEvents: many({
    sourceField: ['id'],
    destSchema: shipmentTrackingEventTable,
    destField: ['webhookRequestId'],
  }),
}));

const zeroSchema = createSchema({
  tables: [
    bedrockCacheTable,
    billingInvoiceTable,
    companyTable,
    faxAuditEventTable,
    faxDocumentTable,
    faxDocumentPageTable,
    faxTemplateConfigTable,
    faxWebhookRequestTable,
    featureFlagTable,
    fillOrderTable,
    fillOrderApiRequestTable,
    fillOrderIngredientTable,
    fillOrderIngredientEventTable,
    fillOrderStatusEventTable,
    ingredientTable,
    ingredientMapTable,
    inventoryTable,
    ndcPharmaceuticalTable,
    orderDocumentTable,
    orderNoteTable,
    patientTable,
    patientDocumentTable,
    patientGuardianTable,
    patientNoteTable,
    physicianTable,
    physicianStateTable,
    prescriptionTable,
    prescriptionApiRequestTable,
    prescriptionDocumentTable,
    prescriptionNoteTable,
    shipmentTable,
    shipmentLabelTable,
    shipmentProblemTable,
    shipmentTrackingEventTable,
    shippingApiRequestTable,
    shippingCarrierTable,
    shippingServiceTable,
    systemEventTable,
    transactionTable,
    userTable,
    webhookRequestTable,
  ],
  relationships: [
    billingInvoiceRelationships,
    companyRelationships,
    faxAuditEventRelationships,
    faxDocumentRelationships,
    faxDocumentPageRelationships,
    faxTemplateConfigRelationships,
    faxWebhookRequestRelationships,
    fillOrderRelationships,
    fillOrderApiRequestRelationships,
    fillOrderIngredientRelationships,
    fillOrderIngredientEventRelationships,
    fillOrderStatusEventRelationships,
    ingredientRelationships,
    ingredientMapRelationships,
    inventoryRelationships,
    ndcPharmaceuticalRelationships,
    orderDocumentRelationships,
    orderNoteRelationships,
    patientRelationships,
    patientDocumentRelationships,
    patientGuardianRelationships,
    patientNoteRelationships,
    physicianRelationships,
    physicianStateRelationships,
    prescriptionRelationships,
    prescriptionApiRequestRelationships,
    prescriptionDocumentRelationships,
    prescriptionNoteRelationships,
    shipmentRelationships,
    shipmentLabelRelationships,
    shipmentProblemRelationships,
    shipmentTrackingEventRelationships,
    shippingApiRequestRelationships,
    shippingCarrierRelationships,
    shippingServiceRelationships,
    systemEventRelationships,
    transactionRelationships,
    userRelationships,
    webhookRequestRelationships,
  ],
  enableLegacyQueries: false,
  enableLegacyMutators: false,
});

/**
 * Type-safe query builder for Zero queries.
 * Use this to build queries with full TypeScript support.
 *
 * @example
 * const users = zql.user.where('partner', '=', true);
 * const messages = zql.message.related('sender').where('id', '=', id);
 */
const zql = createBuilder(zeroSchema);

type ZeroSchema = typeof zeroSchema;

// Row type aliases for type-safe access to table rows
type BedrockCacheRow = Row<typeof zeroSchema.tables.bedrockCache>;
type BillingInvoiceRow = Row<typeof zeroSchema.tables.billingInvoice>;
type CompanyRow = Row<typeof zeroSchema.tables.company>;
type FaxAuditEventRow = Row<typeof zeroSchema.tables.faxAuditEvent>;
type FaxDocumentRow = Row<typeof zeroSchema.tables.faxDocument>;
type FaxDocumentPageRow = Row<typeof zeroSchema.tables.faxDocumentPage>;
type FaxTemplateConfigRow = Row<typeof zeroSchema.tables.faxTemplateConfig>;
type FaxWebhookRequestRow = Row<typeof zeroSchema.tables.faxWebhookRequest>;
type FeatureFlagRow = Row<typeof zeroSchema.tables.featureFlag>;
type FillOrderRow = Row<typeof zeroSchema.tables.fillOrder>;
type FillOrderApiRequestRow = Row<typeof zeroSchema.tables.fillOrderApiRequest>;
type FillOrderIngredientRow = Row<typeof zeroSchema.tables.fillOrderIngredient>;
type FillOrderIngredientEventRow = Row<typeof zeroSchema.tables.fillOrderIngredientEvent>;
type FillOrderStatusEventRow = Row<typeof zeroSchema.tables.fillOrderStatusEvent>;
type IngredientRow = Row<typeof zeroSchema.tables.ingredient>;
type IngredientMapRow = Row<typeof zeroSchema.tables.ingredientMap>;
type InventoryRow = Row<typeof zeroSchema.tables.inventory>;
type NdcPharmaceuticalRow = Row<typeof zeroSchema.tables.ndcPharmaceutical>;
type OrderDocumentRow = Row<typeof zeroSchema.tables.orderDocument>;
type OrderNoteRow = Row<typeof zeroSchema.tables.orderNote>;
type PatientRow = Row<typeof zeroSchema.tables.patient>;
type PatientDocumentRow = Row<typeof zeroSchema.tables.patientDocument>;
type PatientGuardianRow = Row<typeof zeroSchema.tables.patientGuardian>;
type PatientNoteRow = Row<typeof zeroSchema.tables.patientNote>;
type PhysicianRow = Row<typeof zeroSchema.tables.physician>;
type PhysicianStateRow = Row<typeof zeroSchema.tables.physicianState>;
type PrescriptionRow = Row<typeof zeroSchema.tables.prescription>;
type PrescriptionApiRequestRow = Row<typeof zeroSchema.tables.prescriptionApiRequest>;
type PrescriptionDocumentRow = Row<typeof zeroSchema.tables.prescriptionDocument>;
type PrescriptionNoteRow = Row<typeof zeroSchema.tables.prescriptionNote>;
type ShipmentRow = Row<typeof zeroSchema.tables.shipment>;
type ShipmentLabelRow = Row<typeof zeroSchema.tables.shipmentLabel>;
type ShipmentProblemRow = Row<typeof zeroSchema.tables.shipmentProblem>;
type ShipmentTrackingEventRow = Row<typeof zeroSchema.tables.shipmentTrackingEvent>;
type ShippingApiRequestRow = Row<typeof zeroSchema.tables.shippingApiRequest>;
type ShippingCarrierRow = Row<typeof zeroSchema.tables.shippingCarrier>;
type ShippingServiceRow = Row<typeof zeroSchema.tables.shippingService>;
type SystemEventRow = Row<typeof zeroSchema.tables.systemEvent>;
type TransactionRow = Row<typeof zeroSchema.tables.transaction>;
type UserRow = Row<typeof zeroSchema.tables.user>;
type WebhookRequestRow = Row<typeof zeroSchema.tables.webhookRequest>;

/** User role enum for authorization checks */
type UserRole = 'admin' | 'partner' | 'pharmacist' | 'robot' | 'technician';

/** Roles that are allowed to access Zero queries and mutators */
const ALLOWED_ROLES: readonly UserRole[] = ['admin', 'pharmacist', 'technician', 'partner'];

/**
 * Authentication context for Zero queries and mutators.
 * This is passed automatically to queries and mutators for authorization checks.
 */
interface AuthContext {
  sub: string | null; // User ID from JWT (null if not authenticated)
  userId: string | null; // User ID (application-specific field)
  role: UserRole | null; // User role for permission checks
}

/**
 * Frontend auth context — role is always null because the client
 * cannot know its own role. Role is resolved server-side from JWT + database.
 */
type FrontendAuthContext = Omit<AuthContext, 'role'> & { readonly role: null };

/**
 * Module augmentation for Zero DefaultTypes.
 *
 * This augmentation is REQUIRED because Zero's client class defaults
 * its type parameters to DefaultSchema and DefaultContext.
 *
 * How these resolve (from @rocicorp/zero default-types.d.ts):
 *   DefaultSchema  → With augmentation: ZeroSchema  | Without: generic Schema
 *   DefaultContext → With augmentation: AuthContext  | Without: unknown
 *
 * Without this augmentation, DefaultContext resolves to `unknown`, causing all
 * useQuery() and zero.mutate() calls to fail with TS2345 (contravariance:
 * `ctx: unknown` is not assignable to `ctx: AuthContext`).
 *
 * NOTE: Do not import DefaultSchema/DefaultContext from '@rocicorp/zero' in
 * application code. Use the explicit types exported from this package instead:
 *   import type { Schema, AuthContext } from './schema';
 *
 * @see https://zero.rocicorp.dev/docs/schema
 */
declare module '@rocicorp/zero' {
  interface DefaultTypes {
    schema: ZeroSchema;
    context: AuthContext;
  }
}

export type {
  AuthContext,
  BedrockCacheRow,
  BillingInvoiceRow,
  CompanyRow,
  FaxAuditEventRow,
  FaxDocumentPageRow,
  FaxDocumentRow,
  FaxTemplateConfigRow,
  FaxWebhookRequestRow,
  FeatureFlagRow,
  FillOrderApiRequestRow,
  FillOrderIngredientEventRow,
  FillOrderIngredientRow,
  FillOrderRow,
  FillOrderStatusEventRow,
  FrontendAuthContext,
  IngredientEventSnapshot,
  IngredientMapRow,
  IngredientRow,
  InventoryRow,
  NdcPharmaceuticalRow,
  OrderDocumentRow,
  OrderNoteRow,
  PatientDocumentRow,
  PatientGuardianRow,
  PatientNoteRow,
  PatientRow,
  PhysicianRow,
  PhysicianStateRow,
  PrescriptionApiRequestRow,
  PrescriptionDocumentRow,
  PrescriptionNoteRow,
  PrescriptionRow,
  ZeroSchema as Schema,
  ShipmentLabelRow,
  ShipmentProblemRow,
  ShipmentRow,
  ShipmentTrackingEventRow,
  ShippingApiRequestRow,
  ShippingCarrierRow,
  ShippingServiceRow,
  SystemEventRow,
  TransactionRow,
  UserRole,
  UserRow,
  WebhookRequestRow,
};
const permissions = definePermissions<AuthContext, ZeroSchema>(zeroSchema, () => {
  const tablePermissions: Record<string, {
    row: { select: typeof ANYONE_CAN; insert: typeof ANYONE_CAN; update: { preMutation: typeof ANYONE_CAN }; delete: typeof ANYONE_CAN };
  }> = {};
  for (const tableName of Object.keys(zeroSchema.tables)) {
    tablePermissions[tableName] = {
      row: { select: ANYONE_CAN, insert: ANYONE_CAN, update: { preMutation: ANYONE_CAN }, delete: ANYONE_CAN },
    };
  }
  return tablePermissions;
});

export { ALLOWED_ROLES, permissions, zeroSchema as schema, zql };
