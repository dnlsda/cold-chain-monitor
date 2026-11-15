BEGIN;

CREATE TABLE cold_rooms (
    room_id TEXT PRIMARY KEY,
    room_name TEXT NOT NULL
);

CREATE TABLE batches (
    batch_id TEXT PRIMARY KEY,
    meal_name TEXT NOT NULL,
    portions INTEGER NOT NULL CHECK (portions > 0)
);

CREATE TABLE batch_storage (
    batch_id TEXT REFERENCES batches (batch_id),
    room_id TEXT NOT NULL REFERENCES cold_rooms (room_id),
    stored_at TIMESTAMPTZ NOT NULL,
    removed_at TIMESTAMPTZ,
    PRIMARY KEY (batch_id, stored_at),
    CHECK (removed_at IS NULL OR removed_at > stored_at)
);

CREATE UNIQUE INDEX one_active_batch_per_room
    ON batch_storage (room_id)
    WHERE removed_at IS NULL;

INSERT INTO cold_rooms (room_id, room_name)
VALUES
    ('cold-01', 'Chłodnia 1'),
    ('cold-02', 'Chłodnia 2');

INSERT INTO batches (batch_id, meal_name, portions)
VALUES
    ('CAT-001', 'Kurczak z ryżem i warzywami', 40),
    ('CAT-002', 'Makaron z sosem pomidorowym', 35);

INSERT INTO batch_storage (batch_id, room_id, stored_at)
VALUES
    ('CAT-001', 'cold-01', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
    ('CAT-002', 'cold-02', CURRENT_TIMESTAMP - INTERVAL '1 hour');

COMMIT;
