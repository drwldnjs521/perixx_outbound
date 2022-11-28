const createShippedTable = '''CREATE TABLE IF NOT EXISTS shipped (
                id	bigint NOT NULL,
                reference_no	varchar(255)	NOT NULL UNIQUE,
                date Date NOT NULL,
                PRIMARY KEY (id),
                FOREIGN KEY (reference_no) REFERENCES valid_order(reference_no)
              );''';
const createScannedTable = '''CREATE TABLE IF NOT EXISTS scanned (
                id	bigint NOT NULL,
                reference_no	varchar(255)	 NOT NULL UNIQUE,
                assigner varchar(255) NOT NULL,
                PRIMARY KEY (id),
                FOREIGN KEY (reference_no) REFERENCES valid_order(reference_no)
              );''';

// const orderToday =
//     '''SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, order_table.status, scanned_by, packed_by, article_id, article_no, EAN, model, path  FROM (SELECT *
// FROM valid_order
// LEFT JOIN (SELECT reference_no, assigner AS packed_by FROM packed_by) AS a USING(reference_no)
// LEFT JOIN (SELECT reference_no, assigner AS scanned_by FROM scanned_by) AS b USING(reference_no)
// WHERE valid_order.created_date = ?) AS order_table
// LEFT JOIN article ON article.id = order_table.article_id''';

// const orderOn =
//     '''SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, order_table.status, scanned_by, packed_by, article_id, article_no, EAN, model, path  FROM (SELECT *
// FROM valid_order
// LEFT JOIN (SELECT reference_no, assigner AS packed_by FROM packed_by) AS a USING(reference_no)
// LEFT JOIN (SELECT reference_no, assigner AS scanned_by FROM scanned_by) AS b USING(reference_no)
// WHERE valid_order.created_date = ?) AS order_table
// LEFT JOIN article ON article.id = order_table.article_id''';
const orderBetween = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, order_table.status, scanned, shipped, article_id, article_no, EAN, model, path  FROM (SELECT *
FROM valid_order
LEFT JOIN (SELECT reference_no, date AS shipped FROM shipped) AS a USING(reference_no)
LEFT JOIN (SELECT reference_no, assigner AS scanned FROM scanned) AS b USING(reference_no)
WHERE valid_order.created_date between ? AND ?) AS order_table
LEFT JOIN article ON article.id = order_table.article_id
''';
const orderBetweenWithStatus = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, order_table.status, scanned, shipped, article_id, article_no, EAN, model, path  FROM (SELECT *
FROM valid_order
LEFT JOIN (SELECT reference_no, date AS shipped FROM shipped) AS a USING(reference_no)
LEFT JOIN (SELECT reference_no, assigner AS scanned FROM scanned) AS b USING(reference_no)
WHERE valid_order.created_date between ? AND ?) AS order_table
LEFT JOIN article ON article.id = order_table.article_id
WHERE order_table.status = ?
''';

const orderByEan = '''
SELECT reference_no
FROM valid_order
WHERE article_id in (SELECT id FROM article WHERE EAN = ?)
''';

const orderByReferenceNo = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, valid_order.status, article_id, article_no, EAN, model, path
FROM valid_order
LEFT JOIN article ON article.id = valid_order.article_id
WHERE reference_no = ?
''';

const articleTable = 'article';
const orderTable = 'valid_order';
const idColumn = 'id';
const articleNoColumn = 'article_no';
const eanColumn = 'EAN';
const modelColumn = 'model';
const imageColumn = 'path';
const orderNoColumn = 'reference_no';
const statusColumn = 'status';
const articleIdColumn = 'article_id';
const qtyColumn = 'quantity';
const labelNoColumn = 'tracking_no';
const shippedToColumn = 'shipped_to';
const cn23Column = 'path_cn23';
const shippedColumn = 'shipped';
const scannedColumn = 'scanned';
const createdDateColumn = 'created_date';
