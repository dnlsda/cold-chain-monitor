CREATE TABLE temperature_excursions (
    room_id TEXT NOT NULL REFERENCES cold_rooms (room_id),
    measured_at TIMESTAMPTZ NOT NULL,
    batch_id TEXT REFERENCES batches (batch_id),
    temperature_c DOUBLE PRECISION NOT NULL,
    threshold_c DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (room_id, measured_at),
    CHECK (temperature_c > threshold_c)
);