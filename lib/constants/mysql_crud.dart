const updateShippedDate = '''
UPDATE valid_order
SET shipped_date = ?
WHERE reference_no = ?
''';

const updateAssigner = '''
UPDATE valid_order
SET assigner = ?
WHERE reference_no = ?
''';

const allArticles = '''
SELECT id, article_no, EAN, model, path From article
WHERE STATUS = 'STD'
''';

const allOrder = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, shipped_date, assigner, article_id, article_no, EAN, model, path  
FROM valid_order
LEFT JOIN article ON article.id = article_id
''';

const todayOrder = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, shipped_date, assigner, article_id, article_no, EAN, model, path  
FROM valid_order
LEFT JOIN article ON article.id = article_id
WHERE created_date = CURRENT_DATE
''';

const allProcessingOrder = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, shipped_date, assigner, article_id, article_no, EAN, model, path  
FROM valid_order
LEFT JOIN article ON article.id = article_id
WHERE assigner IS null AND shipped_date IS null
''';

const processingOrderBetween = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, shipped_date, assigner, article_id, article_no, EAN, model, path  
FROM valid_order
LEFT JOIN article ON article.id = article_id
WHERE assigner IS null AND shipped_date IS null AND created_date between ? AND ?
''';

const scannedOrderBetween = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, shipped_date, assigner, article_id, article_no, EAN, model, path  
FROM valid_order
LEFT JOIN article ON article.id = article_id
WHERE assigner IS NOT null AND shipped_date IS null AND created_date between ? AND ?
''';

const shippedOrderBetween = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, shipped_date, assigner, article_id, article_no, EAN, model, path  
FROM valid_order
LEFT JOIN article ON article.id = article_id
WHERE assigner IS NOT null AND shipped_date IS NOT null AND created_date between ? AND ?
''';

// const orderOn =
//     '''SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, order_table.status, scanned_by, packed_by, article_id, article_no, EAN, model, path  FROM (SELECT *
// FROM valid_order
// LEFT JOIN (SELECT reference_no, assigner AS packed_by FROM packed_by) AS a USING(reference_no)
// LEFT JOIN (SELECT reference_no, assigner AS scanned_by FROM scanned_by) AS b USING(reference_no)
// WHERE valid_order.created_date = ?) AS order_table
// LEFT JOIN article ON article.id = order_table.article_id''';

const orderBetween = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, shipped_date, assigner, article_id, article_no, EAN, model, path  
FROM valid_order
LEFT JOIN article ON article.id = article_id
WHERE created_date between ? AND ?
''';
// const orderBetweenWithStatus = '''
// SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, assigner, shipped_date , article_id, article_no, EAN, model, path  FROM (SELECT *
// FROM valid_order
// LEFT JOIN (SELECT reference_no, date AS shipped_date FROM shipped) AS a USING(reference_no)
// LEFT JOIN (SELECT reference_no, assigner AS assigner FROM scanned) AS b USING(reference_no)
// WHERE valid_order.created_date between ? AND ?) AS order_table
// LEFT JOIN article ON article.id = order_table.article_id
// WHERE order_table.status = ?
// ''';

const orderByEan = '''
SELECT reference_no
FROM valid_order
WHERE article_id in (SELECT id FROM article WHERE EAN = ?)
''';

const orderByReferenceNo = '''
SELECT reference_no, created_date, quantity, tracking_no, shipped_to, path_cn23, shipped_date, assigner, article_id, article_no, EAN, model, path  
FROM valid_order
LEFT JOIN article ON article.id = article_id
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
const shippedDateColumn = 'shipped_date';
const assignerColumn = 'assigner';
const createdDateColumn = 'created_date';
