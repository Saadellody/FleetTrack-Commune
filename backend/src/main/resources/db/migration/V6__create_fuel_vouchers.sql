-- ---------------------------------------------------------------------
-- Table : fuel_vouchers
-- ---------------------------------------------------------------------
CREATE TABLE fuel_vouchers (
                               id                  BIGSERIAL PRIMARY KEY,
                               voucher_number      VARCHAR(30) NOT NULL,
                               vehicle_id          BIGINT NOT NULL,
                               allocated_amount    NUMERIC(10,2) NOT NULL,
                               allocation_date     DATE NOT NULL,
                               period              VARCHAR(20),
                               responsible_id      BIGINT,
                               consumed_amount     NUMERIC(10,2),
                               justified_amount    NUMERIC(10,2),
                               gap_amount          NUMERIC(10,2),
                               status              VARCHAR(30),
                               created_at          TIMESTAMP NOT NULL DEFAULT now(),

                               CONSTRAINT uq_fuel_vouchers_voucher_number UNIQUE (voucher_number),
                               CONSTRAINT fk_fuel_vouchers_vehicle
                                   FOREIGN KEY (vehicle_id) REFERENCES vehicles (id),
                               CONSTRAINT fk_fuel_vouchers_responsible
                                   FOREIGN KEY (responsible_id) REFERENCES users (id),
                               CONSTRAINT chk_fuel_vouchers_status CHECK (status IN (
                                                                                     'CREEE', 'AFFECTEE', 'EN_UTILISATION', 'PARTIELLEMENT_JUSTIFIEE',
                                                                                     'JUSTIFIEE', 'EN_VERIFICATION', 'VALIDEE', 'ECART_A_VERIFIER', 'CLOTUREE'
                                   ))
);

CREATE INDEX idx_fuel_vouchers_vehicle_id ON fuel_vouchers (vehicle_id);