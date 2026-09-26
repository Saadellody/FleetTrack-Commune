-- ---------------------------------------------------------------------
-- Table : expenses (table centrale)
-- ---------------------------------------------------------------------
CREATE TABLE expenses (
                          id                  BIGSERIAL PRIMARY KEY,
                          vehicle_id          BIGINT NOT NULL,
                          type                VARCHAR(30) NOT NULL,
                          declared_amount     NUMERIC(10,2) NOT NULL,
                          justified_amount    NUMERIC(10,2),
                          gap_amount          NUMERIC(10,2),
                          expense_date        DATE NOT NULL,
                          mileage             INT,
                          description         TEXT,
                          status              VARCHAR(40) NOT NULL,
                          created_by          BIGINT NOT NULL,
                          verified_by         BIGINT,
                          rejection_reason    TEXT,
                          created_at          TIMESTAMP NOT NULL DEFAULT now(),
                          updated_at          TIMESTAMP,

                          CONSTRAINT fk_expenses_vehicle
                              FOREIGN KEY (vehicle_id) REFERENCES vehicles (id),
                          CONSTRAINT fk_expenses_created_by
                              FOREIGN KEY (created_by) REFERENCES users (id),
                          CONSTRAINT fk_expenses_verified_by
                              FOREIGN KEY (verified_by) REFERENCES users (id),
                          CONSTRAINT chk_expenses_type CHECK (type IN (
                                                                       'CARBURANT', 'VIDANGE', 'LAVAGE', 'ENTRETIEN', 'REPARATION',
                                                                       'PIECES_DE_RECHANGE', 'PNEUS', 'BATTERIE', 'AUTRE'
                              )),
                          CONSTRAINT chk_expenses_status CHECK (status IN (
                                                                           'BROUILLON', 'EN_ATTENTE_JUSTIFICATION', 'JUSTIFIEE', 'EN_VERIFICATION',
                                                                           'CORRECTION_DEMANDEE', 'VALIDEE', 'REJETEE', 'ANNULEE'
                              ))
);

CREATE INDEX idx_expenses_vehicle_id ON expenses (vehicle_id);
CREATE INDEX idx_expenses_status ON expenses (status);
CREATE INDEX idx_expenses_created_by ON expenses (created_by);