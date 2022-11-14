const createShippedByTable = '''CREATE TABLE IF NOT EXISTS shipped_by (
                id	bigint NOT NULL,
                order_id	varchar(255)	 NOT NULL UNIQUE,
                assigner varchar(255) NOT NULL,
                PRIMARY KEY (id),
                FOREIGN KEY (order_id) REFERENCES valid_order(reference_no)
              );''';
const createScannedByTable = '''CREATE TABLE IF NOT EXISTS scanned_by (
                id	bigint NOT NULL,
                order_id	varchar(255)	 NOT NULL UNIQUE,
                assigner varchar(255) NOT NULL,
                PRIMARY KEY (id),
                FOREIGN KEY (order_id) REFERENCES valid_order(reference_no)
              );''';

const orderToday = '''SELECT * FROM (SELECT *
FROM valid_order
LEFT JOIN (SELECT reference_no, assigner AS packed_by FROM packed_by) AS a USING(reference_no)
LEFT JOIN (SELECT reference_no, assigner AS scanned_by FROM scanned_by) AS b USING(reference_no)
WHERE valid_order.created_date = ?) AS order_table
LEFT JOIN article ON article.id = order_table.article_id''';

const orderOn = '''SELECT * FROM (SELECT *
FROM valid_order
LEFT JOIN (SELECT reference_no, assigner AS packed_by FROM packed_by) AS a USING(reference_no)
LEFT JOIN (SELECT reference_no, assigner AS scanned_by FROM scanned_by) AS b USING(reference_no)
WHERE valid_order.created_date = ?) AS order_table
LEFT JOIN article ON article.id = order_table.article_id''';

const orderBetween = '''
SELECT * FROM (SELECT *
FROM valid_order
LEFT JOIN (SELECT reference_no, assigner AS packed_by FROM packed_by) AS a USING(reference_no)
LEFT JOIN (SELECT reference_no, assigner AS scanned_by FROM scanned_by) AS b USING(reference_no)
WHERE valid_order.created_date between ? AND ?) AS order_table
LEFT JOIN article ON article.id = order_table.article_id
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
const packedByColumn = 'packed_by';
const scannedByColumn = 'scanned_by';
