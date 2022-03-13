USE album;
DROP FUNCTION IF EXISTS track_len;

DELIMITER //
CREATE FUNCTION track_len(seconds INT)
RETURNS VARCHAR(16)
DETERMINISTIC
BEGIN
	RETURN CONCAT_WS(':', seconds DIV 60, LPAD(seconds MOD 60, 2, '0'));
END //
DELIMITER ;

SELECT title, duration AS secs, track_len(duration) AS len
	FROM track ORDER BY duration DESC;
    
SELECT a.artist AS artist,
		a.title AS album,
		t.title AS track, 
		t.track_number AS trackno,
		track_len(t.duration) AS length
	FROM track AS t
	JOIN album AS a
		ON a.id = t.album_id
	ORDER BY artist, album, trackno
;

SELECT a.artist AS artist,
		a.title AS album,
        track_len(SUM(duration)) AS length
	FROM track AS t
    JOIN album AS a
		ON a.id = t.album_id
	GROUP BY a.id
    ORDER BY artist, album
;

SHOW FUNCTION STATUS WHERE DEFINER LIKE 'admin%';

