/* Ver la lista de espacios de trabajo disponibles de una sala en una
sesión x. */

SELECT w.workspaceID, w.roomID, w.rowPosition, w.columnPosition
FROM workspace w
WHERE w.roomID = 99
  AND w.workspaceID NOT IN (
    SELECT r.workspaceID
    FROM reservation r
    WHERE r.sessionID = 3
  )
ORDER BY w.workspaceID;

/* Ver la lista de espacios de trabajo ocupados de una sala en una
sesión x. */

SELECT w.workspaceID, w.roomID, w.rowPosition, w.columnPosition
FROM workspace w
JOIN reservation r ON w.workspaceID = r.workspaceID
JOIN session s ON r.sessionID = s.sessionID
WHERE w.roomID = 4
  AND s.sessionID = 43
ORDER BY w.workspaceID;

/* Ver las sesiones con orden por las más ocupadas.*/

SELECT s.sessionID, s.startHour, s.endHour, COUNT(r.reservationID) AS cantidad_reservas
FROM session s
LEFT JOIN reservation r ON s.sessionID = r.sessionID
GROUP BY s.sessionID, s.startHour, s.endHour
ORDER BY cantidad_reservas DESC;

/* Ver las sesiones con orden por las más disponibles. */

SELECT s.sessionID, s.startHour, s.endHour, COUNT(r.reservationID) AS cantidad_reservas
FROM session s
LEFT JOIN reservation r ON s.sessionID = r.sessionID
GROUP BY s.sessionID, s.startHour, s.endHour
ORDER BY cantidad_reservas ASC;

/* Ver la lista de espacios de trabajo asignados a un usuario. */
SELECT w.workspaceID, w.roomID, w.rowPosition, w.columnPosition
FROM workspace w
JOIN reservation r ON w.workspaceID = r.workspaceID
JOIN users u ON r.userID = u.userID
WHERE u.userID = 11
ORDER BY w.workspaceID;

/* Ver la lista de espacios de trabajo asignados a una sesión. */

SELECT w.workspaceID, w.roomID, w.rowPosition, w.columnPosition
FROM workspace w
JOIN reservation r ON w.workspaceID = r.workspaceID
JOIN session s ON r.sessionID = s.sessionID
WHERE s.sessionID = 63
ORDER BY w.workspaceID;
