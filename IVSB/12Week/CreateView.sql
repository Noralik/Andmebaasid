-- //////////////////////////////////////////////////////////////
-- 2.1 Create view: payment ratio for every booking

/* CREATE OR REPLACE VIEW booking_payment_ratio AS
SELECT
    b.booking_id,
    b.guest_id,
    b.total_cost,
    COALESCE(SUM(p.paid_sum), 0) AS total_paid,
    CASE
        WHEN b.total_cost = 0 THEN 1
        ELSE COALESCE(SUM(p.paid_sum), 0) / b.total_cost
    END AS payment_ratio
FROM Booking b
LEFT JOIN Payment p
    ON b.booking_id = p.booking_id
GROUP BY
    b.booking_id,
    b.guest_id,
    b.total_cost;
*/ 
-- //////////////////////////////////////////////////////////////

-- 2.2 Create function: guest trustworthiness
-- NOTE: Function cannot be created because of MySQL server permissions.
-- Error 1419: log_bin_trust_function_creators is OFF.

-- //////////////////////////////////////////////////////////////

-- 2.3 Show guest name and trustworthiness
-- Alternative SELECT because function cannot be created

SELECT
    g.name,
    CASE
        WHEN SUM(bpr.payment_ratio > 0 AND bpr.payment_ratio < 1) > 5
             OR SUM(bpr.payment_ratio = 0) > 1
            THEN 'BAD'

        WHEN SUM(bpr.payment_ratio > 0 AND bpr.payment_ratio < 1) > 2
             OR SUM(bpr.payment_ratio = 0) > 0
            THEN 'FINE'

        ELSE 'GOOD'
    END AS trustworthiness
FROM Guest g
LEFT JOIN booking_payment_ratio bpr
    ON g.guest_id = bpr.guest_id
GROUP BY g.guest_id, g.name
ORDER BY
    CASE trustworthiness
        WHEN 'GOOD' THEN 1
        WHEN 'FINE' THEN 2
        WHEN 'BAD' THEN 3
    END;

-- //////////////////////////////////////////////////////////////
/*
SELECT booking_id, payment_ratio
FROM booking_payment_ratio;

SELECT *
FROM booking_payment_ratio
ORDER BY payment_ratio DESC;

DESCRIBE booking_payment_ratio;

SHOW CREATE VIEW booking_payment_ratio;
*/

SELECT
    makse_id,
    broneeringu_id,
    makse_aeg,
    makstud_summa
FROM Payment;