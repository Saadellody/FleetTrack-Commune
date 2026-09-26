-- ---------------------------------------------------------------------
-- Table : vehicle_assignments
-- ---------------------------------------------------------------------
CREATE TABLE vehicle_assignments (
                                     id          BIGSERIAL PRIMARY KEY,
                                     vehicle_id  BIGINT NOT NULL,
                                     user_id     BIGINT NOT NULL,
                                     start_date  DATE NOT NULL,
                                     end_date    DATE,
                                     active      BOOLEAN NOT NULL DEFAULT true,

                                     CONSTRAINT fk_vehicle_assignments_vehicle
                                         FOREIGN KEY (vehicle_id) REFERENCES vehicles (id),
                                     CONSTRAINT fk_vehicle_assignments_user
                                         FOREIGN KEY (user_id) REFERENCES users (id)
);