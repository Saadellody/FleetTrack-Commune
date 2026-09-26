-- ---------------------------------------------------------------------
-- Table : mileage_records
-- ---------------------------------------------------------------------
CREATE TABLE mileage_records (
                                 id                  BIGSERIAL PRIMARY KEY,
                                 vehicle_id          BIGINT NOT NULL,
                                 mileage             INT NOT NULL,
                                 record_date         DATE NOT NULL,
                                 related_expense_id  BIGINT,
                                 notes               TEXT,

                                 CONSTRAINT fk_mileage_records_vehicle
                                     FOREIGN KEY (vehicle_id) REFERENCES vehicles (id),
                                 CONSTRAINT fk_mileage_records_expense
                                     FOREIGN KEY (related_expense_id) REFERENCES expenses (id)
);

CREATE INDEX idx_mileage_records_vehicle_id ON mileage_records (vehicle_id);