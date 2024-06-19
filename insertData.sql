
/* SCRIPT GENERATE ROOM VALUES*/
DO $$
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO room (nameRoom, descriptionRoom, capacity, rowsNumber, columnsNumber)
        VALUES (
            'Room ' || i, -- Genera un nombre único para cada habitación
            'Description for Room ' || i, -- Descripción única
            (RANDOM() * 50)::INTEGER + 10, -- Capacidad aleatoria entre 10 y 60
            (RANDOM() * 10)::INTEGER + 5,  -- Número de filas aleatorio entre 5 y 15
            (RANDOM() * 10)::INTEGER + 5   -- Número de columnas aleatorio entre 5 y 15
        );
    END LOOP;
END $$;

/*SCRIPT GENERATE USERS VALUES*/

DO $$
DECLARE
    names TEXT[] := ARRAY['John', 'Jane', 'Alice', 'Bob', 'Charlie', 'David', 'Eva', 'Frank', 'Grace', 'Hannah'];
    lastNames TEXT[] := ARRAY['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez'];
    i INTEGER;
    randomName TEXT;
    randomLastName TEXT;
    randomEmail TEXT;
BEGIN
    FOR i IN 1..100 LOOP
        randomName := names[(random() * 9 + 1)::INTEGER];
        randomLastName := lastNames[(random() * 9 + 1)::INTEGER];
        randomEmail := lower(randomName || '.' || randomLastName || '@example.com');
        INSERT INTO users (nameUser, lastNameUser, emailUser)
        VALUES (randomName, randomLastName, randomEmail);
    END LOOP;
END $$;

SELECT * FROM users

/* SCRIPT GENERATE WORKSPACE VALUES*/

DO $$
DECLARE
    roomID_range INTEGER := 100;  -- Suponiendo que tenemos 100 habitaciones con roomID del 1 al 100
    row_max INTEGER := 10;        -- Máximo número de filas, puede ajustarse según los datos reales de `room`
    column_max INTEGER := 20;     -- Máximo número de columnas, puede ajustarse según los datos reales de `room`
    i INTEGER;
    randomRoomID INTEGER;
    randomRowPosition INTEGER;
    randomColumnPosition INTEGER;
BEGIN
    FOR i IN 1..100 LOOP
        randomRoomID := (random() * (roomID_range - 1) + 1)::INTEGER;
        randomRowPosition := (random() * (row_max - 1) + 1)::INTEGER;
        randomColumnPosition := (random() * (column_max - 1) + 1)::INTEGER;
        
        INSERT INTO workspace (roomID, rowPosition, columnPosition)
        VALUES (randomRoomID, randomRowPosition, randomColumnPosition);
    END LOOP;
END $$;

/* SCRIPT GENERATE  SESSION VALUES */

DO $$
DECLARE
    i INTEGER;
    randomStartHour TIMESTAMP;
    randomEndHour TIMESTAMP;
    startTime TIMESTAMP := '2024-06-19 07:00:00';  -- Hora de inicio permitida (7am)
    endTime TIMESTAMP := '2024-06-19 22:00:00';    -- Hora de fin permitida (10pm)
    maxDuration INTERVAL := '5 hours';             -- Duración máxima de la sesión (5 horas)
BEGIN
    FOR i IN 1..100 LOOP
        randomStartHour := startTime + (random() * (endTime - startTime));
        randomEndHour := randomStartHour + (random() * maxDuration);
        
        -- Asegurarse de que endHour no pase de las 10pm
        IF randomEndHour > endTime THEN
            randomEndHour := endTime;
        END IF;
        
        INSERT INTO session (startHour, endHour)
        VALUES (randomStartHour, randomEndHour);
    END LOOP;
END $$;

/* SCRIPT GENERATE RESERVATION VALUES */

DO $$
DECLARE
    statusArray TEXT[] := ARRAY['opened', 'closed', 'canceled', 'progress'];
    i INTEGER;
    randomUserID INTEGER;
    randomWorkspaceID INTEGER;
    randomSessionID INTEGER;
    randomStatus TEXT;
BEGIN
    FOR i IN 1..100 LOOP
        randomUserID := (SELECT userID FROM users ORDER BY RANDOM() LIMIT 1);
        randomWorkspaceID := (SELECT workspaceID FROM workspace ORDER BY RANDOM() LIMIT 1);
        randomSessionID := (SELECT sessionID FROM session ORDER BY RANDOM() LIMIT 1);
        randomStatus := statusArray[(random() * 3 + 1)::INTEGER];
        
        INSERT INTO reservation (userID, workspaceID, sessionID, status)
        VALUES (randomUserID, randomWorkspaceID, randomSessionID, randomStatus);
    END LOOP;
END $$;
