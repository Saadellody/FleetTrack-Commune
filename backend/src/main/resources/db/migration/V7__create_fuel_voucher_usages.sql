-- ---------------------------------------------------------------------
-- Table : fuel_voucher_usages
-- ---------------------------------------------------------------------
CREATE TABLE fuel_voucher_usages (
    id                  BIGSERIAL PRIMARY KEY,
    fuel_voucher_id     BIGINT NOT NULL,
    amount              NUMERIC(10,2) NOT NULL,
    usage_date          DATE NOT NULL,
    description         TEXT,
    created_by          BIGINT,

    CONSTRAINT fk_fuel_voucher_usages_voucher
        FOREIGN KEY (fuel_voucher_id) REFERENCES fuel_vouchers (id),
    CONSTRAINT fk_fuel_voucher_usages_created_by
        FOREIGN KEY (created_by) REFERENCES users (id)
);

CREATE INDEX idx_fuel_voucher_usages_voucher_id ON fuel_voucher_usages (fuel_voucher_id);