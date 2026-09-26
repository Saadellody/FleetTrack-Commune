-- ---------------------------------------------------------------------
-- Table : justifications (polymorphe : dépense OU vignette, jamais les deux)
-- ---------------------------------------------------------------------
CREATE TABLE justifications (
                                id                  BIGSERIAL PRIMARY KEY,
                                expense_id          BIGINT,
                                fuel_voucher_id     BIGINT,
                                file_path           VARCHAR(500) NOT NULL,
                                file_type           VARCHAR(20),
                                amount              NUMERIC(10,2),
                                uploaded_by         BIGINT NOT NULL,
                                uploaded_at         TIMESTAMP NOT NULL DEFAULT now(),

                                CONSTRAINT fk_justifications_expense
                                    FOREIGN KEY (expense_id) REFERENCES expenses (id),
                                CONSTRAINT fk_justifications_fuel_voucher
                                    FOREIGN KEY (fuel_voucher_id) REFERENCES fuel_vouchers (id),
                                CONSTRAINT fk_justifications_uploaded_by
                                    FOREIGN KEY (uploaded_by) REFERENCES users (id),
                                CONSTRAINT chk_justifications_exactly_one_parent CHECK (
                                    (expense_id IS NOT NULL) <> (fuel_voucher_id IS NOT NULL)
                                    )
);

CREATE INDEX idx_justifications_expense_id ON justifications (expense_id);
CREATE INDEX idx_justifications_fuel_voucher_id ON justifications (fuel_voucher_id);