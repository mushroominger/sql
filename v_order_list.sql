CREATE VIEW v_order_list AS
SELECT
orders.order_no 注文番号,
orders.order_date 受注日,
orders.client_cd 顧客コード,
clients.client_name 顧客名,
orders.staff_cd 担当者コード,
staffs.staff_name 担当者名,
order_detail.item_cd 商品コード,
items.item_name 商品名,
items.unit_price 商品単価,
order_detail.order_quantity 注文数,
items.unit_price * order_detail.order_quantity 小計,
(
    SELECT
    SUM(items.unit_price * order_detail.order_quantity)
    FROM order_detail
    JOIN items
    USING(item_cd)
    /* ON order_detail.item_cd = items.item_cd */
    WHERE orders.order_no = order_detail.order_no
) 注文合計
FROM orders
JOIN order_detail
ON orders.order_no = order_detail.order_no
JOIN clients
ON orders.clientcd = clients.client_cd
JOIN staffs
ON orders.staff_cd = staffs.staff_cd
JOIN items
ON order_detail.item_cd = items.item_cd