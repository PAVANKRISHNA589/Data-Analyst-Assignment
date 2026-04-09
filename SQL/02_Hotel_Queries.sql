/* Q1) For every user, get the user_id and last booked room_no*/

SELECT user_id, room_no
FROM (
    SELECT 
        user_id,
        room_no,
        booking_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id 
            ORDER BY booking_date DESC
        ) AS rn
    FROM bookings
) AS ranked_bookings
WHERE rn = 1;



/* Q2) Get booking_id and total billing amount of every booking created in November 2021*/

SELECT 
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM bookings b
JOIN booking_commercials bc 
    ON b.booking_id = bc.booking_id
JOIN items i 
    ON bc.item_id = i.item_id
WHERE b.booking_date BETWEEN '2021-11-01' AND '2021-11-30'
GROUP BY b.booking_id;



/* Q3) Get bill_id and bill amount of all bills raised in  October 2021 having bill amount > 1000 */

SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i 
    ON bc.item_id = i.item_id
WHERE bc.bill_date BETWEEN '2021-10-01' AND '2021-10-31'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;



/* Q4) Determine the most ordered and least ordered item of each month of year 2021 */

WITH item_orders AS (
    SELECT 
        EXTRACT(MONTH FROM bill_date) AS month,
        item_id,
        SUM(item_quantity) AS total_quantity
    FROM booking_commercials
    WHERE EXTRACT(YEAR FROM bill_date) = 2021
    GROUP BY EXTRACT(MONTH FROM bill_date), item_id
),
ranked_items AS (
    SELECT 
        month,
        item_id,
        total_quantity,
        RANK() OVER (
            PARTITION BY month 
            ORDER BY total_quantity DESC
        ) AS most_ordered_rank,
        RANK() OVER (
            PARTITION BY month 
            ORDER BY total_quantity ASC
        ) AS least_ordered_rank
    FROM item_orders
)
SELECT 
    month,
    item_id,
    total_quantity,
    most_ordered_rank,
    least_ordered_rank
FROM ranked_items
WHERE most_ordered_rank = 1 
   OR least_ordered_rank = 1
ORDER BY month;



/* Q5) Find the customers with the second highest bill value of each month of year 2021*/

WITH bill_totals AS (
    SELECT 
        bc.bill_id,
        EXTRACT(MONTH FROM bc.bill_date) AS month,
        SUM(bc.item_quantity * i.item_rate) AS total_amount
    FROM booking_commercials bc
    JOIN items i 
        ON bc.item_id = i.item_id
    WHERE EXTRACT(YEAR FROM bc.bill_date) = 2021
    GROUP BY bc.bill_id, EXTRACT(MONTH FROM bc.bill_date)
),
ranked_bills AS (
    SELECT 
        bill_id,
        month,
        total_amount,
        DENSE_RANK() OVER (
            PARTITION BY month 
            ORDER BY total_amount DESC
        ) AS rank_position
    FROM bill_totals
)
SELECT 
    bill_id,
    month,
    total_amount
FROM ranked_bills
WHERE rank_position = 2
ORDER BY month;
