-- 1.1 Create view
CREATE OR REPLACE VIEW guest_stays AS
SELECT
    g.guest_id,
    COUNT(b.booking_id) AS times_stayed
FROM Guest g
LEFT JOIN Booking b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_id;

-- 1.2 Show guest name and number of stays
SELECT
    g.name,
    gs.times_stayed
FROM Guest g
JOIN guest_stays gs
    ON g.guest_id = gs.guest_id
ORDER BY gs.times_stayed DESC;