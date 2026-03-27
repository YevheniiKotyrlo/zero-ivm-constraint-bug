import type { ExpressionBuilder, Query, ReadonlyJSONValue } from '@rocicorp/zero';
import { defineQueriesWithType, defineQueryWithType } from '@rocicorp/zero';

import type {
  AuthContext,
  FaxDocumentPageRow,
  FaxDocumentRow,
  FillOrderRow,
  PatientRow,
  PrescriptionRow,
  Schema,
  UserRow,
} from './schema';
import { zql } from './schema';
import type {
  FaxTypeUnion,
  FillOrderSourceUnion,
  IntakeSourceTypeUnion,
  IntakeStatusUnion,
  OrderStatusUnion,
  OrderTypeUnion,
  PostalCarrierUnion,
  PrescriptionKindUnion,
  ProductTypeUnion,
  UserRoleUnion,
} from './validators';

/** Match mode for text filters - values match PrimeVue FilterMatchMode constants */
type TextMatchMode = 'contains' | 'endsWith' | 'equals' | 'notContains' | 'notEquals' | 'startsWith';

/** Text filter with value and match mode */
interface TextFilter {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  value: string;
  matchMode: TextMatchMode;
}

/** Match mode for numeric filters */
type NumericMatchMode = 'equals' | 'gt' | 'gte' | 'lt' | 'lte' | 'notEquals';

/** Numeric filter with value and match mode */
interface NumericFilter {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  value: number;
  matchMode: NumericMatchMode;
}

/** Converts a TextFilter to ZQL operator and pattern */
const toZqlStringFilter = (filter: TextFilter): { operator: '!=' | '=' | 'ILIKE' | 'NOT ILIKE'; pattern: string } => {
  switch (filter.matchMode) {
    case 'startsWith': {
      return { operator: 'ILIKE', pattern: `${filter.value}%` };
    }
    case 'endsWith': {
      return { operator: 'ILIKE', pattern: `%${filter.value}` };
    }
    case 'notContains': {
      return { operator: 'NOT ILIKE', pattern: `%${filter.value}%` };
    }
    case 'equals': {
      return { operator: '=', pattern: filter.value };
    }
    case 'notEquals': {
      return { operator: '!=', pattern: filter.value };
    }
    case 'contains': {
      return { operator: 'ILIKE', pattern: `%${filter.value}%` };
    }
  }
};

/** Whether the match mode produces a negation (NOT ILIKE, !=) requiring AND instead of OR for multi-field search */
const isNegativeMatchMode = (matchMode: TextMatchMode): boolean =>
  matchMode === 'notContains' || matchMode === 'notEquals';

/** Converts a NumericMatchMode to a ZQL comparison operator */
const toZqlNumericOperator = (matchMode: NumericMatchMode): '!=' | '<' | '<=' | '=' | '>' | '>=' => {
  const map: Record<NumericMatchMode, '!=' | '<' | '<=' | '=' | '>' | '>='> = {
    equals: '=',
    gt: '>',
    gte: '>=',
    lt: '<',
    lte: '<=',
    notEquals: '!=',
  };
  return map[matchMode];
};

/** Filter arguments for fillOrder.list query */
interface FillOrderListFilters {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  fillId?: TextFilter | undefined;
  addressLine1?: TextFilter | undefined;
  addressLine2?: TextFilter | undefined;
  addressLine3?: TextFilter | undefined;
  city?: TextFilter | undefined;
  addressState?: string | undefined;
  zipcode?: TextFilter | undefined;
  orderSource?: FillOrderSourceUnion | undefined;
  orderStatus?: readonly OrderStatusUnion[] | undefined;
  orderType?: OrderTypeUnion | undefined;
  allergyType?: TextFilter | undefined;
  memo?: TextFilter | undefined;
  createdBefore?: number | undefined;
  createdAfter?: number | undefined;
  patientFilterName?: TextFilter | undefined;
  patientFilterPreferredName?: TextFilter | undefined;
  patientFilterEmail?: TextFilter | undefined;
  patientFilterPhone?: TextFilter | undefined;
  patientFilterDob?: string | undefined;
  patientIsMinor?: boolean | undefined;
  pharmacistName?: TextFilter | undefined;
  verifiedByName?: TextFilter | undefined;
  trackingNumber?: TextFilter | undefined;
  carrier?: PostalCarrierUnion | undefined;
  prescriberFilterName?: TextFilter | undefined;
  prescriberFilterNpi?: TextFilter | undefined;
  globalSearch?: string | undefined;
  /** Pre-formatted DOB from globalSearch if it looks like a date. Use formatDateOfBirthForQuery() in frontend. */
  globalSearchFormattedDob?: string | undefined;
  sortField: 'createdAt' | 'fillId' | 'memo' | 'orderStatus' | 'orderType';
  sortOrder: 'asc' | 'desc';
  limit: number;
  startRow?: Partial<FillOrderRow> | undefined;
}

/** Filter arguments for patient.list query */
interface PatientListFilters {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  readableId?: TextFilter | undefined;
  fillId?: TextFilter | undefined;
  patientFilterName?: TextFilter | undefined;
  patientFilterPreferredName?: TextFilter | undefined;
  patientFilterEmail?: TextFilter | undefined;
  patientFilterPhone?: TextFilter | undefined;
  patientFilterDob?: string | undefined;
  patientIsMinor?: boolean | undefined;
  contact?: TextFilter | undefined;
  addressLine1?: TextFilter | undefined;
  addressLine2?: TextFilter | undefined;
  addressLine3?: TextFilter | undefined;
  city?: TextFilter | undefined;
  addressState?: string | undefined;
  zipcode?: TextFilter | undefined;
  physicianFilterName?: TextFilter | undefined;
  physicianFilterNpi?: TextFilter | undefined;
  createdBefore?: number | undefined;
  createdAfter?: number | undefined;
  globalSearch?: string | undefined;
  /** Pre-formatted DOB from globalSearch if it looks like a date. Use formatDateOfBirthForQuery() in frontend. */
  globalSearchFormattedDob?: string | undefined;
  sortField: 'createdAt' | 'readableId';
  sortOrder: 'asc' | 'desc';
  limit: number;
  startRow?: Partial<PatientRow> | undefined;
}

/** Filter arguments for patient.assignmentList query (lightweight, for inline assignment) */
interface PatientAssignmentListFilters {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  patientFilterFirstName?: TextFilter | undefined;
  patientFilterLastName?: TextFilter | undefined;
  patientFilterDob?: string | undefined;
  limit: number;
}

/** Filter arguments for user.list query */
interface UserListFilters {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  userName?: TextFilter | undefined;
  email?: TextFilter | undefined;
  phone?: TextFilter | undefined;
  state?: readonly string[] | undefined;
  role?: UserRoleUnion | undefined;
  isActive?: boolean | undefined;
  isStaff?: boolean | undefined;
  createdBefore?: number | undefined;
  createdAfter?: number | undefined;
  dateJoinedBefore?: number | undefined;
  dateJoinedAfter?: number | undefined;
  lastLoginBefore?: number | undefined;
  lastLoginAfter?: number | undefined;
  globalSearch?: string | undefined;
  sortField:
    | 'additionalDetails'
    | 'companyId'
    | 'createdAt'
    | 'dateJoined'
    | 'email'
    | 'firstName'
    | 'id'
    | 'isActive'
    | 'isStaff'
    | 'isSuperuser'
    | 'lastLogin'
    | 'lastName'
    | 'lastSeen'
    | 'middleName'
    | 'phone'
    | 'role'
    | 'state'
    | 'tokenValidMinTime'
    | 'updatedAt';
  sortOrder: 'asc' | 'desc';
  limit: number;
  startRow?: Partial<UserRow> | undefined;
}

/** Filter arguments for prescription.list query */
interface PrescriptionListFilters {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  rxId?: TextFilter | undefined;
  medicationName?: TextFilter | undefined;
  productType?: ProductTypeUnion | undefined;
  kind?: PrescriptionKindUnion | undefined;
  qty?: NumericFilter | undefined;
  daysSupply?: NumericFilter | undefined;
  authRefills?: NumericFilter | undefined;
  createdBefore?: number | undefined;
  createdAfter?: number | undefined;
  signedBefore?: number | undefined;
  signedAfter?: number | undefined;
  patientFilterName?: TextFilter | undefined;
  patientFilterPreferredName?: TextFilter | undefined;
  patientFilterEmail?: TextFilter | undefined;
  patientFilterPhone?: TextFilter | undefined;
  patientFilterDob?: string | undefined;
  patientIsMinor?: boolean | undefined;
  physicianFilterName?: TextFilter | undefined;
  physicianFilterNpi?: TextFilter | undefined;
  globalSearch?: string | undefined;
  /** Pre-formatted DOB from globalSearch if it looks like a date. Use formatDateOfBirthForQuery() in frontend. */
  globalSearchFormattedDob?: string | undefined;
  sortField:
    | 'authRefills'
    | 'createdAt'
    | 'daysSupply'
    | 'kind'
    | 'medicationName'
    | 'productType'
    | 'qty'
    | 'rxId'
    | 'signedAt';
  sortOrder: 'asc' | 'desc';
  limit: number;
  startRow?: Partial<PrescriptionRow> | undefined;
}

/** Filter arguments for fillOrder.verifiedList query */
interface VerifiedOrderListFilters {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  orderId?: TextFilter | undefined;
  rxNumber?: TextFilter | undefined;
  drugName?: TextFilter | undefined;
  prescriberFilterName?: TextFilter | undefined;
  prescriberFilterNpi?: TextFilter | undefined;
  patientFilterName?: TextFilter | undefined;
  patientFilterPreferredName?: TextFilter | undefined;
  patientFilterEmail?: TextFilter | undefined;
  patientFilterPhone?: TextFilter | undefined;
  patientFilterDob?: string | undefined;
  patientIsMinor?: boolean | undefined;
  patientPhone?: TextFilter | undefined;
  patientEmail?: TextFilter | undefined;
  patientCreatedBefore?: number | undefined;
  patientCreatedAfter?: number | undefined;
  patientState?: readonly string[] | undefined;
  verifiedByName?: TextFilter | undefined;
  providerCompanyName?: TextFilter | undefined;
  orderDateBefore?: number | undefined;
  orderDateAfter?: number | undefined;
  verificationDateStart?: number | undefined;
  verificationDateEnd?: number | undefined;
  globalSearch?: string | undefined;
  /** Pre-formatted DOB from globalSearch if it looks like a date. Use formatDateOfBirthForQuery() in frontend. */
  globalSearchFormattedDob?: string | undefined;
  sortField: 'createdAt' | 'id' | 'verifiedAt';
  sortOrder: 'asc' | 'desc';
  limit: number;
  startRow?: Partial<FillOrderRow> | undefined;
}

/** Filter arguments for faxDocument.list query */
interface FaxDocumentListFilters {
  readonly [key: string]: ReadonlyJSONValue | undefined;
  status?: readonly IntakeStatusUnion[] | undefined;
  faxType?: FaxTypeUnion | undefined;
  prescriptionKind?: PrescriptionKindUnion | undefined;
  sourceType?: IntakeSourceTypeUnion | undefined;
  templateFamily?: TextFilter | undefined;
  memo?: TextFilter | undefined;
  receivedBefore?: number | undefined;
  receivedAfter?: number | undefined;
  createdBefore?: number | undefined;
  createdAfter?: number | undefined;
  globalSearch?: string | undefined;
  sortField: 'createdAt' | 'receivedAt' | 'status';
  sortOrder: 'asc' | 'desc';
  limit: number;
  startRow?: Partial<FaxDocumentRow> | undefined;
}

/** Expression builder type for faxDocument table */
type FaxDocumentExpressionBuilder = ExpressionBuilder<'faxDocument', Schema>;

/** Expression builder type for patient table */
type PatientExpressionBuilder = ExpressionBuilder<'patient', Schema>;

/** Expression builder type for user table */
type UserExpressionBuilder = ExpressionBuilder<'user', Schema>;

/** Expression builder type for fillOrder table */
type FillOrderExpressionBuilder = ExpressionBuilder<'fillOrder', Schema>;

/** Expression builder type for prescription table */
type PrescriptionExpressionBuilder = ExpressionBuilder<'prescription', Schema>;

/** Expression builder type for physician table */
type PhysicianExpressionBuilder = ExpressionBuilder<'physician', Schema>;

/** Fallback ID used when query argument is empty to prevent Zero errors */
const FALLBACK_QUERY_ID = 'non-existent-id';

/** Typed query builders for our schema */
const defineQueries = defineQueriesWithType<Schema>();
const defineQuery = defineQueryWithType<Schema, AuthContext>();

/** Query builder - use zql from schema for type-safe queries */
const builder = zql;

/** Reusable related query callback: fax document pages ordered by page number */
const withFaxDocumentPagesOrdered = (
  pagesQuery: Query<'faxDocumentPage', Schema, FaxDocumentPageRow>,
): Query<'faxDocumentPage', Schema, FaxDocumentPageRow> => pagesQuery.orderBy('pageNumber', 'asc');

/** ID argument type used by most queries */
interface IdArgs {
  args: { id: string };
}

/** Fill order ID argument type */
interface FillOrderIdArgs {
  args: { fillOrderId: string };
}

/** Order ID argument type */
interface OrderIdArgs {
  args: { orderId: string };
}

/** Ingredient ID argument type */
interface IngredientIdArgs {
  args: { ingredientId: string };
}

/** Fill ID argument type (readable fillId, not UUID) */
interface FillIdArgs {
  args: { fillId: string };
}

/** Multiple IDs argument type for batch queries */
interface IdsArgs {
  args: { ids: readonly string[] };
}

/** Note ID argument type for document queries */
interface NoteIdArgs {
  args: { noteId: string };
}

/** Patient ID argument type */
interface PatientIdArgs {
  args: { patientId: string };
}

/** List filters argument type for fillOrder list query */
interface FillOrderListArgs {
  args: FillOrderListFilters;
}

/** List filters argument type for patient list query */
interface PatientListArgs {
  args: PatientListFilters;
}

/** List filters argument type for patient assignment list query */
interface PatientAssignmentListArgs {
  args: PatientAssignmentListFilters;
}

/** List filters argument type for user list query */
interface UserListArgs {
  args: UserListFilters;
}

/** List filters argument type for prescription list query */
interface PrescriptionListArgs {
  args: PrescriptionListFilters;
}

/** List filters argument type for verified order list query */
interface VerifiedOrderListArgs {
  args: VerifiedOrderListFilters;
}

/** List filters argument type for faxDocument list query */
interface FaxDocumentListArgs {
  args: FaxDocumentListFilters;
}

/**
 * Helper type guard to check if a cursor row is defined.
 * Used for cursor-based pagination with Zero queries.
 */
const hasCursorRow = <T>(startRow: T | undefined): startRow is T => startRow !== undefined;

/**
 * Helper to pick specific keys from an object, excluding undefined values.
 * This is needed for exactOptionalPropertyTypes compatibility.
 */
const pickDefined = <T extends object>(obj: Partial<T>, keys: readonly (keyof T)[]): Partial<T> => {
  const result: Partial<T> = {};
  for (const key of keys) {
    if (obj[key] !== undefined) {
      result[key] = obj[key];
    }
  }
  return result;
};

/** Columns used for faxDocument cursor-based pagination */
const FAX_DOCUMENT_CURSOR_KEYS = [
  'id',
  'receivedAt',
  'createdAt',
  'status',
] as const satisfies readonly (keyof FaxDocumentRow)[];

/**
 * Extracts only valid faxDocument columns from a row object for cursor-based pagination.
 */
const extractFaxDocumentCursor = (row: Partial<FaxDocumentRow>): Partial<FaxDocumentRow> =>
  pickDefined(row, FAX_DOCUMENT_CURSOR_KEYS);

/** Columns used for fillOrder cursor-based pagination */
const FILL_ORDER_CURSOR_KEYS = [
  'id',
  'createdAt',
  'fillId',
  'orderStatus',
  'orderType',
  'memo',
  'verifiedAt',
  'updatedAt',
] as const satisfies readonly (keyof FillOrderRow)[];

/**
 * Extracts only valid fillOrder columns from a row object for cursor-based pagination.
 * This is necessary because query results may include relations or unmapped DB columns
 * that Zero's .start() method cannot process.
 */
const extractFillOrderCursor = (row: Partial<FillOrderRow>): Partial<FillOrderRow> =>
  pickDefined(row, FILL_ORDER_CURSOR_KEYS);

/** Columns used for user cursor-based pagination */
const USER_CURSOR_KEYS = [
  'id',
  'createdAt',
  'updatedAt',
  'isActive',
  'state',
  'email',
  'phone',
  'role',
  'firstName',
  'lastName',
  'middleName',
  'lastLogin',
  'isSuperuser',
  'isStaff',
  'dateJoined',
  'tokenValidMinTime',
  'additionalDetails',
  'lastSeen',
  'companyId',
] as const satisfies readonly (keyof UserRow)[];

/**
 * Extracts only valid user columns from a row object for cursor-based pagination.
 */
const extractUserCursor = (row: Partial<UserRow>): Partial<UserRow> => pickDefined(row, USER_CURSOR_KEYS);

/** Columns used for patient cursor-based pagination */
const PATIENT_CURSOR_KEYS = ['id', 'createdAt', 'readableId'] as const satisfies readonly (keyof PatientRow)[];

/**
 * Extracts only valid patient columns from a row object for cursor-based pagination.
 */
const extractPatientCursor = (row: Partial<PatientRow>): Partial<PatientRow> => pickDefined(row, PATIENT_CURSOR_KEYS);

/** Columns used for prescription cursor-based pagination */
const PRESCRIPTION_CURSOR_KEYS = [
  'id',
  'rxId',
  'createdAt',
  'medicationName',
  'productType',
  'kind',
  'qty',
  'daysSupply',
  'authRefills',
  'signedAt',
] as const satisfies readonly (keyof PrescriptionRow)[];

/**
 * Extracts only valid prescription columns from a row object for cursor-based pagination.
 */
const extractPrescriptionCursor = (row: Partial<PrescriptionRow>): Partial<PrescriptionRow> =>
  pickDefined(row, PRESCRIPTION_CURSOR_KEYS);

/**
 * Splits a search term into individual words for multi-word AND search.
 * Returns empty array if term is empty or only whitespace.
 */
const splitSearchWords = (term: string | undefined): string[] => {
  if (term === undefined || term === '') {
    return [];
  }
  return term
    .trim()
    .split(/\s+/)
    .filter((word) => word.length > 0);
};

/**
 * Applies multi-word AND search to patient name fields only (firstName, middleName, lastName) via whereExists.
 * Works with tables that have a 'patient' relationship (fillOrder).
 */
const applyPatientNameOnlyFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const words = splitSearchWords(filter.value);
  if (words.length === 0) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  return query.whereExists('patient', (patientQuery) => {
    let filteredQuery = patientQuery;
    for (const word of words) {
      const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
      filteredQuery = filteredQuery.where((expressionBuilder: PatientExpressionBuilder) =>
        expressionBuilder[combine](
          expressionBuilder.cmp('firstName', operator, pattern),
          expressionBuilder.cmp('middleName', operator, pattern),
          expressionBuilder.cmp('lastName', operator, pattern),
        ),
      );
    }
    return filteredQuery;
  });
};

/**
 * Applies multi-word AND search to patient name fields only (firstName, middleName, lastName) via whereExists.
 * Works with tables that have a 'patient' relationship (prescription).
 */
const applyPrescriptionPatientNameOnlyFilter = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'prescription', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const words = splitSearchWords(filter.value);
  if (words.length === 0) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  return query.whereExists('patient', (patientQuery) => {
    let filteredQuery = patientQuery;
    for (const word of words) {
      const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
      filteredQuery = filteredQuery.where((expressionBuilder: PatientExpressionBuilder) =>
        expressionBuilder[combine](
          expressionBuilder.cmp('firstName', operator, pattern),
          expressionBuilder.cmp('middleName', operator, pattern),
          expressionBuilder.cmp('lastName', operator, pattern),
        ),
      );
    }
    return filteredQuery;
  });
};

/**
 * Applies multi-word AND search to pharmacist user fields.
 */
const applyPharmacistNameFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const words = splitSearchWords(filter.value);
  if (words.length === 0) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  return query.whereExists('pharmacist', (userQuery) => {
    let filteredQuery = userQuery;
    for (const word of words) {
      const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
      filteredQuery = filteredQuery.where((expressionBuilder: UserExpressionBuilder) =>
        expressionBuilder[combine](
          expressionBuilder.cmp('firstName', operator, pattern),
          expressionBuilder.cmp('middleName', operator, pattern),
          expressionBuilder.cmp('lastName', operator, pattern),
          expressionBuilder.cmp('email', operator, pattern),
        ),
      );
    }
    return filteredQuery;
  });
};

/**
 * Applies multi-word AND search to verifiedBy user fields.
 */
const applyVerifiedByNameFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const words = splitSearchWords(filter.value);
  if (words.length === 0) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  return query.whereExists('verifiedBy', (userQuery) => {
    let filteredQuery = userQuery;
    for (const word of words) {
      const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
      filteredQuery = filteredQuery.where((expressionBuilder: UserExpressionBuilder) =>
        expressionBuilder[combine](
          expressionBuilder.cmp('firstName', operator, pattern),
          expressionBuilder.cmp('middleName', operator, pattern),
          expressionBuilder.cmp('lastName', operator, pattern),
          expressionBuilder.cmp('email', operator, pattern),
        ),
      );
    }
    return filteredQuery;
  });
};

/**
 * Applies multi-word AND search to physician name fields only (firstName, middleName, lastName) via prescription relation.
 */
const applyPrescriberNameOnlyFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const words = splitSearchWords(filter.value);
  if (words.length === 0) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  return query.whereExists('prescription', (prescriptionQuery) =>
    prescriptionQuery.whereExists('physician', (physicianQuery) => {
      let filteredQuery = physicianQuery;
      for (const word of words) {
        const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
        filteredQuery = filteredQuery.where((expressionBuilder: PhysicianExpressionBuilder) =>
          expressionBuilder[combine](
            expressionBuilder.cmp('firstName', operator, pattern),
            expressionBuilder.cmp('middleName', operator, pattern),
            expressionBuilder.cmp('lastName', operator, pattern),
          ),
        );
      }
      return filteredQuery;
    }),
  );
};

/**
 * Applies global search OR filter across fillId and patient fields.
 * DOB is only included if globalSearchFormattedDob is provided (pre-formatted by frontend).
 */
const applyGlobalSearchFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  globalSearch: string | undefined,
  globalSearchFormattedDob: string | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (globalSearch === undefined || globalSearch === '') {
    return query;
  }
  const term = globalSearch.trim();
  if (term === '') {
    return query;
  }
  const words = splitSearchWords(term);

  return query.where((expressionBuilder: FillOrderExpressionBuilder) => {
    const conditions = [
      expressionBuilder.cmp('fillId', 'ILIKE', `%${term}%`),
      expressionBuilder.exists('patient', (patientQuery) => {
        let filteredPatientQuery = patientQuery;
        for (const word of words) {
          filteredPatientQuery = filteredPatientQuery.where((innerExpressionBuilder: PatientExpressionBuilder) =>
            innerExpressionBuilder.or(
              innerExpressionBuilder.cmp('firstName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('middleName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('lastName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('preferredName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('email', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('phone', 'ILIKE', `%${word}%`),
            ),
          );
        }
        return filteredPatientQuery;
      }),
    ];

    // Add DOB condition only if pre-formatted DOB was provided by frontend
    if (globalSearchFormattedDob !== undefined && globalSearchFormattedDob !== '') {
      conditions.push(
        expressionBuilder.exists('patient', (patientQuery) =>
          patientQuery.where('displayDateOfBirth', '=', globalSearchFormattedDob),
        ),
      );
    }

    return expressionBuilder.or(...conditions);
  });
};

/**
 * Applies multi-word AND search directly to patient name fields only (firstName, middleName, lastName).
 * For use when patient is the main table (not a relation).
 */
const applyDirectPatientNameOnlyFilter = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'patient', Schema, TReturn> => {
  const words = filter !== undefined ? splitSearchWords(filter.value) : [];
  if (words.length === 0 || filter === undefined) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  let filteredQuery = query;
  for (const word of words) {
    const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
    filteredQuery = filteredQuery.where((expressionBuilder) =>
      expressionBuilder[combine](
        expressionBuilder.cmp('firstName', operator, pattern),
        expressionBuilder.cmp('middleName', operator, pattern),
        expressionBuilder.cmp('lastName', operator, pattern),
      ),
    );
  }
  return filteredQuery;
};

/**
 * Applies contact filter (email or phone) to patient.
 */
const applyContactFilter = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'patient', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const term = filter.value.trim();
  if (term === '') {
    return query;
  }

  const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: term });
  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  return query.where((expressionBuilder) =>
    expressionBuilder[combine](
      expressionBuilder.cmp('email', operator, pattern),
      expressionBuilder.cmp('phone', operator, pattern),
    ),
  );
};

/**
 * Applies date of birth filter to patient queries.
 * Expects pre-formatted DOB (ISO YYYY-MM-DD) from frontend via formatDateOfBirthForQuery().
 */
const applyDateOfBirthFilter = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  dateOfBirth: string | undefined,
): Query<'patient', Schema, TReturn> => {
  if (dateOfBirth === undefined || dateOfBirth === '') {
    return query;
  }
  return query.where('displayDateOfBirth', '=', dateOfBirth);
};

/**
 * Applies date of birth filter via patient relation (for fillOrder queries).
 * Expects pre-formatted DOB (ISO YYYY-MM-DD) from frontend via formatDateOfBirthForQuery().
 */
const applyPatientDateOfBirthFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  dateOfBirth: string | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (dateOfBirth === undefined || dateOfBirth === '') {
    return query;
  }
  return query.whereExists('patient', (patientQuery) => patientQuery.where('displayDateOfBirth', '=', dateOfBirth));
};

/**
 * Applies date of birth filter via patient relation (for prescription queries).
 * Expects pre-formatted DOB (ISO YYYY-MM-DD) from frontend via formatDateOfBirthForQuery().
 */
const applyPrescriptionPatientDateOfBirthFilter = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  dateOfBirth: string | undefined,
): Query<'prescription', Schema, TReturn> => {
  if (dateOfBirth === undefined || dateOfBirth === '') {
    return query;
  }
  return query.whereExists('patient', (patientQuery) => patientQuery.where('displayDateOfBirth', '=', dateOfBirth));
};

const MINOR_AGE_THRESHOLD = 18;

/**
 * Calculates the ISO date string (YYYY-MM-DD) cutoff for minor determination.
 * A patient with displayDateOfBirth AFTER this date is a minor (under 18).
 * Uses displayDateOfBirth (ISO string) for consistency with all other DOB queries.
 */
const calculateMinorDobCutoff = (): string => {
  const now = new Date();
  const cutoffDate = new Date(now.getFullYear() - MINOR_AGE_THRESHOLD, now.getMonth(), now.getDate());
  const year = cutoffDate.getFullYear();
  const month = String(cutoffDate.getMonth() + 1).padStart(2, '0');
  const day = String(cutoffDate.getDate()).padStart(2, '0');
  return `${String(year)}-${month}-${day}`;
};

/**
 * Applies minor status filter to patient queries.
 * Uses displayDateOfBirth (ISO YYYY-MM-DD string) for lexicographic comparison.
 * - isMinor true: displayDateOfBirth > cutoff (born less than 18 years ago)
 * - isMinor false: displayDateOfBirth <= cutoff (born 18+ years ago, or empty DOB)
 *
 * Note: displayDateOfBirth is non-nullable in the schema (empty string for missing DOB).
 * Empty string '' is lexicographically <= any date cutoff, so patients without DOB
 * are correctly excluded from minors and included in not-minor results.
 */
const applyIsMinorFilter = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  isMinor: boolean | undefined,
): Query<'patient', Schema, TReturn> => {
  if (isMinor === undefined) {
    return query;
  }
  const cutoff = calculateMinorDobCutoff();
  if (isMinor) {
    return query.where('displayDateOfBirth', '>', cutoff);
  }
  return query.where('displayDateOfBirth', '<=', cutoff);
};

/**
 * Applies minor status filter via patient relation (for fillOrder queries).
 */
const applyPatientIsMinorFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  isMinor: boolean | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (isMinor === undefined) {
    return query;
  }
  const cutoff = calculateMinorDobCutoff();
  if (isMinor) {
    return query.whereExists('patient', (patientQuery) => patientQuery.where('displayDateOfBirth', '>', cutoff));
  }
  return query.whereExists('patient', (patientQuery) => patientQuery.where('displayDateOfBirth', '<=', cutoff));
};

/**
 * Applies minor status filter via patient relation (for prescription queries).
 */
const applyPrescriptionPatientIsMinorFilter = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  isMinor: boolean | undefined,
): Query<'prescription', Schema, TReturn> => {
  if (isMinor === undefined) {
    return query;
  }
  const cutoff = calculateMinorDobCutoff();
  if (isMinor) {
    return query.whereExists('patient', (patientQuery) => patientQuery.where('displayDateOfBirth', '>', cutoff));
  }
  return query.whereExists('patient', (patientQuery) => patientQuery.where('displayDateOfBirth', '<=', cutoff));
};

/**
 * Applies global search for patient table (readableId, email, phone, name, and DOB).
 * DOB is only included if globalSearchFormattedDob is provided (pre-formatted by frontend).
 */
const applyPatientGlobalSearch = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  globalSearch: string | undefined,
  globalSearchFormattedDob: string | undefined,
): Query<'patient', Schema, TReturn> => {
  if (globalSearch === undefined || globalSearch === '') {
    return query;
  }
  const term = globalSearch.trim();
  if (term === '') {
    return query;
  }
  const words = splitSearchWords(term);

  return query.where((expressionBuilder: PatientExpressionBuilder) => {
    const conditions = [
      expressionBuilder.cmp('readableId', 'ILIKE', `%${term}%`),
      expressionBuilder.cmp('email', 'ILIKE', `%${term}%`),
      expressionBuilder.cmp('phone', 'ILIKE', `%${term}%`),
      expressionBuilder.exists('fillOrders', (fillOrderQuery) => fillOrderQuery.where('fillId', 'ILIKE', `%${term}%`)),
    ];

    // Add DOB condition only if pre-formatted DOB was provided by frontend
    if (globalSearchFormattedDob !== undefined && globalSearchFormattedDob !== '') {
      conditions.push(expressionBuilder.cmp('displayDateOfBirth', '=', globalSearchFormattedDob));
    }

    // Multi-word AND name search: each word must match at least one name field
    const wordConditions = words.map((word) =>
      expressionBuilder.or(
        expressionBuilder.cmp('firstName', 'ILIKE', `%${word}%`),
        expressionBuilder.cmp('middleName', 'ILIKE', `%${word}%`),
        expressionBuilder.cmp('lastName', 'ILIKE', `%${word}%`),
        expressionBuilder.cmp('preferredName', 'ILIKE', `%${word}%`),
      ),
    );
    conditions.push(expressionBuilder.and(...wordConditions));

    return expressionBuilder.or(...conditions);
  });
};

/**
 * Applies physician name filter (firstName, middleName, lastName) via prescriptions relation for patient queries.
 */
const applyPhysicianNameOnlyFilterViaRx = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'patient', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const words = splitSearchWords(filter.value);
  if (words.length === 0) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  return query.whereExists('prescriptions', (prescriptionQuery) =>
    prescriptionQuery.whereExists('physician', (physicianQuery) => {
      let filteredQuery = physicianQuery;
      for (const word of words) {
        const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
        filteredQuery = filteredQuery.where((expressionBuilder: PhysicianExpressionBuilder) =>
          expressionBuilder[combine](
            expressionBuilder.cmp('firstName', operator, pattern),
            expressionBuilder.cmp('middleName', operator, pattern),
            expressionBuilder.cmp('lastName', operator, pattern),
          ),
        );
      }
      return filteredQuery;
    }),
  );
};

/**
 * Applies multi-word AND search to user name/email fields (for direct user queries).
 */
const applyDirectUserNameFilter = <TReturn>(
  query: Query<'user', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'user', Schema, TReturn> => {
  const words = filter !== undefined ? splitSearchWords(filter.value) : [];
  if (words.length === 0 || filter === undefined) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  let filteredQuery = query;
  for (const word of words) {
    const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
    filteredQuery = filteredQuery.where((expressionBuilder) =>
      expressionBuilder[combine](
        expressionBuilder.cmp('firstName', operator, pattern),
        expressionBuilder.cmp('middleName', operator, pattern),
        expressionBuilder.cmp('lastName', operator, pattern),
      ),
    );
  }
  return filteredQuery;
};

/**
 * Applies global search for user table.
 */
const applyUserGlobalSearch = <TReturn>(
  query: Query<'user', Schema, TReturn>,
  globalSearch: string | undefined,
): Query<'user', Schema, TReturn> => {
  if (globalSearch === undefined || globalSearch === '') {
    return query;
  }
  const term = globalSearch.trim();
  if (term === '') {
    return query;
  }
  const words = splitSearchWords(term);

  return query.where((expressionBuilder: UserExpressionBuilder) => {
    const conditions = [
      expressionBuilder.cmp('email', 'ILIKE', `%${term}%`),
      expressionBuilder.cmp('phone', 'ILIKE', `%${term}%`),
      expressionBuilder.cmp('state', 'ILIKE', `%${term}%`),
    ];

    // Multi-word AND name search: each word must match at least one name field
    const wordConditions = words.map((word) =>
      expressionBuilder.or(
        expressionBuilder.cmp('firstName', 'ILIKE', `%${word}%`),
        expressionBuilder.cmp('middleName', 'ILIKE', `%${word}%`),
        expressionBuilder.cmp('lastName', 'ILIKE', `%${word}%`),
      ),
    );
    conditions.push(expressionBuilder.and(...wordConditions));

    return expressionBuilder.or(...conditions);
  });
};

/**
 * Applies physician name filter (firstName, middleName, lastName) via direct physician relation.
 */
const applyPhysicianNameOnlyFilter = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  filter: TextFilter | undefined,
): Query<'prescription', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const words = splitSearchWords(filter.value);
  if (words.length === 0) {
    return query;
  }

  const combine = isNegativeMatchMode(filter.matchMode) ? 'and' : 'or';
  return query.whereExists('physician', (physicianQuery) => {
    let filteredQuery = physicianQuery;
    for (const word of words) {
      const { operator, pattern } = toZqlStringFilter({ matchMode: filter.matchMode, value: word });
      filteredQuery = filteredQuery.where((expressionBuilder: PhysicianExpressionBuilder) =>
        expressionBuilder[combine](
          expressionBuilder.cmp('firstName', operator, pattern),
          expressionBuilder.cmp('middleName', operator, pattern),
          expressionBuilder.cmp('lastName', operator, pattern),
        ),
      );
    }
    return filteredQuery;
  });
};

/**
 * Applies global search for prescription table.
 * DOB is only included if globalSearchFormattedDob is provided (pre-formatted by frontend).
 */
const applyPrescriptionGlobalSearch = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  globalSearch: string | undefined,
  globalSearchFormattedDob: string | undefined,
): Query<'prescription', Schema, TReturn> => {
  if (globalSearch === undefined || globalSearch === '') {
    return query;
  }
  const term = globalSearch.trim();
  if (term === '') {
    return query;
  }
  const words = splitSearchWords(term);

  // Note: productType and kind are enum fields - ILIKE not supported
  return query.where((expressionBuilder: PrescriptionExpressionBuilder) => {
    const conditions = [
      expressionBuilder.cmp('rxId', 'ILIKE', `%${term}%`),
      expressionBuilder.cmp('medicationName', 'ILIKE', `%${term}%`),
      expressionBuilder.exists('patient', (patientQuery) => {
        let filteredPatientQuery = patientQuery;
        for (const word of words) {
          filteredPatientQuery = filteredPatientQuery.where((innerExpressionBuilder: PatientExpressionBuilder) =>
            innerExpressionBuilder.or(
              innerExpressionBuilder.cmp('firstName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('middleName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('lastName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('preferredName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('email', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('phone', 'ILIKE', `%${word}%`),
            ),
          );
        }
        return filteredPatientQuery;
      }),
      expressionBuilder.exists('physician', (physicianQuery) => {
        let filteredPhysicianQuery = physicianQuery;
        for (const word of words) {
          filteredPhysicianQuery = filteredPhysicianQuery.where((innerExpressionBuilder: PhysicianExpressionBuilder) =>
            innerExpressionBuilder.or(
              innerExpressionBuilder.cmp('firstName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('middleName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('lastName', 'ILIKE', `%${word}%`),
              innerExpressionBuilder.cmp('npi', 'ILIKE', `%${word}%`),
            ),
          );
        }
        return filteredPhysicianQuery;
      }),
    ];

    // Add DOB condition only if pre-formatted DOB was provided by frontend
    if (globalSearchFormattedDob !== undefined && globalSearchFormattedDob !== '') {
      conditions.push(
        expressionBuilder.exists('patient', (patientQuery) =>
          patientQuery.where('displayDateOfBirth', '=', globalSearchFormattedDob),
        ),
      );
    }

    return expressionBuilder.or(...conditions);
  });
};

/**
 * Applies global search for faxDocument table (id, templateFamily, memo).
 */
const applyFaxDocumentGlobalSearch = <TReturn>(
  query: Query<'faxDocument', Schema, TReturn>,
  globalSearch: string | undefined,
): Query<'faxDocument', Schema, TReturn> => {
  if (globalSearch === undefined || globalSearch === '') {
    return query;
  }
  const term = globalSearch.trim();
  if (term === '') {
    return query;
  }
  return query.where((expressionBuilder: FaxDocumentExpressionBuilder) =>
    expressionBuilder.or(
      expressionBuilder.cmp('documentId', 'ILIKE', `%${term}%`),
      expressionBuilder.cmp('templateFamily', 'ILIKE', `%${term}%`),
      expressionBuilder.cmp('memo', 'ILIKE', `%${term}%`),
    ),
  );
};

/**
 * Applies a single patient field filter via whereExists on a fillOrder query.
 */
const applyPatientFieldFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  column: 'email' | 'phone' | 'preferredName',
  filter: TextFilter | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const { operator, pattern } = toZqlStringFilter(filter);
  return query.whereExists('patient', (patientQuery) => patientQuery.where(column, operator, pattern));
};

/**
 * Applies granular patient field filters (preferredName, email, phone) via patient relation for fillOrder queries.
 */
const applyFillOrderPatientFieldFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: FillOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = applyPatientNameOnlyFilter(query, args.patientFilterName);
  filtered = applyPatientFieldFilter(filtered, 'preferredName', args.patientFilterPreferredName);
  filtered = applyPatientFieldFilter(filtered, 'email', args.patientFilterEmail);
  filtered = applyPatientFieldFilter(filtered, 'phone', args.patientFilterPhone);
  filtered = applyPatientDateOfBirthFilter(filtered, args.patientFilterDob);
  filtered = applyPatientIsMinorFilter(filtered, args.patientIsMinor);
  return filtered;
};

/**
 * Applies text field filters (fillId, address lines, city, zipcode, memo) for fillOrder list queries.
 */
const applyFillOrderTextFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: FillOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = query;
  for (const [column, filter] of [
    ['fillId', args.fillId],
    ['addressLine1', args.addressLine1],
    ['addressLine2', args.addressLine2],
    ['addressLine3', args.addressLine3],
    ['city', args.city],
    ['zipcode', args.zipcode],
    ['memo', args.memo],
  ] as const) {
    if (filter !== undefined) {
      const { operator, pattern } = toZqlStringFilter(filter);
      filtered = filtered.where(column, operator, pattern);
    }
  }
  return filtered;
};

/**
 * Applies enum and date filters for fillOrder list queries.
 */
const applyFillOrderEnumFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: FillOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = query;
  if (args.addressState !== undefined && args.addressState !== '') {
    filtered = filtered.where('state', '=', args.addressState);
  }
  if (args.orderSource !== undefined) {
    filtered = filtered.where('orderSource', '=', args.orderSource);
  }
  if (args.orderStatus !== undefined && args.orderStatus.length > 0) {
    filtered = filtered.where('orderStatus', 'IN', args.orderStatus);
  }
  if (args.orderType !== undefined) {
    filtered = filtered.where('orderType', '=', args.orderType);
  }
  return filtered;
};

const applyFillOrderDateFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: FillOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = query;
  if (args.createdBefore !== undefined) {
    filtered = filtered.where('createdAt', '<', args.createdBefore);
  }
  if (args.createdAfter !== undefined) {
    filtered = filtered.where('createdAt', '>', args.createdAfter);
  }
  return filtered;
};

/**
 * Applies all direct field filters for fillOrder list queries.
 */
const applyFillOrderDirectFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: FillOrderListFilters,
): Query<'fillOrder', Schema, TReturn> =>
  applyFillOrderDateFilters(applyFillOrderEnumFilters(applyFillOrderTextFilters(query, args), args), args);

/**
 * Applies prescriber filters (name + NPI via prescription→physician) for fillOrder queries.
 */
const applyFillOrderPrescriberFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: Pick<FillOrderListFilters, 'prescriberFilterName' | 'prescriberFilterNpi'>,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = applyPrescriberNameOnlyFilter(query, args.prescriberFilterName);
  if (args.prescriberFilterNpi !== undefined) {
    const npiFilter = toZqlStringFilter(args.prescriberFilterNpi);
    filtered = filtered.whereExists('prescription', (prescriptionQuery) =>
      prescriptionQuery.whereExists('physician', (physicianQuery) =>
        physicianQuery.where('npi', npiFilter.operator, npiFilter.pattern),
      ),
    );
  }
  return filtered;
};

/**
 * Applies shipment filters (tracking number + carrier on the same shipment) for fillOrder queries.
 */
const applyFillOrderShipmentFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: Pick<FillOrderListFilters, 'carrier' | 'trackingNumber'>,
): Query<'fillOrder', Schema, TReturn> => {
  const hasShipmentFilter = args.trackingNumber !== undefined || args.carrier !== undefined;
  if (!hasShipmentFilter) {
    return query;
  }
  return query.whereExists('shipments', (shipmentQuery) => {
    let filtered = shipmentQuery;
    if (args.carrier !== undefined) {
      filtered = filtered.where('carrier', '=', args.carrier);
    }
    if (args.trackingNumber !== undefined) {
      const trackingFilter = toZqlStringFilter(args.trackingNumber);
      filtered = filtered.whereExists('shipmentLabels', (labelQuery) =>
        labelQuery.where('trackingNumber', trackingFilter.operator, trackingFilter.pattern),
      );
    }
    return filtered;
  });
};

/**
 * Applies direct field filters and date range for verified order list queries.
 */
const applyVerifiedOrderVerificationDateFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: VerifiedOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = query;
  if (args.verificationDateStart !== undefined) {
    filtered = filtered.where('verifiedAt', '>=', args.verificationDateStart);
  }
  if (args.verificationDateEnd !== undefined) {
    filtered = filtered.where('verifiedAt', '<', args.verificationDateEnd);
  }
  return filtered;
};

const applyVerifiedOrderDirectFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: VerifiedOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = applyVerifiedOrderVerificationDateFilters(query, args);
  if (args.orderId !== undefined) {
    const { operator, pattern } = toZqlStringFilter(args.orderId);
    filtered = filtered.where('fillId', operator, pattern);
  }
  if (args.orderDateBefore !== undefined) {
    filtered = filtered.where('createdAt', '<', args.orderDateBefore);
  }
  if (args.orderDateAfter !== undefined) {
    filtered = filtered.where('createdAt', '>', args.orderDateAfter);
  }
  return filtered;
};

/**
 * Applies core patient filters (name, preferredName, email, phone, DOB, isMinor) for verified order queries.
 */
const applyVerifiedOrderPatientCoreFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: VerifiedOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = applyPatientNameOnlyFilter(query, args.patientFilterName);
  filtered = applyPatientFieldFilter(filtered, 'preferredName', args.patientFilterPreferredName);
  filtered = applyPatientFieldFilter(filtered, 'email', args.patientFilterEmail);
  filtered = applyPatientFieldFilter(filtered, 'phone', args.patientFilterPhone);
  filtered = applyPatientDateOfBirthFilter(filtered, args.patientFilterDob);
  filtered = applyPatientIsMinorFilter(filtered, args.patientIsMinor);
  return filtered;
};

/**
 * Applies a patient createdAt date range filter via whereExists on a fillOrder query.
 */
const applyPatientCreatedAtRangeFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  before: number | undefined,
  after: number | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = query;
  if (before !== undefined) {
    filtered = filtered.whereExists('patient', (patientQuery) => patientQuery.where('createdAt', '<', before));
  }
  if (after !== undefined) {
    filtered = filtered.whereExists('patient', (patientQuery) => patientQuery.where('createdAt', '>', after));
  }
  return filtered;
};

/**
 * Applies extended patient filters (direct contact, created dates, state) for verified order queries.
 */
const applyVerifiedOrderPatientExtendedFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: VerifiedOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = applyPatientFieldFilter(query, 'phone', args.patientPhone);
  filtered = applyPatientFieldFilter(filtered, 'email', args.patientEmail);
  filtered = applyPatientCreatedAtRangeFilter(filtered, args.patientCreatedBefore, args.patientCreatedAfter);
  if (args.patientState !== undefined && args.patientState.length > 0) {
    filtered = filtered.where('state', 'IN', args.patientState);
  }
  return filtered;
};

/**
 * Applies provider company name filter via whereExists for fillOrder queries.
 */
const applyVerifiedOrderProviderCompanyFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  providerCompanyName: TextFilter | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (providerCompanyName === undefined) {
    return query;
  }
  const companyFilter = toZqlStringFilter(providerCompanyName);
  return query.whereExists('providerCompany', (providerCompanyQuery) =>
    providerCompanyQuery.where('name', companyFilter.operator, companyFilter.pattern),
  );
};

/**
 * Applies all patient filters for verified order list queries.
 */
const applyVerifiedOrderPatientFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: VerifiedOrderListFilters,
): Query<'fillOrder', Schema, TReturn> =>
  applyVerifiedOrderPatientExtendedFilters(applyVerifiedOrderPatientCoreFilters(query, args), args);

/**
 * Applies a single prescription field filter via whereExists on a fillOrder query.
 */
const applyPrescriptionFieldFilter = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  column: 'allergyType' | 'medicationName' | 'rxId',
  filter: TextFilter | undefined,
): Query<'fillOrder', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const { operator, pattern } = toZqlStringFilter(filter);
  return query.whereExists('prescription', (prescriptionQuery) => prescriptionQuery.where(column, operator, pattern));
};

/**
 * Applies prescription and prescriber filters for verified order list queries.
 */
const applyVerifiedOrderPrescriptionFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: VerifiedOrderListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = applyPrescriptionFieldFilter(query, 'rxId', args.rxNumber);
  filtered = applyPrescriptionFieldFilter(filtered, 'medicationName', args.drugName);
  return applyFillOrderPrescriberFilters(filtered, args);
};

/**
 * Applies direct field and patient detail filters for patient list queries.
 */
const applyPatientListTextFilters = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  args: PatientListFilters,
): Query<'patient', Schema, TReturn> => {
  let filtered = query;
  for (const [column, filter] of [
    ['readableId', args.readableId],
    ['preferredName', args.patientFilterPreferredName],
    ['email', args.patientFilterEmail],
    ['phone', args.patientFilterPhone],
  ] as const) {
    if (filter !== undefined) {
      const { operator, pattern } = toZqlStringFilter(filter);
      filtered = filtered.where(column, operator, pattern);
    }
  }
  return filtered;
};

const applyPatientListDirectFilters = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  args: PatientListFilters,
): Query<'patient', Schema, TReturn> => {
  let filtered = applyPatientListTextFilters(query, args);
  if (args.createdBefore !== undefined) {
    filtered = filtered.where('createdAt', '<', args.createdBefore);
  }
  if (args.createdAfter !== undefined) {
    filtered = filtered.where('createdAt', '>', args.createdAfter);
  }
  filtered = applyDirectPatientNameOnlyFilter(filtered, args.patientFilterName);
  filtered = applyDateOfBirthFilter(filtered, args.patientFilterDob);
  filtered = applyIsMinorFilter(filtered, args.patientIsMinor);
  return applyContactFilter(filtered, args.contact);
};

/**
 * Applies address field filters within a fillOrder query for patient list queries.
 * All fields must match the same fillOrder.
 */
const applyPatientListAddressFilters = <TReturn>(
  query: Query<'fillOrder', Schema, TReturn>,
  args: PatientListFilters,
): Query<'fillOrder', Schema, TReturn> => {
  let filtered = query;
  for (const [column, filter] of [
    ['addressLine1', args.addressLine1],
    ['addressLine2', args.addressLine2],
    ['addressLine3', args.addressLine3],
    ['city', args.city],
    ['zipcode', args.zipcode],
  ] as const) {
    if (filter !== undefined) {
      const { operator, pattern } = toZqlStringFilter(filter);
      filtered = filtered.where(column, operator, pattern);
    }
  }
  if (args.addressState !== undefined && args.addressState !== '') {
    filtered = filtered.where('state', '=', args.addressState);
  }
  return filtered;
};

/**
 * Applies fillOrder-related filters (fillId, address) for patient list queries.
 */
const applyPatientListFillOrderFilters = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  args: PatientListFilters,
): Query<'patient', Schema, TReturn> => {
  let filtered = query;
  if (args.fillId !== undefined) {
    const fillIdFilter = toZqlStringFilter(args.fillId);
    filtered = filtered.whereExists('fillOrders', (fillOrderQuery) =>
      fillOrderQuery.where('fillId', fillIdFilter.operator, fillIdFilter.pattern),
    );
  }
  const hasAddressFilter =
    args.addressLine1 !== undefined ||
    args.addressLine2 !== undefined ||
    args.addressLine3 !== undefined ||
    args.city !== undefined ||
    args.addressState !== undefined ||
    args.zipcode !== undefined;
  if (hasAddressFilter) {
    filtered = filtered.whereExists('fillOrders', (fillOrderQuery) =>
      applyPatientListAddressFilters(fillOrderQuery, args),
    );
  }
  return filtered;
};

/**
 * Applies physician filters for patient list queries (via prescriptions→physician).
 */
const applyPatientListPhysicianFilters = <TReturn>(
  query: Query<'patient', Schema, TReturn>,
  args: PatientListFilters,
): Query<'patient', Schema, TReturn> => {
  let filtered = applyPhysicianNameOnlyFilterViaRx(query, args.physicianFilterName);
  if (args.physicianFilterNpi !== undefined) {
    const npiFilter = toZqlStringFilter(args.physicianFilterNpi);
    filtered = filtered.whereExists('prescriptions', (prescriptionQuery) =>
      prescriptionQuery.whereExists('physician', (physicianQuery) =>
        physicianQuery.where('npi', npiFilter.operator, npiFilter.pattern),
      ),
    );
  }
  return filtered;
};

/**
 * Applies text and enum field filters for prescription list queries.
 */
const applyPrescriptionListTextFilters = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  args: PrescriptionListFilters,
): Query<'prescription', Schema, TReturn> => {
  let filtered = query;
  if (args.rxId !== undefined) {
    const { operator, pattern } = toZqlStringFilter(args.rxId);
    filtered = filtered.where('rxId', operator, pattern);
  }
  if (args.medicationName !== undefined) {
    const { operator, pattern } = toZqlStringFilter(args.medicationName);
    filtered = filtered.where('medicationName', operator, pattern);
  }
  return filtered;
};

const applyPrescriptionListEnumFilters = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  args: PrescriptionListFilters,
): Query<'prescription', Schema, TReturn> => {
  let filtered = query;
  if (args.productType !== undefined) {
    filtered = filtered.where('productType', '=', args.productType);
  }
  if (args.kind !== undefined) {
    filtered = filtered.where('kind', '=', args.kind);
  }
  return filtered;
};

const applyPrescriptionListNumericFilters = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  args: PrescriptionListFilters,
): Query<'prescription', Schema, TReturn> => {
  let filtered = query;
  if (args.qty !== undefined) {
    filtered = filtered.where('qty', toZqlNumericOperator(args.qty.matchMode), args.qty.value);
  }
  if (args.daysSupply !== undefined) {
    filtered = filtered.where('daysSupply', toZqlNumericOperator(args.daysSupply.matchMode), args.daysSupply.value);
  }
  if (args.authRefills !== undefined) {
    filtered = filtered.where('authRefills', toZqlNumericOperator(args.authRefills.matchMode), args.authRefills.value);
  }
  return filtered;
};

/**
 * Applies all direct field filters for prescription list queries.
 */
const applyPrescriptionListDirectFilters = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  args: PrescriptionListFilters,
): Query<'prescription', Schema, TReturn> => {
  let filtered = applyPrescriptionListNumericFilters(
    applyPrescriptionListEnumFilters(applyPrescriptionListTextFilters(query, args), args),
    args,
  );
  if (args.createdBefore !== undefined) {
    filtered = filtered.where('createdAt', '<', args.createdBefore);
  }
  if (args.createdAfter !== undefined) {
    filtered = filtered.where('createdAt', '>', args.createdAfter);
  }
  if (args.signedBefore !== undefined) {
    filtered = filtered.where('signedAt', '<', args.signedBefore);
  }
  if (args.signedAfter !== undefined) {
    filtered = filtered.where('signedAt', '>', args.signedAfter);
  }
  return filtered;
};

/**
 * Applies a single patient field filter via whereExists on a prescription query.
 */
const applyPrescriptionPatientFieldFilter = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  column: 'email' | 'phone' | 'preferredName',
  filter: TextFilter | undefined,
): Query<'prescription', Schema, TReturn> => {
  if (filter === undefined) {
    return query;
  }
  const { operator, pattern } = toZqlStringFilter(filter);
  return query.whereExists('patient', (patientQuery) => patientQuery.where(column, operator, pattern));
};

/**
 * Applies patient filters for prescription list queries (via patient relation).
 */
const applyPrescriptionListPatientFilters = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  args: PrescriptionListFilters,
): Query<'prescription', Schema, TReturn> => {
  let filtered = applyPrescriptionPatientNameOnlyFilter(query, args.patientFilterName);
  filtered = applyPrescriptionPatientFieldFilter(filtered, 'preferredName', args.patientFilterPreferredName);
  filtered = applyPrescriptionPatientFieldFilter(filtered, 'email', args.patientFilterEmail);
  filtered = applyPrescriptionPatientFieldFilter(filtered, 'phone', args.patientFilterPhone);
  filtered = applyPrescriptionPatientDateOfBirthFilter(filtered, args.patientFilterDob);
  return applyPrescriptionPatientIsMinorFilter(filtered, args.patientIsMinor);
};

/**
 * Applies physician filters for prescription list queries.
 */
const applyPrescriptionListPhysicianFilters = <TReturn>(
  query: Query<'prescription', Schema, TReturn>,
  args: PrescriptionListFilters,
): Query<'prescription', Schema, TReturn> => {
  let filtered = applyPhysicianNameOnlyFilter(query, args.physicianFilterName);
  if (args.physicianFilterNpi !== undefined) {
    const npiFilter = toZqlStringFilter(args.physicianFilterNpi);
    filtered = filtered.whereExists('physician', (physicianQuery) =>
      physicianQuery.where('npi', npiFilter.operator, npiFilter.pattern),
    );
  }
  return filtered;
};

/**
 * Applies text field filters (email, phone) for user list queries.
 */
const applyUserListTextFilters = <TReturn>(
  query: Query<'user', Schema, TReturn>,
  args: UserListFilters,
): Query<'user', Schema, TReturn> => {
  let filtered = query;
  if (args.email !== undefined) {
    const { operator, pattern } = toZqlStringFilter(args.email);
    filtered = filtered.where('email', operator, pattern);
  }
  if (args.phone !== undefined) {
    const { operator, pattern } = toZqlStringFilter(args.phone);
    filtered = filtered.where('phone', operator, pattern);
  }
  return filtered;
};

/**
 * Applies enum and boolean field filters for user list queries.
 */
const applyUserListFieldFilters = <TReturn>(
  query: Query<'user', Schema, TReturn>,
  args: UserListFilters,
): Query<'user', Schema, TReturn> => {
  let filtered = applyUserListTextFilters(query, args);
  if (args.state !== undefined && args.state.length > 0) {
    filtered = filtered.where('state', 'IN', args.state);
  }
  if (args.role !== undefined) {
    filtered = filtered.where('role', '=', args.role);
  }
  if (args.isActive !== undefined) {
    filtered = filtered.where('isActive', '=', args.isActive);
  }
  if (args.isStaff !== undefined) {
    filtered = filtered.where('isStaff', '=', args.isStaff);
  }
  return filtered;
};

/**
 * Applies all direct field filters for user list queries.
 */
const applyUserListCreatedAndJoinedDateFilters = <TReturn>(
  query: Query<'user', Schema, TReturn>,
  args: UserListFilters,
): Query<'user', Schema, TReturn> => {
  let filtered = query;
  if (args.createdBefore !== undefined) {
    filtered = filtered.where('createdAt', '<', args.createdBefore);
  }
  if (args.createdAfter !== undefined) {
    filtered = filtered.where('createdAt', '>', args.createdAfter);
  }
  if (args.dateJoinedBefore !== undefined) {
    filtered = filtered.where('dateJoined', '<', args.dateJoinedBefore);
  }
  if (args.dateJoinedAfter !== undefined) {
    filtered = filtered.where('dateJoined', '>', args.dateJoinedAfter);
  }
  return filtered;
};

const applyUserListLastLoginDateFilters = <TReturn>(
  query: Query<'user', Schema, TReturn>,
  args: UserListFilters,
): Query<'user', Schema, TReturn> => {
  let filtered = query;
  if (args.lastLoginBefore !== undefined) {
    filtered = filtered.where('lastLogin', '<', args.lastLoginBefore);
  }
  if (args.lastLoginAfter !== undefined) {
    filtered = filtered.where('lastLogin', '>', args.lastLoginAfter);
  }
  return filtered;
};

const applyUserListDirectFilters = <TReturn>(
  query: Query<'user', Schema, TReturn>,
  args: UserListFilters,
): Query<'user', Schema, TReturn> =>
  applyUserListLastLoginDateFilters(
    applyUserListCreatedAndJoinedDateFilters(applyUserListFieldFilters(query, args), args),
    args,
  );

/**
 * Applies enum field filters for fax document list queries.
 */
const applyFaxDocumentEnumFilters = <TReturn>(
  query: Query<'faxDocument', Schema, TReturn>,
  args: FaxDocumentListFilters,
): Query<'faxDocument', Schema, TReturn> => {
  let filtered = query;
  if (args.status !== undefined && args.status.length > 0) {
    filtered = filtered.where('status', 'IN', args.status);
  }
  if (args.faxType !== undefined) {
    filtered = filtered.where('faxType', '=', args.faxType);
  }
  if (args.prescriptionKind !== undefined) {
    filtered = filtered.where('prescriptionKind', '=', args.prescriptionKind);
  }
  if (args.sourceType !== undefined) {
    filtered = filtered.where('sourceType', '=', args.sourceType);
  }
  return filtered;
};

/**
 * Applies all direct field filters for fax document list queries.
 */
const applyFaxDocumentTextFilters = <TReturn>(
  query: Query<'faxDocument', Schema, TReturn>,
  args: FaxDocumentListFilters,
): Query<'faxDocument', Schema, TReturn> => {
  let filtered = query;
  if (args.templateFamily !== undefined) {
    const { operator, pattern } = toZqlStringFilter(args.templateFamily);
    filtered = filtered.where('templateFamily', operator, pattern);
  }
  if (args.memo !== undefined) {
    const { operator, pattern } = toZqlStringFilter(args.memo);
    filtered = filtered.where('memo', operator, pattern);
  }
  return filtered;
};

const applyFaxDocumentDateFilters = <TReturn>(
  query: Query<'faxDocument', Schema, TReturn>,
  args: FaxDocumentListFilters,
): Query<'faxDocument', Schema, TReturn> => {
  let filtered = query;
  if (args.receivedBefore !== undefined) {
    filtered = filtered.where('receivedAt', '<', args.receivedBefore);
  }
  if (args.receivedAfter !== undefined) {
    filtered = filtered.where('receivedAt', '>', args.receivedAfter);
  }
  if (args.createdBefore !== undefined) {
    filtered = filtered.where('createdAt', '<', args.createdBefore);
  }
  if (args.createdAfter !== undefined) {
    filtered = filtered.where('createdAt', '>', args.createdAfter);
  }
  return filtered;
};

const applyFaxDocumentDirectFilters = <TReturn>(
  query: Query<'faxDocument', Schema, TReturn>,
  args: FaxDocumentListFilters,
): Query<'faxDocument', Schema, TReturn> =>
  applyFaxDocumentDateFilters(applyFaxDocumentTextFilters(applyFaxDocumentEnumFilters(query, args), args), args);

/**
 * Zero Query Registry - Pre-defined queries using defineQuery/defineQueries.
 *
 * @example
 * ```typescript
 * // Pre-defined queries (pass args as object)
 * const { data: user } = useZeroQuery(() => queries.user.byId({ id: userId.value }));
 *
 * // List with filters
 * const args = computed(() => ({ orderStatus: 'pending', limit: 50 }));
 * const { data: orders } = useZeroQuery(() => queries.fillOrder.list(args.value));
 * ```
 * @see https://zero.rocicorp.dev/docs/queries
 */
const queries = defineQueries({
  company: {
    allActive: defineQuery(() => builder.company.where('isActive', '=', true).orderBy('name', 'asc')),
  },

  faxDocument: {
    byId: defineQuery(({ args }: IdArgs) =>
      builder.faxDocument.where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID).one(),
    ),
    byIdWithPages: defineQuery(({ args }: IdArgs) =>
      builder.faxDocument
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('faxDocumentPages', withFaxDocumentPagesOrdered)
        .one(),
    ),
    byIdWithFullDetails: defineQuery(({ args }: IdArgs) =>
      builder.faxDocument
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('faxDocumentPages', withFaxDocumentPagesOrdered)
        .related('providerCompany')
        .related('pharmacyCompany')
        .related('prescription')
        .related('order')
        .related('reviewedBy')
        .one(),
    ),

    /**
     * List query with filtering, sorting, and pagination.
     */
    list: defineQuery(({ args }: FaxDocumentListArgs) => {
      let query = applyFaxDocumentDirectFilters(builder.faxDocument, args);
      query = applyFaxDocumentGlobalSearch(query, args.globalSearch);

      query = query.orderBy(args.sortField, args.sortOrder).limit(args.limit);
      if (hasCursorRow(args.startRow)) {
        query = query.start(extractFaxDocumentCursor(args.startRow));
      }

      return query.related('prescription', (prescriptionQuery) => prescriptionQuery.related('fillOrders'));
    }),
  },

  fillOrder: {
    byId: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder.where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID).one(),
    ),
    byIdWithPatient: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('patient')
        .one(),
    ),
    byIdWithVerifiedBy: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('verifiedBy')
        .one(),
    ),
    byIdWithPrescription: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('prescription')
        .one(),
    ),
    byIdWithPrescriptionFaxDocuments: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('prescription', (prescriptionQuery) =>
          prescriptionQuery.related('faxDocuments', (faxDocumentQuery) =>
            faxDocumentQuery.orderBy('receivedAt', 'desc').related('faxDocumentPages', withFaxDocumentPagesOrdered),
          ),
        )
        .one(),
    ),
    byIdWithPrescriptionPhysician: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('prescription', (prescriptionQuery) => prescriptionQuery.related('physician'))
        .one(),
    ),
    byIdWithPatientGuardian: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('patient', (patientQuery) =>
          patientQuery.related('patientGuardians', (guardianQuery) => guardianQuery.one()),
        )
        .one(),
    ),
    byIdWithShipments: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('shipments', (shipmentQuery) =>
          shipmentQuery
            .orderBy('createdAt', 'desc')
            .related('shipmentLabels', (shipmentLabelQuery) => shipmentLabelQuery.orderBy('createdAt', 'desc')),
        )
        .one(),
    ),
    byIdWithStatusEvents: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('fillOrderStatusEvents', (statusEventQuery) =>
          statusEventQuery.related('user').orderBy('createdAt', 'desc'),
        )
        .one(),
    ),
    byIdWithNotes: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('orderNotes', (orderNoteQuery) => orderNoteQuery.related('user').orderBy('createdAt', 'desc'))
        .one(),
    ),
    byIdWithIngredients: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('fillOrderIngredients', (ingredientQuery) =>
          ingredientQuery.related('inventory', (inventoryQuery) =>
            // eslint-disable-next-line max-nested-callbacks -- Zero requires 4 levels: fillOrderIngredient → inventory → ingredient → ingredientMaps
            inventoryQuery.related('ingredient', (ingredientEntityQuery) =>
              ingredientEntityQuery.related('ingredientMaps'),
            ),
          ),
        )
        .one(),
    ),
    byIdWithFullDetails: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('prescription', (prescriptionQuery) =>
          prescriptionQuery
            .related('physician')
            .related('faxDocuments', (faxDocumentQuery) =>
              faxDocumentQuery.orderBy('receivedAt', 'desc').related('faxDocumentPages', withFaxDocumentPagesOrdered),
            ),
        )
        .related('patient', (patientQuery) =>
          patientQuery.related('patientGuardians', (guardianQuery) => guardianQuery.one()),
        )
        .related('shipments', (shipmentQuery) => shipmentQuery.orderBy('createdAt', 'desc').related('shipmentLabels'))
        .related('verifiedBy')
        .related('lockedBy')
        .related('fillOrderStatusEvents', (statusEventQuery) =>
          statusEventQuery.related('user').orderBy('createdAt', 'desc'),
        )
        .one(),
    ),
    byIdWithPatientOrders: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('patient', (patientQuery) =>
          patientQuery.related('fillOrders', (fillOrderQuery) =>
            fillOrderQuery.orderBy('createdAt', 'desc').limit(50).related('prescription'),
          ),
        )
        .one(),
    ),
    byIdWithPatientPrescriptions: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('prescription')
        .related('patient', (patientQuery) =>
          patientQuery.related('prescriptions', (prescriptionsQuery) =>
            prescriptionsQuery
              .orderBy('createdAt', 'desc')
              .limit(50)
              .related('physician')
              // eslint-disable-next-line max-nested-callbacks -- Zero requires 4 levels: patient → prescriptions → fillOrders
              .related('fillOrders', (ordersQuery) => ordersQuery.orderBy('createdAt', 'desc').one()),
          ),
        )
        .one(),
    ),
    byIdWithProviderCompany: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('providerCompany')
        .one(),
    ),
    byIdWithIngredientHistory: defineQuery(({ args }: IdArgs) =>
      builder.fillOrder
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('fillOrderIngredients', (ingredientQuery) =>
          ingredientQuery
            .related('inventory', (inventoryQuery) => inventoryQuery.related('ingredient'))
            .related('fillOrderIngredientEvents', (ingredientEventQuery) =>
              ingredientEventQuery.related('user').related('inventory').orderBy('createdAt', 'desc'),
            ),
        )
        .one(),
    ),
    byFillIdWithPatientAndPrescription: defineQuery(({ args }: FillIdArgs) =>
      builder.fillOrder
        .where('fillId', '=', args.fillId !== '' ? args.fillId : FALLBACK_QUERY_ID)
        .related('patient', (patientQuery) =>
          patientQuery.related('patientGuardians', (guardianQuery) => guardianQuery.one()),
        )
        .related('prescription')
        .one(),
    ),
    byIdsWithPatientAndPrescription: defineQuery(({ args }: IdsArgs) =>
      builder.fillOrder
        .where('id', 'IN', args.ids)
        .related('patient', (patientQuery) =>
          patientQuery.related('patientGuardians', (guardianQuery) => guardianQuery.one()),
        )
        .related('prescription'),
    ),

    /**
     * List query with filtering, sorting, and pagination.
     * All filter args are optional - only non-undefined values are applied.
     *
     * @example
     * ```typescript
     * const args = computed(() => ({
     *   fillId: extractedFilters.fillId,
     *   orderStatus: extractedFilters.orderStatus,
     *   globalSearch: filters.value.global?.value,
     *   sortField: 'createdAt',
     *   sortOrder: 'desc',
     *   limit: 51,
     * }));
     * const { data, status, error } = useZeroQuery(() => queries.fillOrder.list(args.value));
     * ```
     */
    list: defineQuery(({ args }: FillOrderListArgs) => {
      let query = applyFillOrderPatientFieldFilters(
        applyFillOrderDirectFilters(
          builder.fillOrder.where('isActive', '=', true).where('deletedAt', 'IS', null),
          args,
        ),
        args,
      );
      query = applyVerifiedByNameFilter(applyPharmacistNameFilter(query, args.pharmacistName), args.verifiedByName);
      query = applyFillOrderPrescriberFilters(query, args);
      query = applyGlobalSearchFilter(query, args.globalSearch, args.globalSearchFormattedDob);
      query = applyFillOrderShipmentFilters(query, args);
      query = applyPrescriptionFieldFilter(query, 'allergyType', args.allergyType);

      query = query.orderBy(args.sortField, args.sortOrder).limit(args.limit);
      if (hasCursorRow(args.startRow)) {
        query = query.start(extractFillOrderCursor(args.startRow));
      }

      return query
        .related('patient')
        .related('pharmacist')
        .related('verifiedBy')
        .related('lockedBy')
        .related('prescription', (prescriptionQuery) => prescriptionQuery.related('physician'))
        .related('shipments', (shipmentQuery) =>
          shipmentQuery.related('shipmentLabels', (shipmentLabelQuery) =>
            shipmentLabelQuery.orderBy('createdAt', 'desc'),
          ),
        );
    }),

    /**
     * Verified orders list query with date range and filtering.
     */
    verifiedList: defineQuery(({ args }: VerifiedOrderListArgs) => {
      let query = applyVerifiedOrderPatientFilters(
        applyVerifiedOrderDirectFilters(
          builder.fillOrder.where('isActive', '=', true).where('deletedAt', 'IS', null),
          args,
        ),
        args,
      );
      query = applyVerifiedByNameFilter(query, args.verifiedByName);
      query = applyVerifiedOrderProviderCompanyFilter(query, args.providerCompanyName);
      query = applyVerifiedOrderPrescriptionFilters(query, args);
      query = applyGlobalSearchFilter(query, args.globalSearch, args.globalSearchFormattedDob);

      query = query.orderBy(args.sortField, args.sortOrder).limit(args.limit);
      if (hasCursorRow(args.startRow)) {
        query = query.start(extractFillOrderCursor(args.startRow));
      }

      return query
        .related('patient')
        .related('verifiedBy')
        .related('providerCompany')
        .related('prescription', (prescriptionQuery) => prescriptionQuery.related('physician'));
    }),
  },

  fillOrderIngredient: {
    byOrderId: defineQuery(({ args }: OrderIdArgs) =>
      builder.fillOrderIngredient
        .where('orderId', '=', args.orderId !== '' ? args.orderId : FALLBACK_QUERY_ID)
        .where('isActive', '=', true)
        .related('inventory', (inventoryQuery) => inventoryQuery.related('ingredient'))
        .orderBy('ingredientOrder', 'asc'),
    ),
    eventsById: defineQuery(({ args }: IngredientIdArgs) =>
      builder.fillOrderIngredientEvent
        .where('fillOrderIngredientId', '=', args.ingredientId !== '' ? args.ingredientId : FALLBACK_QUERY_ID)
        .related('user')
        .orderBy('createdAt', 'desc'),
    ),
  },

  ingredientMap: {
    byIngredientId: defineQuery(({ args }: IngredientIdArgs) =>
      builder.ingredientMap
        .where('ingredientId', '=', args.ingredientId !== '' ? args.ingredientId : FALLBACK_QUERY_ID)
        .where('isActive', '=', true)
        .related('ingredient')
        .related('providerCompany')
        .related('pharmacyCompany')
        .orderBy('createdAt', 'desc'),
    ),
  },

  inventory: {
    activeWithIngredients: defineQuery(() => builder.inventory.where('isActive', '=', true).related('ingredient')),
  },

  orderDocument: {
    byNoteId: defineQuery(({ args }: NoteIdArgs) =>
      builder.orderDocument
        .where('noteId', '=', args.noteId !== '' ? args.noteId : FALLBACK_QUERY_ID)
        .where('isActive', '=', true)
        .orderBy('createdAt', 'desc'),
    ),
  },

  orderNote: {
    byIdWithUser: defineQuery(({ args }: IdArgs) =>
      builder.orderNote
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('user')
        .one(),
    ),
    byFillOrderId: defineQuery(({ args }: FillOrderIdArgs) =>
      builder.orderNote
        .where('fillOrderId', '=', args.fillOrderId !== '' ? args.fillOrderId : FALLBACK_QUERY_ID)
        .where('isActive', '=', true)
        .related('user')
        .orderBy('createdAt', 'desc'),
    ),
  },

  patient: {
    byId: defineQuery(({ args }: IdArgs) =>
      builder.patient.where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID).one(),
    ),
    byIdWithGuardians: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('patientGuardians')
        .one(),
    ),
    byIdWithGuardian: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('patientGuardians', (guardianQuery) => guardianQuery.one())
        .one(),
    ),
    byIdWithFillOrders: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('fillOrders', (fillOrderQuery) =>
          fillOrderQuery.orderBy('createdAt', 'desc').limit(50).related('prescription'),
        )
        .one(),
    ),
    byIdWithPrescriptions: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('prescriptions', (prescriptionsQuery) =>
          prescriptionsQuery
            .orderBy('createdAt', 'desc')
            .limit(50)
            .related('physician')
            .related('fillOrders', (ordersQuery) => ordersQuery.orderBy('createdAt', 'desc').one()),
        )
        .one(),
    ),
    byIdWithNotes: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('patientNotes', (notesQuery) =>
          notesQuery.where('isActive', '=', true).related('user').orderBy('createdAt', 'desc'),
        )
        .one(),
    ),
    byIdWithDocuments: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('patientDocuments', (documentsQuery) =>
          documentsQuery.orderBy('createdAt', 'desc').limit(100).related('user'),
        )
        .one(),
    ),
    byIdWithSystemEvents: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('systemEvents', (eventsQuery) =>
          eventsQuery.orderBy('createdAt', 'desc').limit(100).related('initiatedBy'),
        )
        .one(),
    ),
    byIdWithCompanies: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('pharmacyCompany')
        .related('providerCompany')
        .one(),
    ),
    byIdWithShipments: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('fillOrders', (fillOrderQuery) =>
          fillOrderQuery
            .orderBy('createdAt', 'desc')
            .related('shipments', (shipmentQuery) => shipmentQuery.orderBy('createdAt', 'desc').limit(50)),
        )
        .one(),
    ),
    byIdWithTransactions: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('fillOrders', (fillOrderQuery) =>
          fillOrderQuery
            .orderBy('createdAt', 'desc')
            .related('transactions', (transactionQuery) =>
              transactionQuery.orderBy('createdAt', 'desc').limit(50).related('createdBy'),
            ),
        )
        .one(),
    ),
    byIdWithFaxDocuments: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('fillOrders', (fillOrderQuery) =>
          fillOrderQuery
            .orderBy('createdAt', 'desc')
            .related('faxDocuments', (faxDocumentQuery) => faxDocumentQuery.orderBy('createdAt', 'desc').limit(50)),
        )
        .one(),
    ),
    byIdWithStatusEvents: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('fillOrders', (fillOrderQuery) =>
          fillOrderQuery
            .orderBy('createdAt', 'desc')
            .related('fillOrderStatusEvents', (statusEventQuery) =>
              statusEventQuery.orderBy('createdAt', 'desc').related('user'),
            ),
        )
        .one(),
    ),
    byIdWithPhysicians: defineQuery(({ args }: IdArgs) =>
      builder.patient
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('prescriptions', (prescriptionQuery) =>
          prescriptionQuery.orderBy('createdAt', 'desc').related('physician'),
        )
        .one(),
    ),

    /**
     * List query with filtering, sorting, and pagination.
     */
    list: defineQuery(({ args }: PatientListArgs) => {
      let query = applyPatientListDirectFilters(builder.patient, args);
      query = applyPatientListFillOrderFilters(query, args);
      query = applyPatientListPhysicianFilters(query, args);
      query = applyPatientGlobalSearch(query, args.globalSearch, args.globalSearchFormattedDob);

      query = query.orderBy(args.sortField, args.sortOrder).limit(args.limit);
      if (hasCursorRow(args.startRow)) {
        query = query.start(extractPatientCursor(args.startRow));
      }

      const withShipmentLabels = (shipmentQuery: typeof builder.shipment) =>
        shipmentQuery
          .orderBy('createdAt', 'desc')
          .related('shipmentLabels', (shipmentLabelQuery) => shipmentLabelQuery.orderBy('createdAt', 'desc'));

      return query
        .related('prescriptions', (prescriptionQuery) =>
          prescriptionQuery.related('physician').orderBy('createdAt', 'desc'),
        )
        .related('fillOrders', (fillOrderQuery) =>
          fillOrderQuery.orderBy('createdAt', 'desc').related('shipments', withShipmentLabels),
        );
    }),

    /**
     * Lightweight list query for inline patient assignment.
     * Only loads providerCompany relation — no prescriptions, fillOrders, or shipments.
     */
    assignmentList: defineQuery(({ args }: PatientAssignmentListArgs) => {
      let query = builder.patient;

      if (args.patientFilterFirstName !== undefined) {
        const { operator, pattern } = toZqlStringFilter(args.patientFilterFirstName);
        query = query.where('firstName', operator, pattern);
      }
      if (args.patientFilterLastName !== undefined) {
        const { operator, pattern } = toZqlStringFilter(args.patientFilterLastName);
        query = query.where('lastName', operator, pattern);
      }
      query = applyDateOfBirthFilter(query, args.patientFilterDob);

      return query.orderBy('lastName', 'asc').limit(args.limit).related('providerCompany');
    }),
  },

  patientDocument: {
    byNoteId: defineQuery(({ args }: NoteIdArgs) =>
      builder.patientDocument
        .where('noteId', '=', args.noteId !== '' ? args.noteId : FALLBACK_QUERY_ID)
        .where('isActive', '=', true)
        .orderBy('createdAt', 'desc'),
    ),
  },

  patientNote: {
    byIdWithUser: defineQuery(({ args }: IdArgs) =>
      builder.patientNote
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('user')
        .one(),
    ),
    byPatientId: defineQuery(({ args }: PatientIdArgs) =>
      builder.patientNote
        .where('patientId', '=', args.patientId !== '' ? args.patientId : FALLBACK_QUERY_ID)
        .where('isActive', '=', true)
        .related('user')
        .orderBy('createdAt', 'desc'),
    ),
  },

  prescription: {
    byId: defineQuery(({ args }: IdArgs) =>
      builder.prescription.where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID).one(),
    ),
    byIdWithPhysician: defineQuery(({ args }: IdArgs) =>
      builder.prescription
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('physician')
        .one(),
    ),

    /**
     * List query with filtering, sorting, and pagination.
     */
    list: defineQuery(({ args }: PrescriptionListArgs) => {
      let query = applyPrescriptionListDirectFilters(builder.prescription, args);
      query = applyPrescriptionListPatientFilters(query, args);
      query = applyPrescriptionListPhysicianFilters(query, args);
      query = applyPrescriptionGlobalSearch(query, args.globalSearch, args.globalSearchFormattedDob);

      query = query.orderBy(args.sortField, args.sortOrder).limit(args.limit);
      if (hasCursorRow(args.startRow)) {
        query = query.start(extractPrescriptionCursor(args.startRow));
      }

      return query.related('patient').related('physician');
    }),
  },

  shipment: {
    byOrderId: defineQuery(({ args }: OrderIdArgs) =>
      builder.shipment
        .where('orderId', '=', args.orderId !== '' ? args.orderId : FALLBACK_QUERY_ID)
        .related('shipmentLabels', (shipmentLabelQuery) => shipmentLabelQuery.orderBy('createdAt', 'desc'))
        .orderBy('createdAt', 'desc'),
    ),
    byIdWithLabelsAndProblems: defineQuery(({ args }: IdArgs) =>
      builder.shipment
        .where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID)
        .related('shipmentLabels', (shipmentLabelQuery) => shipmentLabelQuery.orderBy('createdAt', 'desc'))
        .related('shipmentProblems', (shipmentProblemQuery) => shipmentProblemQuery.orderBy('createdAt', 'desc'))
        .one(),
    ),
  },

  user: {
    byId: defineQuery(({ args }: IdArgs) =>
      builder.user.where('id', '=', args.id !== '' ? args.id : FALLBACK_QUERY_ID).one(),
    ),
    allActive: defineQuery(() => builder.user.where('isActive', '=', true).orderBy('lastName', 'asc')),

    /**
     * List query with filtering, sorting, and pagination.
     */
    list: defineQuery(({ args }: UserListArgs) => {
      let query = applyUserListDirectFilters(builder.user, args);
      query = applyDirectUserNameFilter(query, args.userName);
      query = applyUserGlobalSearch(query, args.globalSearch);

      query = query.orderBy(args.sortField, args.sortOrder).limit(args.limit);
      if (hasCursorRow(args.startRow)) {
        query = query.start(extractUserCursor(args.startRow));
      }

      return query;
    }),
  },
});

export { builder, queries };
export type {
  FaxDocumentListFilters,
  FillOrderListFilters,
  NumericFilter,
  NumericMatchMode,
  PatientAssignmentListFilters,
  PatientListFilters,
  PrescriptionListFilters,
  TextFilter,
  TextMatchMode,
  UserListFilters,
  VerifiedOrderListFilters,
};
