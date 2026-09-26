-- ---------------------------------------------------------------------
-- Table : vehicles
-- ---------------------------------------------------------------------
CREATE TABLE vehicles (
                          id                      BIGSERIAL PRIMARY KEY,
                          registration_number     VARCHAR(20) NOT NULL,
                          brand                   VARCHAR(50),
                          model                   VARCHAR(50),
                          type                    VARCHAR(50),
                          year                    INT,
                          service_start_date      DATE,
                          current_mileage         INT NOT NULL DEFAULT 0,
                          status                  VARCHAR(30),
                          created_at              TIMESTAMP NOT NULL DEFAULT now(),
                          updated_at              TIMESTAMP,

                          CONSTRAINT uq_vehicles_registration_number UNIQUE (registration_number),
                          CONSTRAINT chk_vehicles_status CHECK (status IN (
                                                                           'EN_SERVICE', 'HORS_SERVICE', 'EN_MAINTENANCE'
                              ))
);