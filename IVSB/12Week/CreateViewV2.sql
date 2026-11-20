CREATE OR REPLACE VIEW booking_payment_ratio AS
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
    
-- -----------------------------------------------------
DELIMITER //

CREATE FUNCTION guest_trustworthiness(client_id INT)
RETURNS VARCHAR(10)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE partially_unpaid INT DEFAULT 0;
    DECLARE totally_unpaid INT DEFAULT 0;

    SELECT
        COALESCE(SUM(
            CASE
                WHEN payment_ratio > 0 AND payment_ratio < 1
                THEN 1 ELSE 0
            END
        ), 0),
        COALESCE(SUM(
            CASE
                WHEN payment_ratio = 0
                THEN 1 ELSE 0
            END
        ), 0)
    INTO partially_unpaid, totally_unpaid
    FROM booking_payment_ratio
    WHERE guest_id = client_id;

    IF partially_unpaid > 5 OR totally_unpaid > 1 THEN
        RETURN 'BAD';

    ELSEIF partially_unpaid > 2 OR totally_unpaid > 0 THEN
        RETURN 'FINE';

    ELSE
        RETURN 'GOOD';
    END IF;
END //

DELIMITER ;


-- -------------------------------------------------------

SELECT
    g.name,
    guest_trustworthiness(g.guest_id) AS trustworthiness
FROM Guest g
ORDER BY
    CASE guest_trustworthiness(g.guest_id)
        WHEN 'GOOD' THEN 1
        WHEN 'FINE' THEN 2
        WHEN 'BAD' THEN 3
    END;