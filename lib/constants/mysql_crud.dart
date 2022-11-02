const createShippedByTable = '''CREATE TABLE IF NOT EXISTS "shipped_by" (
                "id"	INTEGER NOT NULL,
                "order_id"	INTEGER NOT NULL UNIQUE,
                "assigner" TEXT NOT NULL,
                PRIMARY KEY("id" AUTOINCREMENT),
                FOREIGN KEY("order_id") REFERENCES "ValidOrder"("id"),
              );''';
const createScannedByTable = '''CREATE TABLE IF NOT EXISTS "scanned_by" (
                "id"	INTEGER NOT NULL,
                "order_id"	INTEGER NOT NULL UNIQUE,
                "assigner" TEXT NOT NULL,
                PRIMARY KEY("id" AUTOINCREMENT),
                FOREIGN KEY("user_id") REFERENCES "ValidOrder"("id"),
              );''';
const articleTable = 'article';
const orderTable = 'valid_order';
const idColumn = 'id';
const articleNoColumn = 'article_no';
const eanColumn = 'EAN';
const modelColumn = 'model';
const imageColumn = 'path';
const orderNoColumn = '';
const invoiceLinkColumn = '';
const statusColumn = '';
const articleIdColumn = '';
const qtyColumn = '';
const labelNoColumn = '';
const labelLinkColumn = '';
const shippedToColumn = '';
const cn23Column = '';
const cn23LinkColumn = '';
